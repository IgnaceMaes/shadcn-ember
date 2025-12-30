import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';
import { cn } from '@/lib/utils';
import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';
import Circle from '~icons/lucide/circle';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import type { TOC } from '@ember/component/template-only';
import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';

const DropdownMenuContext = 'dropdown-menu-context' as const;
const DropdownMenuGroupContext = 'dropdown-menu-group-context' as const;
const DropdownMenuSubContext = 'dropdown-menu-sub-context' as const;

interface DropdownMenuContextValue {
  isOpen: boolean;
  setOpen: (open: boolean) => void;
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
  setOpen: (open: boolean) => void;
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
  triggerElement: HTMLElement | null = null;

  constructor(owner: Owner, args: DropdownMenuSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? args.defaultOpen ?? false;
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  @cached
  @provide(DropdownMenuContext)
  get context(): DropdownMenuContextValue {
    return {
      isOpen: this.open,
      setOpen: this.setOpen,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
    };
  }

  <template>
    <div data-slot="dropdown-menu" class="relative">
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
        {{this.registerElement}}
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </span>
    {{else}}
      <button
        type="button"
        class={{cn @class}}
        data-slot="dropdown-menu-trigger"
        {{this.registerElement}}
        {{on "click" this.handleClick}}
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
  private submenuCloseCallbacks: Set<() => void> = new Set();
  private unregister?: () => void;

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
      role="group"
      data-slot="dropdown-menu-group"
      class={{cn @class}}
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
  triggerElement: HTMLElement | null = null;
  private unregister?: () => void;

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
    }
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  @cached
  @provide(DropdownMenuSubContext)
  get context(): DropdownMenuSubContextValue {
    return {
      isOpen: this.open,
      setOpen: this.setOpen,
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
      role="radiogroup"
      data-slot="dropdown-menu-radio-group"
      class={{cn @class}}
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
      data-slot="dropdown-menu-sub-trigger"
      data-inset={{@inset}}
      data-state={{if this.context.isOpen "open" "closed"}}
      class={{cn
        "focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      {{this.registerElement}}
      {{on "mouseenter" this.handleMouseEnter}}
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
  private cleanup?: () => void;

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

  get positionStyle(): string {
    return `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 50;`;
  }

  handleMouseEnter = () => {
    // Keep the submenu open when hovering over it
  };

  <template>
    {{#if this.subContext.isOpen}}
      <div
        data-slot="dropdown-menu-sub-content"
        data-side="right"
        data-align="start"
        class={{cn
          "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-hidden rounded-md border p-1 shadow-lg"
          @class
        }}
        data-state={{if this.subContext.isOpen "open" "closed"}}
        role="menu"
        style={{this.positionStyle}}
        {{this.positionSubmenu this.subContext.triggerElement}}
        {{on "mouseenter" this.handleMouseEnter}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

interface DropdownMenuContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    sideOffset?: number;
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
  private cleanup?: () => void;
  private groupCloseCallbacks: Set<() => void> = new Set();

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

  positionContent = modifier(
    (
      element: HTMLElement,
      [triggerElement]: [HTMLElement | null | undefined]
    ) => {
      if (!triggerElement) return;

      const align = this.args.align ?? 'start';
      const placementMap: Record<string, Placement> = {
        start: 'bottom-start',
        center: 'bottom',
        end: 'bottom-end',
      };

      const update = () => {
        void computePosition(triggerElement, element, {
          placement: placementMap[align] || 'bottom-start',
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

  get positionStyle(): string {
    return `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 50;`;
  }

  <template>
    {{#if this.menuContext.isOpen}}
      <div
        data-slot="dropdown-menu-content"
        class={{cn
          "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 max-h-(--radix-dropdown-menu-content-available-height) min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-x-hidden overflow-y-auto rounded-md border p-1 shadow-md"
          @class
        }}
        data-state={{if this.menuContext.isOpen "open" "closed"}}
        data-align={{@align}}
        role="menu"
        style={{this.positionStyle}}
        {{this.positionContent this.menuContext.triggerElement}}
        {{onClickOutside this.handleClickOutside}}
        ...attributes
      >
        {{yield}}
      </div>
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
        data-slot="dropdown-menu-item"
        data-inset={{@inset}}
        data-variant={{@variant}}
        class={{cn
          "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
          @class
        }}
        role="menuitem"
        data-disabled={{@disabled}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "click" this.handleClick}}
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
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      data-slot="dropdown-menu-checkbox-item"
      class={{cn
        "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      role="menuitemcheckbox"
      aria-checked={{@checked}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{on "click" this.handleClick}}
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
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      data-slot="dropdown-menu-radio-item"
      class={{cn
        "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      role="menuitemradio"
      aria-checked={{this.checked}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span
        class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center"
      >
        {{#if this.checked}}
          <Circle class="size-2 fill-current" />
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
      data-slot="dropdown-menu-label"
      data-inset={{@inset}}
      class={{cn "px-2 py-1.5 text-sm font-medium data-inset:pl-8" @class}}
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
    data-slot="dropdown-menu-separator"
    class={{cn "bg-border -mx-1 my-1 h-px" @class}}
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
    data-slot="dropdown-menu-shortcut"
    class={{cn "text-muted-foreground ml-auto text-xs tracking-widest" @class}}
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
