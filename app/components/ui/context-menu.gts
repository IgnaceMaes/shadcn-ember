import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
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

// ContextMenu Root Component
interface ContextMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class ContextMenu extends Component<ContextMenuSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: ContextMenuSignature['Args']) {
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
    <div class="relative inline-block">
      {{yield this.open this.setOpen}}
    </div>
  </template>
}

// ContextMenuTrigger Component
interface ContextMenuTriggerSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class ContextMenuTrigger extends Component<ContextMenuTriggerSignature> {
  handleContextMenu = (event: MouseEvent) => {
    event.preventDefault();
    this.args.setOpen?.(true);
  };

  <template>
    <div
      class={{cn @class}}
      {{on "contextmenu" this.handleContextMenu}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// ContextMenuGroup Component
interface ContextMenuGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuGroup: TOC<ContextMenuGroupSignature> = <template>
  <div role="group" class={{cn @class}} ...attributes>
    {{yield}}
  </div>
</template>;

// ContextMenuPortal Component
interface ContextMenuPortalSignature {
  Blocks: {
    default: [];
  };
}

export const ContextMenuPortal: TOC<ContextMenuPortalSignature> = <template>
  <div data-portal>
    {{yield}}
  </div>
</template>;

// ContextMenuSub Component
interface ContextMenuSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class ContextMenuSub extends Component<ContextMenuSubSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: ContextMenuSubSignature['Args']) {
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

  <template>{{yield this.open this.setOpen}}</template>
}

// ContextMenuRadioGroup Component
interface ContextMenuRadioGroupSignature {
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

export class ContextMenuRadioGroup extends Component<ContextMenuRadioGroupSignature> {
  @tracked internalValue: string;

  constructor(owner: Owner, args: ContextMenuRadioGroupSignature['Args']) {
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

// ContextMenuSubTrigger Component
interface ContextMenuSubTriggerSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuSubTrigger: TOC<ContextMenuSubTriggerSignature> =
  <template>
    <div
      class={{cn
        "flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground"
        (if @inset "pl-8")
        @class
      }}
      ...attributes
    >
      {{yield}}
      <ChevronRight class="size-4 ml-auto" />
    </div>
  </template>;

// ContextMenuSubContent Component
interface ContextMenuSubContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuSubContent: TOC<ContextMenuSubContentSignature> =
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
  </template>;

// ContextMenuContent Component
interface ContextMenuContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

export class ContextMenuContent extends Component<ContextMenuContentSignature> {
  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 max-h-[--radix-context-menu-content-available-height] min-w-[8rem] overflow-y-auto overflow-x-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 top-full left-0 mt-2"
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

// ContextMenuItem Component
interface ContextMenuItemSignature {
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

export const ContextMenuItem: TOC<ContextMenuItemSignature> = <template>
  <div
    class={{cn
      "relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
      (if @inset "pl-8")
      @class
    }}
    role="menuitem"
    data-disabled={{@disabled}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// ContextMenuCheckboxItem Component
interface ContextMenuCheckboxItemSignature {
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

export class ContextMenuCheckboxItem extends Component<ContextMenuCheckboxItemSignature> {
  handleClick = () => {
    this.args.onCheckedChange?.(!this.args.checked);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      class={{cn
        "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
        @class
      }}
      role="menuitemcheckbox"
      aria-checked={{@checked}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span
        class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center"
      >
        {{#if @checked}}
          <Check class="size-4" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

// ContextMenuRadioItem Component
interface ContextMenuRadioItemSignature {
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

export class ContextMenuRadioItem extends Component<ContextMenuRadioItemSignature> {
  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleClick = () => {
    this.args.setValue?.(this.args.value);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      class={{cn
        "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
        @class
      }}
      role="menuitemradio"
      aria-checked={{this.checked}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span
        class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center"
      >
        {{#if this.checked}}
          <Circle class="size-4 fill-current" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

// ContextMenuLabel Component
interface ContextMenuLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    inset?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuLabel: TOC<ContextMenuLabelSignature> = <template>
  <div
    class={{cn
      "px-2 py-1.5 text-sm font-semibold text-foreground"
      (if @inset "pl-8")
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// ContextMenuSeparator Component
interface ContextMenuSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuSeparator: TOC<ContextMenuSeparatorSignature> =
  <template>
    <div
      class={{cn "-mx-1 my-1 h-px bg-muted" @class}}
      role="separator"
      ...attributes
    ></div>
  </template>;

// ContextMenuShortcut Component
interface ContextMenuShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const ContextMenuShortcut: TOC<ContextMenuShortcutSignature> = <template>
  <span
    class={{cn "ml-auto text-xs tracking-widest text-muted-foreground" @class}}
    ...attributes
  >
    {{yield}}
  </span>
</template>;

export default ContextMenu;
