/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
// import PhCheck from 'ember-phosphor-icons/components/ph-check';
// import PhCaretRight from 'ember-phosphor-icons/components/ph-caret-right';
// import PhCircle from 'ember-phosphor-icons/components/ph-circle';
import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';
import Circle from '~icons/lucide/circle';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';

// DropdownMenu Root Component
interface DropdownMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class DropdownMenu extends Component<DropdownMenuSignature> {
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
    {{yield this.open this.setOpen}}
  </template>
}

// DropdownMenuTrigger Component
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

export class DropdownMenuTrigger extends Component<DropdownMenuTriggerSignature> {
  handleClick = () => {
    const newOpen = !this.args.isOpen;
    this.args.setOpen?.(newOpen);
  };

  <template>
    {{#if @asChild}}
      <span class="relative inline-block">
        <span role="button" tabindex="0" {{on "click" this.handleClick}} {{on "keydown" this.handleClick}}>
          {{yield}}
        </span>
      </span>
    {{else}}
      <button
        type="button"
        class={{cn "relative inline-block" @class}}
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

// DropdownMenuGroup Component
interface DropdownMenuGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuGroup extends Component<DropdownMenuGroupSignature> {
  <template>
    <div role="group" class={{cn @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// DropdownMenuPortal Component
interface DropdownMenuPortalSignature {
  Blocks: {
    default: [];
  };
}

export class DropdownMenuPortal extends Component<DropdownMenuPortalSignature> {
  <template>
    <div data-portal>
      {{yield}}
    </div>
  </template>
}

// DropdownMenuSub Component
interface DropdownMenuSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class DropdownMenuSub extends Component<DropdownMenuSubSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: DropdownMenuSubSignature['Args']) {
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
    {{yield this.open this.setOpen}}
  </template>
}

// DropdownMenuRadioGroup Component
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

export class DropdownMenuRadioGroup extends Component<DropdownMenuRadioGroupSignature> {
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
    <div role="radiogroup" class={{cn @class}} ...attributes>
      {{yield this.value this.setValue}}
    </div>
  </template>
}

// DropdownMenuSubTrigger Component
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

export class DropdownMenuSubTrigger extends Component<DropdownMenuSubTriggerSignature> {
  <template>
    <div
      class={{cn
        "flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent data-[state=open]:bg-accent [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0"
        (if @inset "pl-8")
        @class
      }}
      ...attributes
    >
      {{yield}}
      <ChevronRight class="size-4 ml-auto" />
    </div>
  </template>
}

// DropdownMenuSubContent Component
interface DropdownMenuSubContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuSubContent extends Component<DropdownMenuSubContentSignature> {
  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-lg data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

// DropdownMenuContent Component
interface DropdownMenuContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    sideOffset?: number;
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuContent extends Component<DropdownMenuContentSignature> {
  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 max-h-[var(--radix-dropdown-menu-content-available-height)] min-w-[8rem] overflow-y-auto overflow-x-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 top-full left-0 mt-2"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        role="menu"
        {{onClickOutside this.handleClickOutside}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

// DropdownMenuItem Component
interface DropdownMenuItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuItem extends Component<DropdownMenuItemSignature> {
  <template>
    <div
      class={{cn
        "relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 [&>svg]:size-4 [&>svg]:shrink-0"
        (if @inset "pl-8")
        @class
      }}
      role="menuitem"
      data-disabled={{@disabled}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// DropdownMenuCheckboxItem Component
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

export class DropdownMenuCheckboxItem extends Component<DropdownMenuCheckboxItemSignature> {
  handleClick = () => {
    this.args.onCheckedChange?.(!this.args.checked);
  };

  <template>
    <div
      class={{cn
        "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
        @class
      }}
      role="menuitemcheckbox"
      aria-checked={{@checked}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
        {{#if @checked}}
          <Check class="size-4" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

// DropdownMenuRadioItem Component
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

export class DropdownMenuRadioItem extends Component<DropdownMenuRadioItemSignature> {
  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleClick = () => {
    this.args.setValue?.(this.args.value);
  };

  <template>
    <div
      class={{cn
        "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
        @class
      }}
      role="menuitemradio"
      aria-checked={{this.checked}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
        {{#if this.checked}}
          <Circle class="size-2 fill-current" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

// DropdownMenuLabel Component
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

export class DropdownMenuLabel extends Component<DropdownMenuLabelSignature> {
  <template>
    <div
      class={{cn
        "px-2 py-1.5 text-sm font-semibold"
        (if @inset "pl-8")
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// DropdownMenuSeparator Component
interface DropdownMenuSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuSeparator extends Component<DropdownMenuSeparatorSignature> {
  <template>
    <div class={{cn "-mx-1 my-1 h-px bg-muted" @class}} role="separator" ...attributes></div>
  </template>
}

// DropdownMenuShortcut Component
interface DropdownMenuShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DropdownMenuShortcut extends Component<DropdownMenuShortcutSignature> {
  <template>
    <span class={{cn "ml-auto text-xs tracking-widest opacity-60" @class}} ...attributes>
      {{yield}}
    </span>
  </template>
}

export default DropdownMenu;
