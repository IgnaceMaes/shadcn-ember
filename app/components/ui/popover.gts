import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';

// Popover Root Component
interface PopoverSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

class Popover extends Component<PopoverSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: PopoverSignature['Args']) {
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

// PopoverTrigger Component
interface PopoverTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class PopoverTrigger extends Component<PopoverTriggerSignature> {
  handleClick = () => {
    const currentOpen = this.args.setOpen !== undefined;
    this.args.setOpen?.(!currentOpen);
  };

  <template>
    {{#if @asChild}}
      <span
        role="button"
        tabindex="0"
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
      >
        {{yield}}
      </span>
    {{else}}
      <button
        type="button"
        class={{cn @class}}
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

// PopoverAnchor Component
interface PopoverAnchorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const PopoverAnchor: TOC<PopoverAnchorSignature> = <template>
  <div class={{cn @class}} ...attributes>
    {{yield}}
  </div>
</template>;

// PopoverContent Component
interface PopoverContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    align?: 'start' | 'center' | 'end';
    sideOffset?: number;
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class PopoverContent extends Component<PopoverContentSignature> {
  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 w-72 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 top-full left-0 mt-2"
          @class
        }}
        data-popover-content
        data-state={{if @isOpen "open" "closed"}}
        role="dialog"
        {{onClickOutside this.handleClickOutside}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export { Popover, PopoverTrigger, PopoverContent, PopoverAnchor };
