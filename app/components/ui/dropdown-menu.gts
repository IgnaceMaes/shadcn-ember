import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';

import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';

const DropdownMenuContext = 'dropdown-menu-context' as const;
const DropdownMenuGroupContext = 'dropdown-menu-group-context' as const;
const DropdownMenuSubContext = 'dropdown-menu-sub-context' as const;

interface DropdownMenuContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  closeAllSubmenus?: () => void;
  registerGroupCloseCallback?: (callback: () => void) => () => void;
}

interface DropdownMenuGroupContextValue {
  closeAllSubmenus: () => void;
  registerSubmenu: (closeCallback: () => void) => () => void;
  setOpen: (open: boolean) => void;
}

interface DropdownMenuSubContextValue {
  isOpen: boolean;
  isRendered: boolean;
  setOpen: (open: boolean) => void;
  finishClose: () => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  parentSetOpen: (open: boolean) => void;
}

interface ContextRegistry {
  [DropdownMenuContext]: DropdownMenuContextValue;
  [DropdownMenuGroupContext]: DropdownMenuGroupContextValue;
  [DropdownMenuSubContext]: DropdownMenuSubContextValue;
}

interface DropdownMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenu extends Component<DropdownMenuSignature> {
  @tracked isOpen: boolean;
  @tracked isRendered = false;
  triggerElement: HTMLElement | null = null;

  constructor(owner: Owner, args: DropdownMenuSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? args.defaultOpen ?? false;
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    if (open) {
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

  @cached
  @provide(DropdownMenuContext)
  get context(): DropdownMenuContextValue {
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
    <div class="relative" data-slot="dropdown-menu">
      {{yield}}
    </div>
  </template>
}

interface DropdownMenuTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuTrigger extends Component<DropdownMenuTriggerSignature> {
  @consume(DropdownMenuContext)
  context!: ContextRegistry[typeof DropdownMenuContext];

  handleClick = () => {
    const newOpen = !this.context.isOpen;
    this.context.setOpen(newOpen);
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
        data-slot="dropdown-menu-trigger"
        role="button"
        tabindex="0"
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
        {{this.registerElement}}
        ...attributes
      >
        {{yield}}
      </span>
    {{else}}
      <button
        class={{cn @class}}
        data-slot="dropdown-menu-trigger"
        type="button"
        {{on "click" this.handleClick}}
        {{this.registerElement}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface DropdownMenuGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuGroup extends Component<DropdownMenuGroupSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  @tracked currentOpenSubmenu: symbol | null = null;
  submenuCloseCallbacks: Set<() => void> = new Set();
  unregister?: () => void;

  constructor(owner: Owner, args: DropdownMenuGroupSignature['Args']) {
    super(owner, args);
    this.unregister = this.menuContext.registerGroupCloseCallback?.(
      this.closeAllSubmenus
    );
  }

  willDestroy() {
    super.willDestroy();
    this.unregister?.();
  }

  closeAllSubmenus = () => {
    this.currentOpenSubmenu = null;
    this.submenuCloseCallbacks.forEach((close) => close());
  };

  setOpenSubmenu = (id: symbol) => {
    this.currentOpenSubmenu = id;
  };

  registerSubmenu = (closeCallback: () => void) => {
    this.submenuCloseCallbacks.add(closeCallback);
    return () => {
      this.submenuCloseCallbacks.delete(closeCallback);
    };
  };

  @cached
  @provide(DropdownMenuGroupContext)
  get context(): DropdownMenuGroupContextValue {
    return {
      closeAllSubmenus: this.closeAllSubmenus,
      registerSubmenu: this.registerSubmenu,
      setOpen: this.menuContext.setOpen,
    };
  }

  <template>
    <div
      class={{cn @class}}
      data-slot="dropdown-menu-group"
      role="group"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface DropdownMenuPortalSignature {
  Blocks: {
    default: [];
  };
}

const DropdownMenuPortal: TOC<DropdownMenuPortalSignature> = <template>
  <div data-slot="dropdown-menu-portal">
    {{yield}}
  </div>
</template>;

interface DropdownMenuSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuSub extends Component<DropdownMenuSubSignature> {
  @consume(DropdownMenuGroupContext)
  groupContext!: ContextRegistry[typeof DropdownMenuGroupContext];

  @tracked isOpen: boolean;
  @tracked isRendered = false;
  triggerElement: HTMLElement | null = null;
  unregister?: () => void;

  constructor(owner: Owner, args: DropdownMenuSubSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? args.defaultOpen ?? false;

    this.unregister = this.groupContext.registerSubmenu(() => {
      this.isOpen = false;
    });
  }

  willDestroy() {
    super.willDestroy();
    this.unregister?.();
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    if (open) {
      this.groupContext.closeAllSubmenus();
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

  @cached
  @provide(DropdownMenuSubContext)
  get context(): DropdownMenuSubContextValue {
    return {
      isOpen: this.open,
      isRendered: this.isRendered,
      setOpen: this.setOpen,
      finishClose: this.finishClose,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
      parentSetOpen: this.groupContext.setOpen,
    };
  }

  <template>
    <div data-slot="dropdown-menu-sub">
      {{yield}}
    </div>
  </template>
}

interface DropdownMenuRadioGroupSignature {
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

class DropdownMenuRadioGroup extends Component<DropdownMenuRadioGroupSignature> {
  @tracked internalValue: string;

  constructor(owner: Owner, args: DropdownMenuRadioGroupSignature['Args']) {
    super(owner, args);
    this.internalValue = args.value ?? '';
  }

  get value() {
    return this.args.value ?? this.internalValue;
  }

  setValue = (value: string) => {
    this.internalValue = value;
    this.args.onValueChange?.(value);
  };

  <template>
    <div
      class={{cn @class}}
      data-slot="dropdown-menu-radio-group"
      role="radiogroup"
      ...attributes
    >
      {{yield this.value this.setValue}}
    </div>
  </template>
}

interface DropdownMenuSubTriggerSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuSubTrigger extends Component<DropdownMenuSubTriggerSignature> {
  @consume(DropdownMenuSubContext)
  context!: ContextRegistry[typeof DropdownMenuSubContext];

  handleMouseEnter = () => {
    this.context.setOpen(true);
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
        "focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-inset={{@inset}}
      data-slot="dropdown-menu-sub-trigger"
      data-state={{if this.context.isOpen "open" "closed"}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{this.registerElement}}
      ...attributes
    >
      {{yield}}
      <ChevronRight class="ml-auto size-4" />
    </div>
  </template>
}

interface DropdownMenuSubContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuSubContent extends Component<DropdownMenuSubContentSignature> {
  @consume(DropdownMenuSubContext)
  subContext!: ContextRegistry[typeof DropdownMenuSubContext];

  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  @tracked x = 0;
  @tracked y = 0;
  cleanup?: () => void;

  get destinationElement() {
    return document.body;
  }

  @cached
  @provide(DropdownMenuContext)
  get context(): DropdownMenuContextValue {
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
        });
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.cleanup?.();
      };
    }
  );

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 9999;`
    );
  }

  handleMouseEnter = () => {
    // Keep the submenu open when hovering over it
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
            "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-[9999] min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-hidden rounded-md border p-1 shadow-lg"
            @class
          }}
          data-align="start"
          data-side="right"
          data-slot="dropdown-menu-sub-content"
          data-state={{if this.subContext.isOpen "open" "closed"}}
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

interface DropdownMenuContentSignature {
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

class DropdownMenuContent extends Component<DropdownMenuContentSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  @tracked x = 0;
  @tracked y = 0;
  cleanup?: () => void;
  groupCloseCallbacks: Set<() => void> = new Set();

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

  @cached
  @provide(DropdownMenuContext)
  get context(): DropdownMenuContextValue {
    return {
      ...this.menuContext,
      closeAllSubmenus: this.closeAllSubmenus,
      registerGroupCloseCallback: this.registerGroupCloseCallback,
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

      const side = this.args.side ?? 'bottom';
      const align = this.args.align ?? 'start';

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

      const placementKey = `${side}-${align}`;
      const placement = placementMap[placementKey] || 'bottom-start';

      const update = () => {
        void computePosition(triggerElement, element, {
          placement,
          strategy: 'fixed',
          middleware: [offset(8), flip(), shift({ padding: 8 })],
        }).then(({ x, y }) => {
          this.x = x;
          this.y = y;
        });
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.cleanup?.();
      };
    }
  );

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 9999;`
    );
  }

  <template>
    {{#if this.context.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <div
          class={{cn
            "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-[9999] max-h-(--radix-dropdown-menu-content-available-height) min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-x-hidden overflow-y-auto rounded-md border p-1 shadow-md"
            @class
          }}
          data-align={{@align}}
          data-side={{@side}}
          data-slot="dropdown-menu-content"
          data-state={{if this.menuContext.isOpen "open" "closed"}}
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

interface DropdownMenuItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
    disabled?: boolean;
    variant?: 'default' | 'destructive';
    asChild?: boolean;
    onSelect?: () => void;
  };
  Blocks: {
    default: [classes?: string];
  };
}

class DropdownMenuItem extends Component<DropdownMenuItemSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  handleMouseEnter = () => {
    this.menuContext.closeAllSubmenus?.();
  };

  handleClick = () => {
    if (!this.args.disabled) {
      this.args.onSelect?.();
      this.menuContext.setOpen(false);
    }
  };

  <template>
    {{#if @asChild}}
      {{yield
        (cn
          "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
          @class
        )
      }}
    {{else}}
      <div
        class={{cn
          "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
          @class
        }}
        data-disabled={{@disabled}}
        data-inset={{@inset}}
        data-slot="dropdown-menu-item"
        data-variant={{@variant}}
        role="menuitem"
        {{on "click" this.handleClick}}
        {{on "mouseenter" this.handleMouseEnter}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

interface DropdownMenuCheckboxItemSignature {
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

class DropdownMenuCheckboxItem extends Component<DropdownMenuCheckboxItemSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  handleMouseEnter = () => {
    this.menuContext.closeAllSubmenus?.();
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
      data-slot="dropdown-menu-checkbox-item"
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

interface DropdownMenuRadioItemSignature {
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

class DropdownMenuRadioItem extends Component<DropdownMenuRadioItemSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleMouseEnter = () => {
    this.menuContext.closeAllSubmenus?.();
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
      data-slot="dropdown-menu-radio-item"
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

interface DropdownMenuLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuLabel extends Component<DropdownMenuLabelSignature> {
  @consume(DropdownMenuContext)
  menuContext!: ContextRegistry[typeof DropdownMenuContext];

  handleMouseEnter = () => {
    this.menuContext.closeAllSubmenus?.();
  };

  <template>
    <div
      class={{cn "px-2 py-1.5 text-sm font-medium data-inset:pl-8" @class}}
      data-inset={{@inset}}
      data-slot="dropdown-menu-label"
      {{on "mouseenter" this.handleMouseEnter}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface DropdownMenuSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DropdownMenuSeparator: TOC<DropdownMenuSeparatorSignature> = <template>
  <div
    class={{cn "bg-border -mx-1 my-1 h-px" @class}}
    data-slot="dropdown-menu-separator"
    role="separator"
    ...attributes
  ></div>
</template>;

interface DropdownMenuShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DropdownMenuShortcut: TOC<DropdownMenuShortcutSignature> = <template>
  <span
    class={{cn "text-muted-foreground ml-auto text-xs tracking-widest" @class}}
    data-slot="dropdown-menu-shortcut"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

export {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuGroup,
  DropdownMenuPortal,
  DropdownMenuSub,
  DropdownMenuRadioGroup,
  DropdownMenuSubTrigger,
  DropdownMenuSubContent,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuCheckboxItem,
  DropdownMenuRadioItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
};
