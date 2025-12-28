import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { modifier } from 'ember-modifier';
import { hash } from '@ember/helper';
import { cn } from '@/lib/utils';
import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';
import Circle from '~icons/lucide/circle';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';

interface DropdownMenuYields {
  Trigger: ComponentLike<DropdownMenuTriggerSignature>;
  Content: ComponentLike<DropdownMenuContentSignature>;
}

interface DropdownMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [DropdownMenuYields];
  };
}

class DropdownMenu extends Component<DropdownMenuSignature> {
  @tracked isOpen: boolean;

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

  <template>
    <div data-slot="dropdown-menu" class="relative">
      {{yield
        (hash
          Trigger=(component
            DropdownMenuTrigger isOpen=this.open setOpen=this.setOpen
          )
          Content=(component
            DropdownMenuContent isOpen=this.open setOpen=this.setOpen
          )
        )
      }}
    </div>
  </template>
}

interface DropdownMenuTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
    isOpen?: boolean;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuTrigger extends Component<DropdownMenuTriggerSignature> {
  handleClick = () => {
    const newOpen = !this.args.isOpen;
    this.args.setOpen?.(newOpen);
  };

  <template>
    {{#if @asChild}}
      <span
        data-slot="dropdown-menu-trigger"
        role="button"
        tabindex="0"
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
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface DropdownMenuGroupYields {
  Item: ComponentLike<DropdownMenuItemSignature>;
  Label: ComponentLike<DropdownMenuLabelSignature>;
  Sub: ComponentLike<DropdownMenuSubSignature>;
}

interface DropdownMenuGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [DropdownMenuGroupYields];
  };
}

class DropdownMenuGroup extends Component<DropdownMenuGroupSignature> {
  @tracked currentOpenSubmenu: symbol | null = null;

  closeAllSubmenus = () => {
    this.currentOpenSubmenu = null;
  };

  setOpenSubmenu = (id: symbol) => {
    this.currentOpenSubmenu = id;
  };

  <template>
    <div
      role="group"
      data-slot="dropdown-menu-group"
      class={{cn @class}}
      ...attributes
    >
      {{yield
        (hash
          Item=(component
            DropdownMenuItem closeOtherSubmenus=this.closeAllSubmenus
          )
          Label=(component
            DropdownMenuLabel closeOtherSubmenus=this.closeAllSubmenus
          )
          Sub=(component DropdownMenuSub closeOtherSubmenus=this.closeAllSubmenus)
        )
      }}
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

interface DropdownMenuSubYields {
  Trigger: ComponentLike<DropdownMenuSubTriggerSignature>;
  Content: ComponentLike<DropdownMenuSubContentSignature>;
}

interface DropdownMenuSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
    closeOtherSubmenus?: () => void;
  };
  Blocks: {
    default: [DropdownMenuSubYields];
  };
}

class DropdownMenuSub extends Component<DropdownMenuSubSignature> {
  @tracked isOpen: boolean;
  @tracked triggerElement: HTMLElement | null = null;

  constructor(owner: Owner, args: DropdownMenuSubSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? args.defaultOpen ?? false;
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    if (open && this.args.closeOtherSubmenus) {
      this.args.closeOtherSubmenus();
    }
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  <template>
    <div data-slot="dropdown-menu-sub">
      {{yield
        (hash
          Trigger=(component
            DropdownMenuSubTrigger
            setOpen=this.setOpen
            setTriggerElement=this.setTriggerElement
          )
          Content=(component
            DropdownMenuSubContent
            isOpen=this.open
            triggerElement=this.triggerElement
          )
        )
      }}
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
    setOpen?: (open: boolean) => void;
    setTriggerElement?: (element: HTMLElement | null) => void;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuSubTrigger extends Component<DropdownMenuSubTriggerSignature> {
  handleMouseEnter = () => {
    this.args.setOpen?.(true);
  };

  registerElement = (element: HTMLElement) => {
    this.args.setTriggerElement?.(element);
    return () => {
      this.args.setTriggerElement?.(null);
    };
  };

  <template>
    <div
      data-slot="dropdown-menu-sub-trigger"
      data-inset={{@inset}}
      class={{cn
        "focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      {{(modifier this.registerElement)}}
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
    isOpen?: boolean;
    triggerElement?: HTMLElement | null;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuSubContent extends Component<DropdownMenuSubContentSignature> {
  get positionStyle(): string {
    if (!this.args.triggerElement) {
      return 'display: none;';
    }

    const rect = this.args.triggerElement.getBoundingClientRect();
    const left = rect.right + 4;
    const top = rect.top;

    return `position: fixed; left: ${left}px; top: ${top}px; z-index: 50;`;
  }

  handleMouseEnter = () => {
    // Keep the submenu open when hovering over it
  };

  <template>
    {{#if @isOpen}}
      <div
        data-slot="dropdown-menu-sub-content"
        data-side="right"
        data-align="start"
        class={{cn
          "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-hidden rounded-md border p-1 shadow-lg"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        role="menu"
        style={{this.positionStyle}}
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
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuContent extends Component<DropdownMenuContentSignature> {
  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  get alignmentStyle(): string {
    const align = this.args.align ?? 'start';
    if (align === 'end') {
      return 'right: 0;';
    } else if (align === 'center') {
      return 'left: 50%; transform: translateX(-50%);';
    }
    return 'left: 0;';
  }

  <template>
    {{#if @isOpen}}
      <div
        data-slot="dropdown-menu-content"
        class={{cn
          "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 max-h-(--radix-dropdown-menu-content-available-height) min-w-32 origin-(--radix-dropdown-menu-content-transform-origin) overflow-x-hidden overflow-y-auto rounded-md border p-1 shadow-md absolute top-full mt-2"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        data-align={{@align}}
        role="menu"
        style={{this.alignmentStyle}}
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
    closeOtherSubmenus?: () => void;
  };
  Blocks: {
    default: [classes?: string];
  };
}

class DropdownMenuItem extends Component<DropdownMenuItemSignature> {
  handleMouseEnter = () => {
    this.args.closeOtherSubmenus?.();
  };

  <template>
    {{#if @asChild}}
      {{yield
        (cn
          "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 transition-colors"
          @class
        )
      }}
    {{else}}
      <div
        data-slot="dropdown-menu-item"
        data-inset={{@inset}}
        data-variant={{@variant}}
        class={{cn
          "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 dark:data-[variant=destructive]:focus:bg-destructive/20 data-[variant=destructive]:focus:text-destructive data-[variant=destructive]:*:[svg]:text-destructive! [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 transition-colors"
          @class
        }}
        role="menuitem"
        data-disabled={{@disabled}}
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
  handleClick = () => {
    this.args.onCheckedChange?.(!this.args.checked);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      data-slot="dropdown-menu-checkbox-item"
      class={{cn
        "focus:bg-accent focus:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      role="menuitemcheckbox"
      aria-checked={{@checked}}
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
  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleClick = () => {
    this.args.setValue?.(this.args.value);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      data-slot="dropdown-menu-radio-item"
      class={{cn
        "focus:bg-accent focus:text-accent-foreground relative flex cursor-default items-center gap-2 rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      role="menuitemradio"
      aria-checked={{this.checked}}
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
    closeOtherSubmenus?: () => void;
  };
  Blocks: {
    default: [];
  };
}

class DropdownMenuLabel extends Component<DropdownMenuLabelSignature> {
  handleMouseEnter = () => {
    this.args.closeOtherSubmenus?.();
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
