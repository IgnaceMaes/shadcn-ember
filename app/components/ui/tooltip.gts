import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import type { TOC } from '@ember/component/template-only';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';
import { cn } from '@/lib/utils';
import {
  computePosition,
  flip,
  shift,
  offset,
  arrow,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';

const TooltipContext = 'tooltip-context' as const;

interface TooltipContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
}

interface ContextRegistry {
  [TooltipContext]: TooltipContextValue;
}

interface TooltipProviderSignature {
  Args: {
    delayDuration?: number;
    skipDelayDuration?: number;
  };
  Blocks: {
    default: [];
  };
}

const TooltipProvider: TOC<TooltipProviderSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

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
  @tracked currentOpen: boolean;
  @tracked isOpenOrClosing = false;
  triggerElement: HTMLElement | null = null;

  constructor(owner: Owner, args: TooltipSignature['Args']) {
    super(owner, args);
    this.currentOpen = args.open ?? args.defaultOpen ?? false;
  }

  get isOpen() {
    return this.args.open ?? this.currentOpen;
  }

  get isRendered() {
    return this.isOpen || this.isOpenOrClosing;
  }

  setOpen = (open: boolean) => {
    if (open) {
      this.isOpenOrClosing = true;
      this.currentOpen = true;
    } else {
      this.currentOpen = false;
    }
    this.args.onOpenChange?.(open);
  };

  finishClose = () => {
    if (!this.isOpen) {
      this.isOpenOrClosing = false;
    }
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
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

  handleMouseLeave = () => {
    this.context.setOpen(false);
  };

  handleFocus = () => {
    this.context.setOpen(true);
  };

  handleBlur = () => {
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
        data-slot="tooltip-trigger"
        class={{cn "inline-block" @class}}
        {{this.registerElement}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
        ...attributes
      >
        {{yield}}
      </span>
    {{else}}
      <span
        data-slot="tooltip-trigger"
        class={{cn "inline-block" @class}}
        {{this.registerElement}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
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
  @tracked arrowX = 0;
  @tracked arrowY = 0;
  cleanup?: () => void;
  arrowElement: HTMLElement | null = null;

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
          offset(this.args.sideOffset ?? 4),
          flip(),
          shift({ padding: 8 }),
          arrow({ element: this.arrowElement! }),
        ],
      }).then(({ x, y, middlewareData }) => {
        this.x = x;
        this.y = y;

        if (middlewareData.arrow && this.arrowElement) {
          this.arrowX = middlewareData.arrow.x ?? 0;
          this.arrowY = middlewareData.arrow.y ?? 0;
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
    return htmlSafe(`left: ${this.arrowX}px; top: ${this.arrowY}px;`);
  }

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.context.isOpen) {
      this.context.finishClose();
    }
  };

  <template>
    {{#if this.context.isRendered}}
      <div
        data-slot="tooltip-content"
        class={{cn
          "z-50 overflow-hidden rounded-md bg-foreground px-3 py-1.5 text-xs text-background data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95"
          @class
        }}
        data-side={{if @side @side "top"}}
        data-align={{if @align @align "center"}}
        data-state={{if this.context.isOpen "open" "closed"}}
        style={{this.positionStyle}}
        role="tooltip"
        {{this.positionContent}}
        {{on "animationend" this.handleAnimationEnd}}
        ...attributes
      >
        {{yield}}
        <div
          class="absolute bg-foreground size-2 rotate-45"
          style={{this.arrowStyle}}
          {{this.arrowModifier}}
        ></div>
      </div>
    {{/if}}
  </template>
}

export { Tooltip, TooltipTrigger, TooltipContent, TooltipProvider };
