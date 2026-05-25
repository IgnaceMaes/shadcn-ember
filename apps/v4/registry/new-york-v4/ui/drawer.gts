import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

type Direction = 'top' | 'right' | 'bottom' | 'left';

const CLOSE_THRESHOLD = 0.25;

const DrawerContext = 'drawer-context' as const;

interface DrawerContextValue {
  open: boolean;
  isRendered: boolean;
  direction: Direction;
  isDragging: boolean;
  dragOffset: number;
  closingFromDrag: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  onDragStart: (event: PointerEvent) => void;
}

interface ContextRegistry {
  [DrawerContext]: DrawerContextValue;
}

interface DrawerSignature {
  Args: {
    open?: boolean;
    direction?: Direction;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class Drawer extends Component<DrawerSignature> {
  @tracked isOpen = false;
  @tracked isOpenOrClosing = false;
  @tracked isDragging = false;
  @tracked dragOffset = 0;
  @tracked closingFromDrag = false;

  get open() {
    return this.args.open ?? this.isOpen;
  }

  get isRendered() {
    return this.open || this.isOpenOrClosing;
  }

  get direction(): Direction {
    return this.args.direction ?? 'bottom';
  }

  setOpen = (open: boolean) => {
    if (open) {
      this.isOpenOrClosing = true;
      this.isOpen = true;
    } else {
      this.isOpen = false;
    }
    this.args.onOpenChange?.(open);
  };

  finishClose = () => {
    if (!this.open) {
      this.isOpenOrClosing = false;
      this.closingFromDrag = false;
      this.isDragging = false;
      this.dragOffset = 0;
    }
  };

  onDragStart = (event: PointerEvent) => {
    const startPos = { x: event.clientX, y: event.clientY };
    const direction = this.direction;

    const onPointerMove = (e: PointerEvent) => {
      const dx = e.clientX - startPos.x;
      const dy = e.clientY - startPos.y;

      let offset: number;
      switch (direction) {
        case 'bottom':
          offset = Math.max(0, dy);
          break;
        case 'top':
          offset = Math.max(0, -dy);
          break;
        case 'right':
          offset = Math.max(0, dx);
          break;
        case 'left':
          offset = Math.max(0, -dx);
          break;
      }

      this.isDragging = true;
      this.dragOffset = offset;
    };

    const onPointerUp = () => {
      document.removeEventListener('pointermove', onPointerMove);
      document.removeEventListener('pointerup', onPointerUp);

      const contentEl = document.querySelector<HTMLElement>(
        '[data-slot="drawer-content"]'
      );

      if (contentEl) {
        const isVertical = direction === 'bottom' || direction === 'top';
        const size = isVertical
          ? contentEl.offsetHeight
          : contentEl.offsetWidth;

        if (this.dragOffset > size * CLOSE_THRESHOLD) {
          this.isDragging = false;
          this.closingFromDrag = true;
          this.dragOffset = size;
          this.setOpen(false);

          // Fallback: if transitionend doesn't fire, finishClose after timeout
          setTimeout(() => {
            if (this.closingFromDrag) {
              this.finishClose();
            }
          }, 300);
        } else {
          this.isDragging = false;
          this.dragOffset = 0;
        }
      } else {
        this.isDragging = false;
        this.dragOffset = 0;
      }
    };

    document.addEventListener('pointermove', onPointerMove);
    document.addEventListener('pointerup', onPointerUp);
  };

  @provide(DrawerContext)
  get context(): DrawerContextValue {
    return {
      open: this.open,
      isRendered: this.isRendered,
      direction: this.direction,
      isDragging: this.isDragging,
      dragOffset: this.dragOffset,
      closingFromDrag: this.closingFromDrag,
      setOpen: this.setOpen,
      finishClose: this.finishClose,
      onDragStart: this.onDragStart,
    };
  }

  <template>
    <div data-slot="drawer" data-vaul-drawer-direction={{this.direction}}>
      {{yield}}
    </div>
  </template>
}

interface DrawerTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DrawerTrigger extends Component<DrawerTriggerSignature> {
  @consume(DrawerContext) context!: ContextRegistry[typeof DrawerContext];

  handleClick = () => {
    this.context.setOpen(true);
  };

  <template>
    {{#if @asChild}}
      <span
        class="contents"
        data-slot="drawer-trigger"
        role="button"
        tabindex="0"
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
        ...attributes
      >
        {{yield (hash)}}
      </span>
    {{else}}
      <button
        class={{cn @class}}
        data-slot="drawer-trigger"
        type="button"
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface DrawerCloseSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DrawerClose extends Component<DrawerCloseSignature> {
  @consume(DrawerContext) context!: ContextRegistry[typeof DrawerContext];

  handleClick = () => {
    this.context.setOpen(false);
  };

  <template>
    {{#if @asChild}}
      <span
        class="contents"
        data-slot="drawer-close"
        role="button"
        tabindex="0"
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
        ...attributes
      >
        {{yield (hash)}}
      </span>
    {{else}}
      <button
        class={{cn @class}}
        data-slot="drawer-close"
        type="button"
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface DrawerPortalSignature {
  Blocks: {
    default: [];
  };
}

const DrawerPortal: TOC<DrawerPortalSignature> = <template>
  <div data-slot="drawer-portal">
    {{yield}}
  </div>
</template>;

interface DrawerOverlaySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class DrawerOverlay extends Component<DrawerOverlaySignature> {
  @consume(DrawerContext) context!: ContextRegistry[typeof DrawerContext];

  handleClick = () => {
    this.context.setOpen(false);
  };

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.context.open) {
      this.context.finishClose();
    }
  };

  get overlayStyle() {
    if (this.context.closingFromDrag) {
      return 'opacity: 0; transition: opacity 200ms ease-out; animation: none;';
    }
    if (this.context.isDragging) {
      const contentEl = document.querySelector<HTMLElement>(
        '[data-slot="drawer-content"]'
      );
      if (contentEl) {
        const isVertical =
          this.context.direction === 'bottom' ||
          this.context.direction === 'top';
        const size = isVertical
          ? contentEl.offsetHeight
          : contentEl.offsetWidth;
        const progress = Math.min(this.context.dragOffset / size, 1);
        const opacity = 1 - progress;
        return `opacity: ${opacity}; transition: none;`;
      }
    }
    return undefined;
  }

  <template>
    {{! template-lint-disable no-invalid-interactive }}
    <div
      class={{cn
        "data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 fixed inset-0 z-50 bg-black/10 supports-backdrop-filter:backdrop-blur-xs"
        @class
      }}
      data-slot="drawer-overlay"
      data-state={{if this.context.open "open" "closed"}}
      style={{this.overlayStyle}}
      {{on "animationend" this.handleAnimationEnd}}
      {{on "click" this.handleClick}}
      ...attributes
    ></div>
  </template>
}

interface DrawerContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class DrawerContent extends Component<DrawerContentSignature> {
  @consume(DrawerContext) context!: ContextRegistry[typeof DrawerContext];

  get destinationElement() {
    return document.body;
  }

  get classes() {
    return cn(
      'group/drawer-content data-[state=open]:animate-in data-[state=closed]:animate-out fixed z-50 flex h-auto flex-col bg-popover text-sm text-popover-foreground data-[vaul-drawer-direction=bottom]:inset-x-0 data-[vaul-drawer-direction=bottom]:bottom-0 data-[vaul-drawer-direction=bottom]:mt-24 data-[vaul-drawer-direction=bottom]:max-h-[80vh] data-[vaul-drawer-direction=bottom]:rounded-t-xl data-[vaul-drawer-direction=bottom]:border-t data-[vaul-drawer-direction=left]:inset-y-0 data-[vaul-drawer-direction=left]:left-0 data-[vaul-drawer-direction=left]:w-3/4 data-[vaul-drawer-direction=left]:rounded-r-xl data-[vaul-drawer-direction=left]:border-r data-[vaul-drawer-direction=right]:inset-y-0 data-[vaul-drawer-direction=right]:right-0 data-[vaul-drawer-direction=right]:w-3/4 data-[vaul-drawer-direction=right]:rounded-l-xl data-[vaul-drawer-direction=right]:border-l data-[vaul-drawer-direction=top]:inset-x-0 data-[vaul-drawer-direction=top]:top-0 data-[vaul-drawer-direction=top]:mb-24 data-[vaul-drawer-direction=top]:max-h-[80vh] data-[vaul-drawer-direction=top]:rounded-b-xl data-[vaul-drawer-direction=top]:border-b data-[vaul-drawer-direction=left]:sm:max-w-sm data-[vaul-drawer-direction=right]:sm:max-w-sm data-[vaul-drawer-direction=bottom]:data-[state=closed]:slide-out-to-bottom data-[vaul-drawer-direction=bottom]:data-[state=open]:slide-in-from-bottom data-[vaul-drawer-direction=top]:data-[state=closed]:slide-out-to-top data-[vaul-drawer-direction=top]:data-[state=open]:slide-in-from-top data-[vaul-drawer-direction=left]:data-[state=closed]:slide-out-to-left data-[vaul-drawer-direction=left]:data-[state=open]:slide-in-from-left data-[vaul-drawer-direction=right]:data-[state=closed]:slide-out-to-right data-[vaul-drawer-direction=right]:data-[state=open]:slide-in-from-right',
      this.args.class
    );
  }

  get contentStyle() {
    const offset = this.context.dragOffset;
    if (offset <= 0 && !this.context.closingFromDrag) {
      return undefined;
    }

    let transform: string;
    switch (this.context.direction) {
      case 'bottom':
        transform = `translateY(${offset}px)`;
        break;
      case 'top':
        transform = `translateY(-${offset}px)`;
        break;
      case 'right':
        transform = `translateX(${offset}px)`;
        break;
      case 'left':
        transform = `translateX(-${offset}px)`;
        break;
    }

    if (this.context.closingFromDrag) {
      return `transform: ${transform}; transition: transform 200ms ease-out; animation: none;`;
    }

    return `transform: ${transform}; transition: none; animation: none;`;
  }

  handlePointerDown = (event: PointerEvent) => {
    this.context.onDragStart(event);
  };

  scrollLock = modifier(
    (_element, _positional, { enabled = true }: { enabled?: boolean } = {}) => {
      if (!enabled) {
        return;
      }

      document.body.classList.add('overflow-hidden');

      return () => {
        document.body.classList.remove('overflow-hidden');
      };
    }
  );

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.context.open) {
      this.context.finishClose();
    }
  };

  handleTransitionEnd = (event: TransitionEvent) => {
    if (event.target === event.currentTarget && this.context.closingFromDrag) {
      this.context.finishClose();
    }
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Escape') {
      this.context.setOpen(false);
    }
  };

  <template>
    {{#if this.context.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <DrawerOverlay />
        <div
          aria-modal="true"
          class={{this.classes}}
          data-slot="drawer-content"
          data-state={{if this.context.open "open" "closed"}}
          data-vaul-drawer-direction={{this.context.direction}}
          role="dialog"
          style={{this.contentStyle}}
          tabindex="-1"
          {{on "animationend" this.handleAnimationEnd}}
          {{on "keydown" this.handleKeyDown}}
          {{! template-lint-disable no-pointer-down-event-binding }}
          {{on "pointerdown" this.handlePointerDown}}
          {{on "transitionend" this.handleTransitionEnd}}
          {{this.scrollLock enabled=this.context.open}}
          ...attributes
        >
          <div
            class="mx-auto mt-4 hidden h-1.5 w-25 shrink-0 cursor-grab rounded-full bg-muted active:cursor-grabbing group-data-[vaul-drawer-direction=bottom]/drawer-content:block"
          ></div>
          {{yield}}
        </div>
      {{/in-element}}
    {{/if}}
  </template>
}

interface DrawerHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DrawerHeader: TOC<DrawerHeaderSignature> = <template>
  <div
    class={{cn
      "flex flex-col gap-0.5 p-4 group-data-[vaul-drawer-direction=bottom]/drawer-content:text-center group-data-[vaul-drawer-direction=top]/drawer-content:text-center md:gap-1.5 md:text-left"
      @class
    }}
    data-slot="drawer-header"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface DrawerFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DrawerFooter: TOC<DrawerFooterSignature> = <template>
  <div
    class={{cn "mt-auto flex flex-col gap-2 p-4" @class}}
    data-slot="drawer-footer"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface DrawerTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DrawerTitle: TOC<DrawerTitleSignature> = <template>
  <h2
    class={{cn "cn-font-heading font-medium text-foreground" @class}}
    data-slot="drawer-title"
    ...attributes
  >
    {{yield}}
  </h2>
</template>;

interface DrawerDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DrawerDescription: TOC<DrawerDescriptionSignature> = <template>
  <p
    class={{cn "text-sm text-muted-foreground" @class}}
    data-slot="drawer-description"
    ...attributes
  >
    {{yield}}
  </p>
</template>;

export {
  Drawer,
  DrawerPortal,
  DrawerOverlay,
  DrawerTrigger,
  DrawerClose,
  DrawerContent,
  DrawerHeader,
  DrawerFooter,
  DrawerTitle,
  DrawerDescription,
};
