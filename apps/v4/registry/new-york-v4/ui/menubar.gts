import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import { and } from 'ember-truth-helpers';
import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate,
} from '@floating-ui/dom';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';

const MenubarContext = 'menubar-context' as const;
const MenubarMenuContext = 'menubar-menu-context' as const;
const MenubarGroupContext = 'menubar-group-context' as const;
const MenubarSubContext = 'menubar-sub-context' as const;
const SUBMENU_CLOSE_DELAY = 500;

interface MenubarContextValue {
  hasOpenMenu: boolean;
  openMenu: (id: symbol) => void;
  closeMenu: (id: symbol) => void;
  registerMenu: (id: symbol, closeCallback: () => void) => () => void;
}

interface MenubarMenuContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  closeAllSubmenus?: () => void;
  registerGroupCloseCallback?: (callback: () => void) => () => void;
  cancelPendingItemClose?: () => void;
  setPendingItemClose?: (timeout: ReturnType<typeof setTimeout>) => void;
}

interface MenubarGroupContextValue {
  closeAllSubmenus: () => void;
  registerSubmenu: (closeCallback: () => void) => () => void;
  setOpen: (open: boolean) => void;
}

interface MenubarSubContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  parentSetOpen: (open: boolean) => void;
  cancelPendingClose: () => void;
  setPendingClose: (timeout: ReturnType<typeof setTimeout>) => void;
}

interface ContextRegistry {
  [MenubarContext]: MenubarContextValue;
  [MenubarMenuContext]: MenubarMenuContextValue;
  [MenubarGroupContext]: MenubarGroupContextValue;
  [MenubarSubContext]: MenubarSubContextValue;
}

interface MenubarSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Menubar extends Component<MenubarSignature> {
  @tracked openMenuId: symbol | null = null;
  menuCloseCallbacks: Map<symbol, () => void> = new Map();

  get hasOpenMenu() {
    return this.openMenuId !== null;
  }

  openMenu = (id: symbol) => {
    if (this.openMenuId && this.openMenuId !== id) {
      const closeCallback = this.menuCloseCallbacks.get(this.openMenuId);
      closeCallback?.();
    }
    this.openMenuId = id;
  };

  closeMenu = (id: symbol) => {
    if (this.openMenuId === id) {
      this.openMenuId = null;
    }
  };

  registerMenu = (id: symbol, closeCallback: () => void) => {
    this.menuCloseCallbacks.set(id, closeCallback);
    return () => {
      this.menuCloseCallbacks.delete(id);
    };
  };

  @cached
  @provide(MenubarContext)
  get context(): MenubarContextValue {
    return {
      hasOpenMenu: this.hasOpenMenu,
      openMenu: this.openMenu,
      closeMenu: this.closeMenu,
      registerMenu: this.registerMenu,
    };
  }

  <template>
    <div
      class={{cn
        "flex h-9 items-center gap-1 rounded-md border p-1 shadow-xs"
        @class
      }}
      data-slot="menubar"
      role="menubar"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface MenubarMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class MenubarMenu extends Component<MenubarMenuSignature> {
  @consume(MenubarContext)
  menubarContext!: ContextRegistry[typeof MenubarContext];

  @tracked isOpen?: boolean;
  @tracked isRendered = false;
  triggerElement: HTMLElement | null = null;
  menuId = Symbol('menubar-menu');

  register = modifier(() => {
    const unregister = this.menubarContext.registerMenu(
      this.menuId,
      this.forceClose
    );
    return () => {
      unregister();
    };
  });

  forceClose = () => {
    this.isOpen = false;
    this.args.onOpenChange?.(false);
  };

  get open() {
    return this.args.open ?? this.isOpen ?? this.args.defaultOpen ?? false;
  }

  setOpen = (open: boolean) => {
    if (open) {
      this.menubarContext.openMenu(this.menuId);
      this.isRendered = true;
      this.isOpen = true;
    } else {
      this.menubarContext.closeMenu(this.menuId);
      this.isOpen = false;
    }
    this.args.onOpenChange?.(open);
  };

  finishClose = () => {
    if (!this.isOpen) {
      this.isRendered = false;
    }
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  @cached
  @provide(MenubarMenuContext)
  get context(): MenubarMenuContextValue {
    return {
      isOpen: this.open,
      isRendered: this.isRendered,
      setOpen: this.setOpen,
      finishClose: this.finishClose,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
    };
  }

  <template>
    {{! template-lint-disable no-yield-only }}
    <div data-slot="menubar-menu" {{this.register}}>
      {{yield}}
    </div>
  </template>
}

interface MenubarTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class MenubarTrigger extends Component<MenubarTriggerSignature> {
  @consume(MenubarMenuContext)
  context!: ContextRegistry[typeof MenubarMenuContext];

  @consume(MenubarContext)
  menubarContext!: ContextRegistry[typeof MenubarContext];

  handleClick = () => {
    this.context.setOpen(!this.context.isOpen);
  };

  handleMouseEnter = () => {
    if (this.menubarContext.hasOpenMenu && !this.context.isOpen) {
      this.context.setOpen(true);
    }
  };

  registerElement = modifier((element: HTMLElement) => {
    this.context.setTriggerElement(element);
    return () => {
      this.context.setTriggerElement(null);
    };
  });

  <template>
    <button
      aria-expanded={{if this.context.isOpen "true" "false"}}
      class={{cn
        "flex items-center rounded-sm px-2 py-1 text-sm font-medium outline-hidden select-none hover:bg-muted"
        @class
        (if this.context.isOpen "bg-muted")
      }}
      data-slot="menubar-trigger"
      type="button"
      {{on "click" this.handleClick}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{this.registerElement}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

interface MenubarGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class MenubarGroup extends Component<MenubarGroupSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  @tracked currentOpenSubmenu: symbol | null = null;
  submenuCloseCallbacks: Set<() => void> = new Set();

  register = modifier(() => {
    const unregister = this.menuContext.registerGroupCloseCallback?.(
      this.closeAllSubmenus
    );

    return () => {
      unregister?.();
    };
  });

  closeAllSubmenus = () => {
    this.currentOpenSubmenu = null;
    this.submenuCloseCallbacks.forEach((close) => close());
  };

  registerSubmenu = (closeCallback: () => void) => {
    this.submenuCloseCallbacks.add(closeCallback);
    return () => {
      this.submenuCloseCallbacks.delete(closeCallback);
    };
  };

  @cached
  @provide(MenubarGroupContext)
  get context(): MenubarGroupContextValue {
    return {
      closeAllSubmenus: this.closeAllSubmenus,
      registerSubmenu: this.registerSubmenu,
      setOpen: this.menuContext.setOpen,
    };
  }

  <template>
    <div
      class={{cn @class}}
      data-slot="menubar-group"
      role="group"
      {{this.register}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface MenubarPortalSignature {
  Blocks: {
    default: [];
  };
}

const MenubarPortal: TOC<MenubarPortalSignature> = <template>
  <div data-slot="menubar-portal">
    {{yield}}
  </div>
</template>;

interface MenubarSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class MenubarSub extends Component<MenubarSubSignature> {
  @consume(MenubarGroupContext)
  groupContext?: ContextRegistry[typeof MenubarGroupContext];

  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  @tracked isOpen?: boolean;
  @tracked isRendered = false;
  triggerElement: HTMLElement | null = null;
  closeTimeout?: ReturnType<typeof setTimeout>;

  get open() {
    return this.args.open ?? this.isOpen ?? this.args.defaultOpen ?? false;
  }

  register = modifier(() => {
    const unregister = this.groupContext?.registerSubmenu(() => {
      this.isOpen = false;
    });
    return () => {
      unregister?.();
      if (this.closeTimeout) {
        clearTimeout(this.closeTimeout);
      }
    };
  });

  setOpen = (open: boolean) => {
    if (open) {
      this.groupContext?.closeAllSubmenus();
      this.isRendered = true;
      this.isOpen = true;
    } else {
      this.isOpen = false;
    }
    this.args.onOpenChange?.(open);
  };

  finishClose = () => {
    if (!this.isOpen) {
      this.isRendered = false;
    }
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  cancelPendingClose = () => {
    if (this.closeTimeout) {
      clearTimeout(this.closeTimeout);
      this.closeTimeout = undefined;
    }
  };

  setPendingClose = (timeout: ReturnType<typeof setTimeout>) => {
    this.closeTimeout = timeout;
  };

  @cached
  @provide(MenubarSubContext)
  get context(): MenubarSubContextValue {
    return {
      isOpen: this.open,
      isRendered: this.isRendered,
      setOpen: this.setOpen,
      finishClose: this.finishClose,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
      parentSetOpen: this.groupContext?.setOpen ?? this.menuContext.setOpen,
      cancelPendingClose: this.cancelPendingClose,
      setPendingClose: this.setPendingClose,
    };
  }

  <template>
    <div data-slot="menubar-sub" {{this.register}}>
      {{yield}}
    </div>
  </template>
}

interface MenubarRadioGroupSignature {
  Element: HTMLDivElement;
  Args: {
    value?: string;
    onValueChange?: (value: string) => void;
    class?: string;
  };
  Blocks: {
    default: [value: string, setValue: (value: string) => void];
  };
}

class MenubarRadioGroup extends Component<MenubarRadioGroupSignature> {
  @tracked internalValue?: string;

  get value() {
    return this.args.value ?? this.internalValue ?? '';
  }

  setValue = (value: string) => {
    this.internalValue = value;
    this.args.onValueChange?.(value);
  };

  <template>
    <div
      class={{cn @class}}
      data-slot="menubar-radio-group"
      role="radiogroup"
      ...attributes
    >
      {{yield this.value this.setValue}}
    </div>
  </template>
}

interface MenubarSubTriggerSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class MenubarSubTrigger extends Component<MenubarSubTriggerSignature> {
  @consume(MenubarSubContext)
  context!: ContextRegistry[typeof MenubarSubContext];

  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  mouseEnterPosition: { x: number; y: number } | null = null;

  handleMouseEnter = (event: MouseEvent) => {
    this.mouseEnterPosition = { x: event.clientX, y: event.clientY };
    this.menuContext.cancelPendingItemClose?.();
    this.context.cancelPendingClose();
    this.context.setOpen(true);
  };

  isPointInTriangle(
    px: number,
    py: number,
    x1: number,
    y1: number,
    x2: number,
    y2: number,
    x3: number,
    y3: number
  ): boolean {
    const sign = (
      p1x: number,
      p1y: number,
      p2x: number,
      p2y: number,
      p3x: number,
      p3y: number
    ) => {
      return (p1x - p3x) * (p2y - p3y) - (p2x - p3x) * (p1y - p3y);
    };

    const d1 = sign(px, py, x1, y1, x2, y2);
    const d2 = sign(px, py, x2, y2, x3, y3);
    const d3 = sign(px, py, x3, y3, x1, y1);

    const hasNeg = d1 < 0 || d2 < 0 || d3 < 0;
    const hasPos = d1 > 0 || d2 > 0 || d3 > 0;

    return !(hasNeg && hasPos);
  }

  isMouseMovingTowardsSubmenu(event: MouseEvent): boolean {
    if (!this.mouseEnterPosition) return false;

    const submenuContent = document.querySelector(
      '[data-slot="menubar-sub-content"][data-state="open"]'
    );

    if (!submenuContent) return false;

    const submenuRect = submenuContent.getBoundingClientRect();
    const mouseX = event.clientX;
    const mouseY = event.clientY;
    const enterX = this.mouseEnterPosition.x;
    const enterY = this.mouseEnterPosition.y;

    const submenuLeft = submenuRect.left;
    const submenuTop = submenuRect.top;
    const submenuBottom = submenuRect.bottom;

    return this.isPointInTriangle(
      mouseX,
      mouseY,
      enterX,
      enterY,
      submenuLeft,
      submenuTop,
      submenuLeft,
      submenuBottom
    );
  }

  handleMouseLeave = (event: MouseEvent) => {
    if (this.isMouseMovingTowardsSubmenu(event)) {
      const timeout = setTimeout(() => {
        this.context.setOpen(false);
      }, SUBMENU_CLOSE_DELAY);
      this.context.setPendingClose(timeout);
    } else {
      this.context.setOpen(false);
    }
  };

  registerElement = modifier((element: HTMLElement) => {
    this.context.setTriggerElement(element);
    return () => {
      this.context.setTriggerElement(null);
    };
  });

  <template>
    <div
      class={{cn
        "flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none select-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground data-inset:pl-8 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-inset={{@inset}}
      data-slot="menubar-sub-trigger"
      data-state={{if this.context.isOpen "open" "closed"}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{on "mouseleave" this.handleMouseLeave}}
      {{this.registerElement}}
      ...attributes
    >
      {{yield}}
      <ChevronRight class="ml-auto size-4" />
    </div>
  </template>
}

interface MenubarSubContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class MenubarSubContent extends Component<MenubarSubContentSignature> {
  @consume(MenubarSubContext)
  subContext!: ContextRegistry[typeof MenubarSubContext];

  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  @tracked x = 0;
  @tracked y = 0;
  @tracked isPositioned = false;
  cleanup?: () => void;

  get destinationElement() {
    return document.body;
  }

  @cached
  @provide(MenubarMenuContext)
  get context(): MenubarMenuContextValue {
    return {
      ...this.menuContext,
      closeAllSubmenus: undefined,
    };
  }

  positionSubmenu = modifier(
    (
      element: HTMLElement,
      [triggerElement]: [HTMLElement | null | undefined]
    ) => {
      if (!triggerElement) return;

      const update = () => {
        void computePosition(triggerElement, element, {
          placement: 'right-start',
          strategy: 'fixed',
          middleware: [
            offset(4),
            flip({ fallbackAxisSideDirection: 'start' }),
            shift({ padding: 8 }),
          ],
        }).then(({ x, y }) => {
          this.x = x;
          this.y = y;
          this.isPositioned = true;
        });
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.isPositioned = false;
        this.cleanup?.();
      };
    }
  );

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px;${
        this.isPositioned ? '' : ' visibility: hidden;'
      }`
    );
  }

  handleMouseEnter = () => {
    this.menuContext.cancelPendingItemClose?.();
    this.subContext.cancelPendingClose();
  };

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.subContext.isOpen) {
      this.subContext.finishClose();
    }
  };

  <template>
    {{#if this.subContext.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <div
          class={{cn
            "z-50 min-w-32 overflow-hidden rounded-md bg-popover p-1 text-popover-foreground shadow-lg ring-1 ring-foreground/10 duration-100 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2"
            @class
          }}
          data-align="start"
          data-side="right"
          data-slot="menubar-sub-content"
          data-state={{if (and this.subContext.isOpen this.isPositioned) "open" "closed"}}
          role="menu"
          style={{this.positionStyle}}
          {{on "animationend" this.handleAnimationEnd}}
          {{on "mouseenter" this.handleMouseEnter}}
          {{this.positionSubmenu this.subContext.triggerElement}}
          ...attributes
        >
          {{yield}}
        </div>
      {{/in-element}}
    {{/if}}
  </template>
}

interface MenubarContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    sideOffset?: number;
    side?: 'top' | 'right' | 'bottom' | 'left';
    align?: 'start' | 'center' | 'end';
  };
  Blocks: {
    default: [];
  };
}

class MenubarContent extends Component<MenubarContentSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  @tracked x = 0;
  @tracked y = 0;
  @tracked isPositioned = false;
  cleanup?: () => void;
  groupCloseCallbacks: Set<() => void> = new Set();
  pendingItemCloseTimeout?: ReturnType<typeof setTimeout>;

  get destinationElement() {
    return document.body;
  }

  closeAllSubmenus = () => {
    this.groupCloseCallbacks.forEach((close) => close());
  };

  registerGroupCloseCallback = (closeCallback: () => void) => {
    this.groupCloseCallbacks.add(closeCallback);
    return () => {
      this.groupCloseCallbacks.delete(closeCallback);
    };
  };

  cancelPendingItemClose = () => {
    if (this.pendingItemCloseTimeout) {
      clearTimeout(this.pendingItemCloseTimeout);
      this.pendingItemCloseTimeout = undefined;
    }
  };

  setPendingItemClose = (timeout: ReturnType<typeof setTimeout>) => {
    this.pendingItemCloseTimeout = timeout;
  };

  @cached
  @provide(MenubarMenuContext)
  get context(): MenubarMenuContextValue {
    return {
      ...this.menuContext,
      closeAllSubmenus: this.closeAllSubmenus,
      registerGroupCloseCallback: this.registerGroupCloseCallback,
      cancelPendingItemClose: this.cancelPendingItemClose,
      setPendingItemClose: this.setPendingItemClose,
    };
  }

  handleClickOutside = () => {
    this.menuContext.setOpen(false);
  };

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.menuContext.isOpen) {
      this.menuContext.finishClose();
    }
  };

  positionContent = modifier(
    (
      element: HTMLElement,
      [triggerElement]: [HTMLElement | null | undefined]
    ) => {
      if (!triggerElement) return;

      const sideOffset = this.args.sideOffset ?? 8;
      const alignOffset = -4;

      const update = () => {
        void computePosition(triggerElement, element, {
          placement: 'bottom-start',
          strategy: 'fixed',
          middleware: [
            offset({ mainAxis: sideOffset, crossAxis: alignOffset }),
            flip(),
            shift({ padding: 8 }),
          ],
        }).then(({ x, y }) => {
          this.x = x;
          this.y = y;
          this.isPositioned = true;
        });
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.isPositioned = false;
        this.cleanup?.();
      };
    }
  );

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px;${
        this.isPositioned ? '' : ' visibility: hidden;'
      }`
    );
  }

  <template>
    {{#if this.context.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <div
          class={{cn
            "z-50 min-w-36 overflow-hidden rounded-md bg-popover p-1 text-popover-foreground shadow-md ring-1 ring-foreground/10 duration-100 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2"
            @class
          }}
          data-align="start"
          data-side="bottom"
          data-slot="menubar-content"
          data-state={{if (and this.menuContext.isOpen this.isPositioned) "open" "closed"}}
          role="menu"
          style={{this.positionStyle}}
          {{on "animationend" this.handleAnimationEnd}}
          {{onClickOutside this.handleClickOutside}}
          {{this.positionContent this.menuContext.triggerElement}}
          ...attributes
        >
          {{yield}}
        </div>
      {{/in-element}}
    {{/if}}
  </template>
}

interface MenubarItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
    disabled?: boolean;
    variant?: 'default' | 'destructive';
    onSelect?: () => void;
  };
  Blocks: {
    default: [];
  };
}

class MenubarItem extends Component<MenubarItemSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  handleMouseEnter = () => {
    this.menuContext.cancelPendingItemClose?.();
    const timeout = setTimeout(() => {
      this.menuContext.closeAllSubmenus?.();
    }, SUBMENU_CLOSE_DELAY);
    this.menuContext.setPendingItemClose?.(timeout);
  };

  handleClick = () => {
    if (!this.args.disabled) {
      this.args.onSelect?.();
      this.menuContext.setOpen(false);
    }
  };

  <template>
    <div
      class={{cn
        "group/menubar-item focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:hover:bg-destructive/10 dark:data-[variant=destructive]:hover:bg-destructive/20 data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-disabled={{@disabled}}
      data-inset={{@inset}}
      data-slot="menubar-item"
      data-variant={{@variant}}
      role="menuitem"
      {{on "click" this.handleClick}}
      {{on "mouseenter" this.handleMouseEnter}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface MenubarCheckboxItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    checked?: boolean;
    onCheckedChange?: (checked: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class MenubarCheckboxItem extends Component<MenubarCheckboxItemSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  handleMouseEnter = () => {
    this.menuContext.cancelPendingItemClose?.();
    const timeout = setTimeout(() => {
      this.menuContext.closeAllSubmenus?.();
    }, SUBMENU_CLOSE_DELAY);
    this.menuContext.setPendingItemClose?.(timeout);
  };

  handleClick = () => {
    this.args.onCheckedChange?.(!this.args.checked);
    this.menuContext.setOpen(false);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      aria-checked={{@checked}}
      class={{cn
        "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-slot="menubar-checkbox-item"
      role="menuitemcheckbox"
      {{on "click" this.handleClick}}
      {{on "mouseenter" this.handleMouseEnter}}
      ...attributes
    >
      <span
        class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center"
      >
        {{#if @checked}}
          <Check class="size-4" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

interface MenubarRadioItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    value: string;
    currentValue?: string;
    setValue?: (value: string) => void;
  };
  Blocks: {
    default: [];
  };
}

class MenubarRadioItem extends Component<MenubarRadioItemSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleMouseEnter = () => {
    this.menuContext.cancelPendingItemClose?.();
    const timeout = setTimeout(() => {
      this.menuContext.closeAllSubmenus?.();
    }, SUBMENU_CLOSE_DELAY);
    this.menuContext.setPendingItemClose?.(timeout);
  };

  handleClick = () => {
    this.args.setValue?.(this.args.value);
    this.menuContext.setOpen(false);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      aria-checked={{this.checked}}
      class={{cn
        "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-slot="menubar-radio-item"
      role="menuitemradio"
      {{on "click" this.handleClick}}
      {{on "mouseenter" this.handleMouseEnter}}
      ...attributes
    >
      <span
        class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center"
      >
        {{#if this.checked}}
          <span class="relative flex items-center justify-center">
            <span
              class="bg-primary absolute top-1/2 left-1/2 size-2 -translate-x-1/2 -translate-y-1/2 rounded-full"
            />
          </span>
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

interface MenubarLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class MenubarLabel extends Component<MenubarLabelSignature> {
  @consume(MenubarMenuContext)
  menuContext!: ContextRegistry[typeof MenubarMenuContext];

  handleMouseEnter = () => {
    this.menuContext.closeAllSubmenus?.();
  };

  <template>
    <div
      class={{cn "px-2 py-1.5 text-sm font-medium data-inset:pl-8" @class}}
      data-inset={{@inset}}
      data-slot="menubar-label"
      {{on "mouseenter" this.handleMouseEnter}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface MenubarSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MenubarSeparator: TOC<MenubarSeparatorSignature> = <template>
  <div
    class={{cn "bg-border -mx-1 my-1 h-px" @class}}
    data-slot="menubar-separator"
    role="separator"
    ...attributes
  ></div>
</template>;

interface MenubarShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MenubarShortcut: TOC<MenubarShortcutSignature> = <template>
  <span
    class={{cn
      "text-muted-foreground ml-auto text-xs tracking-widest group-focus/menubar-item:text-accent-foreground"
      @class
    }}
    data-slot="menubar-shortcut"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

export {
  Menubar,
  MenubarMenu,
  MenubarTrigger,
  MenubarContent,
  MenubarGroup,
  MenubarPortal,
  MenubarSub,
  MenubarRadioGroup,
  MenubarSubTrigger,
  MenubarSubContent,
  MenubarItem,
  MenubarCheckboxItem,
  MenubarRadioItem,
  MenubarLabel,
  MenubarSeparator,
  MenubarShortcut,
};
