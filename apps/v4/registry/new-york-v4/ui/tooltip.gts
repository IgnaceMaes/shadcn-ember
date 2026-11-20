import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import {
  computePosition,
  flip,
  shift,
  offset,
  arrow,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';

import { cn } from '@/lib/utils';

const TooltipContext = 'tooltip-context' as const;

interface TooltipContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  setContentElement: (element: HTMLElement | null) => void;
  onTriggerLeave: (event: MouseEvent) => void;
  onContentLeave: (event: MouseEvent) => void;
}

interface Point {
  x: number;
  y: number;
}

type Side = 'top' | 'right' | 'bottom' | 'left';

function getExitSideFromRect(point: Point, rect: DOMRect): Side {
  const top = Math.abs(rect.top - point.y);
  const bottom = Math.abs(rect.bottom - point.y);
  const right = Math.abs(rect.right - point.x);
  const left = Math.abs(rect.left - point.x);
  const min = Math.min(top, bottom, right, left);
  if (min === left) return 'left';
  if (min === right) return 'right';
  if (min === top) return 'top';
  return 'bottom';
}

function getPaddedExitPoints(exitPoint: Point, exitSide: Side, padding = 5) {
  const { x, y } = exitPoint;
  switch (exitSide) {
    case 'top':
      return [
        { x: x - padding, y: y + padding },
        { x: x + padding, y: y + padding },
      ];
    case 'bottom':
      return [
        { x: x - padding, y: y - padding },
        { x: x + padding, y: y - padding },
      ];
    case 'left':
      return [
        { x: x + padding, y: y - padding },
        { x: x + padding, y: y + padding },
      ];
    case 'right':
      return [
        { x: x - padding, y: y - padding },
        { x: x - padding, y: y + padding },
      ];
  }
}

function getPointsFromRect(rect: DOMRect): Point[] {
  const { top, right, bottom, left } = rect;
  return [
    { x: left, y: top },
    { x: right, y: top },
    { x: right, y: bottom },
    { x: left, y: bottom },
  ];
}

// Ray casting: https://github.com/substack/point-in-polygon (MIT)
function isPointInPolygon(point: Point, polygon: Point[]) {
  const { x, y } = point;
  let inside = false;
  for (let i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    const { x: xi, y: yi } = polygon[i]!;
    const { x: xj, y: yj } = polygon[j]!;
    const intersect =
      yi > y !== yj > y && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi;
    if (intersect) inside = !inside;
  }
  return inside;
}

// Andrew's monotone chain convex hull
function getHull(points: Point[]): Point[] {
  const sorted = points
    .slice()
    .sort((a, b) => (a.x === b.x ? a.y - b.y : a.x - b.x));
  if (sorted.length <= 1) return sorted;

  const cross = (o: Point, a: Point, b: Point) =>
    (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);

  const upper: Point[] = [];
  for (const p of sorted) {
    while (
      upper.length >= 2 &&
      cross(upper[upper.length - 2]!, upper[upper.length - 1]!, p) <= 0
    ) {
      upper.pop();
    }
    upper.push(p);
  }
  upper.pop();

  const lower: Point[] = [];
  for (let i = sorted.length - 1; i >= 0; i--) {
    const p = sorted[i]!;
    while (
      lower.length >= 2 &&
      cross(lower[lower.length - 2]!, lower[lower.length - 1]!, p) <= 0
    ) {
      lower.pop();
    }
    lower.push(p);
  }
  lower.pop();

  if (
    upper.length === 1 &&
    lower.length === 1 &&
    upper[0]!.x === lower[0]!.x &&
    upper[0]!.y === lower[0]!.y
  ) {
    return upper;
  }
  return upper.concat(lower);
}

interface ContextRegistry {
  [TooltipContext]: TooltipContextValue;
}

interface TooltipSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class Tooltip extends Component<TooltipSignature> {
  @tracked currentOpen?: boolean;
  @tracked isOpenOrClosing = false;
  triggerElement: HTMLElement | null = null;
  contentElement: HTMLElement | null = null;
  graceArea: Point[] | null = null;

  get isOpen() {
    return this.args.open ?? this.currentOpen ?? this.args.defaultOpen ?? false;
  }

  get isRendered() {
    return this.isOpen || this.isOpenOrClosing;
  }

  willDestroy() {
    super.willDestroy();
    this.removeGraceArea();
  }

  setOpen = (open: boolean) => {
    this.removeGraceArea();
    if (open) {
      this.isOpenOrClosing = true;
    }
    this.currentOpen = open;
    this.args.onOpenChange?.(open);
  };

  // Keep the tooltip open while the pointer travels between the trigger and
  // the content, by tracking it within the polygon spanning the exit point
  // and the element being moved towards (mirrors Radix's hoverable content).
  createGraceArea = (event: MouseEvent, hoverTarget: HTMLElement | null) => {
    const currentTarget = event.currentTarget as HTMLElement | null;
    if (!this.isOpen || !hoverTarget || !currentTarget) {
      this.setOpen(false);
      return;
    }

    const exitPoint = { x: event.clientX, y: event.clientY };
    const exitSide = getExitSideFromRect(
      exitPoint,
      currentTarget.getBoundingClientRect()
    );
    this.removeGraceArea();
    this.graceArea = getHull([
      ...getPaddedExitPoints(exitPoint, exitSide),
      ...getPointsFromRect(hoverTarget.getBoundingClientRect()),
    ]);
    document.addEventListener('pointermove', this.trackPointerGrace);
  };

  removeGraceArea = () => {
    this.graceArea = null;
    document.removeEventListener('pointermove', this.trackPointerGrace);
  };

  trackPointerGrace = (event: PointerEvent) => {
    if (!this.graceArea) return;

    const target = event.target as Node;
    const hasEnteredTarget =
      this.triggerElement?.contains(target) ||
      this.contentElement?.contains(target);
    const isPointerOutsideGraceArea = !isPointInPolygon(
      { x: event.clientX, y: event.clientY },
      this.graceArea
    );

    if (hasEnteredTarget) {
      this.removeGraceArea();
    } else if (isPointerOutsideGraceArea) {
      this.setOpen(false);
    }
  };

  onTriggerLeave = (event: MouseEvent) => {
    this.createGraceArea(event, this.contentElement);
  };

  onContentLeave = (event: MouseEvent) => {
    this.createGraceArea(event, this.triggerElement);
  };

  finishClose = () => {
    if (!this.isOpen) {
      this.isOpenOrClosing = false;
    }
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  setContentElement = (element: HTMLElement | null) => {
    this.contentElement = element;
  };

  @cached
  @provide(TooltipContext)
  get context(): TooltipContextValue {
    return {
      isOpen: this.isOpen,
      isRendered: this.isRendered,
      setOpen: this.setOpen,
      finishClose: this.finishClose,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
      setContentElement: this.setContentElement,
      onTriggerLeave: this.onTriggerLeave,
      onContentLeave: this.onContentLeave,
    };
  }

  <template>
    <div data-slot="tooltip">
      {{yield}}
    </div>
  </template>
}

interface TooltipTriggerSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class TooltipTrigger extends Component<TooltipTriggerSignature> {
  @consume(TooltipContext) context!: ContextRegistry[typeof TooltipContext];

  handleMouseEnter = () => {
    this.context.setOpen(true);
  };

  handleMouseLeave = (event: MouseEvent) => {
    this.context.onTriggerLeave(event);
  };

  handleFocus = () => {
    this.context.setOpen(true);
  };

  handleBlur = () => {
    this.context.setOpen(false);
  };

  handlePointerDown = () => {
    this.context.setOpen(false);
  };

  registerElement = modifier((element: HTMLElement) => {
    this.context.setTriggerElement(element);
    return () => {
      this.context.setTriggerElement(null);
    };
  });

  <template>
    {{#if @asChild}}
      <span
        class={{cn "inline-block" @class}}
        data-slot="tooltip-trigger"
        {{on "blur" this.handleBlur}}
        {{on "focus" this.handleFocus}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{! template-lint-disable no-pointer-down-event-binding }}
        {{on "pointerdown" this.handlePointerDown}}
        {{this.registerElement}}
        ...attributes
      >
        {{yield}}
      </span>
    {{else}}
      <span
        class={{cn "inline-block" @class}}
        data-slot="tooltip-trigger"
        {{on "blur" this.handleBlur}}
        {{on "focus" this.handleFocus}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{! template-lint-disable no-pointer-down-event-binding }}
        {{on "pointerdown" this.handlePointerDown}}
        {{this.registerElement}}
        ...attributes
      >
        {{yield}}
      </span>
    {{/if}}
  </template>
}

interface TooltipContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    side?: 'top' | 'right' | 'bottom' | 'left';
    align?: 'start' | 'center' | 'end';
    sideOffset?: number;
  };
  Blocks: {
    default: [];
  };
}

class TooltipContent extends Component<TooltipContentSignature> {
  @consume(TooltipContext) context!: ContextRegistry[typeof TooltipContext];
  @tracked x = 0;
  @tracked y = 0;
  @tracked arrowX: number | undefined;
  @tracked arrowY: number | undefined;
  @tracked actualSide: 'top' | 'right' | 'bottom' | 'left' = 'top';
  cleanup?: () => void;
  arrowElement: HTMLElement | null = null;

  get destinationElement() {
    return document.body;
  }

  registerElement = modifier((element: HTMLElement) => {
    this.context.setContentElement(element);
    return () => {
      this.context.setContentElement(null);
    };
  });

  positionContent = modifier((element: HTMLElement) => {
    const triggerElement = this.context.triggerElement;
    if (!triggerElement) return;

    const align = this.args.align ?? 'center';
    const side = this.args.side ?? 'top';
    const placementMap: Record<string, Placement> = {
      'top-start': 'top-start',
      'top-center': 'top',
      'top-end': 'top-end',
      'right-start': 'right-start',
      'right-center': 'right',
      'right-end': 'right-end',
      'bottom-start': 'bottom-start',
      'bottom-center': 'bottom',
      'bottom-end': 'bottom-end',
      'left-start': 'left-start',
      'left-center': 'left',
      'left-end': 'left-end',
    };

    const placement = placementMap[`${side}-${align}`] || ('top' as Placement);

    const update = () => {
      void computePosition(triggerElement, element, {
        placement,
        strategy: 'fixed',
        middleware: [
          offset(this.args.sideOffset ?? 10),
          flip(),
          shift({ padding: 8 }),
          arrow({ element: this.arrowElement! }),
        ],
      }).then(({ x, y, placement: actualPlacement, middlewareData }) => {
        this.x = x;
        this.y = y;
        this.actualSide = actualPlacement.split('-')[0] as
          | 'top'
          | 'right'
          | 'bottom'
          | 'left';

        if (middlewareData.arrow) {
          this.arrowX = middlewareData.arrow.x;
          this.arrowY = middlewareData.arrow.y;
        }
      });
    };

    this.cleanup = autoUpdate(triggerElement, element, update);

    return () => {
      this.cleanup?.();
    };
  });

  arrowModifier = modifier((element: HTMLElement) => {
    this.arrowElement = element;
    return () => {
      this.arrowElement = null;
    };
  });

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 50;`
    );
  }

  get arrowStyle() {
    const side = this.actualSide;
    const styles: string[] = [];

    // For top/bottom placement, arrow x is set by floating-ui, y is at the edge
    // For left/right placement, arrow y is set by floating-ui, x is at the edge
    if (side === 'top' || side === 'bottom') {
      if (this.arrowX != null) {
        styles.push(`left: ${this.arrowX}px`);
      }
      if (side === 'top') {
        styles.push('bottom: -3px');
      } else {
        styles.push('top: -3px');
      }
    } else {
      if (this.arrowY != null) {
        styles.push(`top: ${this.arrowY}px`);
      }
      if (side === 'left') {
        styles.push('right: -3px');
      } else {
        styles.push('left: -3px');
      }
    }

    return htmlSafe(styles.join('; '));
  }

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.context.isOpen) {
      this.context.finishClose();
    }
  };

  handleMouseEnter = () => {
    this.context.setOpen(true);
  };

  handleMouseLeave = (event: MouseEvent) => {
    this.context.onContentLeave(event);
  };

  <template>
    {{#if this.context.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <div
          class={{cn
            "z-50 rounded-md bg-foreground px-3 py-1.5 text-xs text-background data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2"
            @class
          }}
          data-align={{if @align @align "center"}}
          data-side={{this.actualSide}}
          data-slot="tooltip-content"
          data-state={{if this.context.isOpen "open" "closed"}}
          role="tooltip"
          style={{this.positionStyle}}
          {{on "animationend" this.handleAnimationEnd}}
          {{on "mouseenter" this.handleMouseEnter}}
          {{on "mouseleave" this.handleMouseLeave}}
          {{this.positionContent}}
          {{this.registerElement}}
          ...attributes
        >
          {{yield}}
          <div
            class="absolute size-2.5 rotate-45 rounded-[2px] bg-foreground"
            style={{this.arrowStyle}}
            {{this.arrowModifier}}
          ></div>
        </div>
      {{/in-element}}
    {{/if}}
  </template>
}

export { Tooltip, TooltipTrigger, TooltipContent };
