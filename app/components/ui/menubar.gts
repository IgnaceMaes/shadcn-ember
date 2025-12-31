import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import Check from '~icons/lucide/check';
import ChevronRight from '~icons/lucide/chevron-right';
import Circle from '~icons/lucide/circle';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';

// Note: This is a simplified version of the Menubar component
// Similar to DropdownMenu but arranged horizontally

// Menubar Root Component
interface MenubarSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Menubar: TOC<MenubarSignature> = <template>
  <div
    class={{cn
      "flex h-9 items-center space-x-1 rounded-md border bg-background p-1 shadow-sm"
      @class
    }}
    role="menubar"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// MenubarMenu Component
interface MenubarMenuSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

class MenubarMenu extends Component<MenubarMenuSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: MenubarMenuSignature['Args']) {
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
    <div class="relative">
      {{yield this.open this.setOpen}}
    </div>
  </template>
}

// MenubarTrigger Component
interface MenubarTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class MenubarTrigger extends Component<MenubarTriggerSignature> {
  handleClick = () => {
    const newOpen = !this.args.isOpen;
    this.args.setOpen?.(newOpen);
  };

  <template>
    <button
      class={{cn
        "flex cursor-default select-none items-center rounded-sm px-3 py-1 text-sm font-medium outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground"
        @class
      }}
      data-state={{if @isOpen "open" "closed"}}
      type="button"
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

// MenubarContent Component
interface MenubarContentSignature {
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

class MenubarContent extends Component<MenubarContentSignature> {
  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 min-w-[12rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md top-full left-0 mt-1"
          @class
        }}
        role="menu"
        {{onClickOutside this.handleClickOutside}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

// MenubarItem Component
interface MenubarItemSignature {
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

const MenubarItem: TOC<MenubarItemSignature> = <template>
  <div
    class={{cn
      "relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
      (if @inset "pl-8")
      @class
    }}
    data-disabled={{@disabled}}
    role="menuitem"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// MenubarGroup Component
interface MenubarGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MenubarGroup: TOC<MenubarGroupSignature> = <template>
  <div class={{cn @class}} role="group" ...attributes>
    {{yield}}
  </div>
</template>;

// MenubarPortal Component
interface MenubarPortalSignature {
  Blocks: {
    default: [];
  };
}

const MenubarPortal: TOC<MenubarPortalSignature> = <template>
  <div data-portal>
    {{yield}}
  </div>
</template>;

// MenubarRadioGroup Component
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
  @tracked internalValue: string;

  constructor(owner: Owner, args: MenubarRadioGroupSignature['Args']) {
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
    <div class={{cn @class}} role="radiogroup" ...attributes>
      {{yield this.value this.setValue}}
    </div>
  </template>
}

// MenubarSub Component
interface MenubarSubSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

class MenubarSub extends Component<MenubarSubSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: MenubarSubSignature['Args']) {
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

// MenubarSubTrigger Component
interface MenubarSubTriggerSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MenubarSubTrigger: TOC<MenubarSubTriggerSignature> = <template>
  <div
    class={{cn
      "flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground"
      @class
    }}
    ...attributes
  >
    {{yield}}
    <ChevronRight class="size-4 ml-auto" />
  </div>
</template>;

// MenubarSubContent Component
interface MenubarSubContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

const MenubarSubContent: TOC<MenubarSubContentSignature> = <template>
  {{#if @isOpen}}
    <div
      class={{cn
        "z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-lg"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  {{/if}}
</template>;

// MenubarCheckboxItem Component
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

const MenubarCheckboxItem: TOC<MenubarCheckboxItemSignature> = <template>
  {{! template-lint-disable require-presentational-children }}
  <div
    aria-checked={{@checked}}
    class={{cn
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground"
      @class
    }}
    role="menuitemcheckbox"
    ...attributes
  >
    <span class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      {{#if @checked}}
        <Check class="size-4" />
      {{/if}}
    </span>
    {{yield}}
  </div>
</template>;

// MenubarRadioItem Component
interface MenubarRadioItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    checked?: boolean;
    value?: string;
  };
  Blocks: {
    default: [];
  };
}

const MenubarRadioItem: TOC<MenubarRadioItemSignature> = <template>
  {{! template-lint-disable require-presentational-children }}
  <div
    aria-checked={{@checked}}
    class={{cn
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground"
      @class
    }}
    role="menuitemradio"
    ...attributes
  >
    <span class="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      {{#if @checked}}
        <Circle class="size-2 fill-current" />
      {{/if}}
    </span>
    {{yield}}
  </div>
</template>;

// MenubarLabel Component
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

const MenubarLabel: TOC<MenubarLabelSignature> = <template>
  <div
    class={{cn "px-2 py-1.5 text-sm font-semibold" (if @inset "pl-8") @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// MenubarSeparator Component
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
    class={{cn "-mx-1 my-1 h-px bg-border" @class}}
    role="separator"
    ...attributes
  ></div>
</template>;

// MenubarShortcut Component
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
    class={{cn "ml-auto text-xs tracking-widest text-muted-foreground" @class}}
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
  MenubarItem,
  MenubarGroup,
  MenubarPortal,
  MenubarRadioGroup,
  MenubarSub,
  MenubarSubTrigger,
  MenubarSubContent,
  MenubarCheckboxItem,
  MenubarRadioItem,
  MenubarLabel,
  MenubarSeparator,
  MenubarShortcut,
};
