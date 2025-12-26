/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';

// TooltipProvider Component
interface TooltipProviderSignature {
  Args: {
    delayDuration?: number;
    skipDelayDuration?: number;
  };
  Blocks: {
    default: [];
  };
}

export class TooltipProvider extends Component<TooltipProviderSignature> {
  <template>
    {{! template-lint-disable no-yield-only }}
    {{yield}}
  </template>
}

// Tooltip Root Component
interface TooltipSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class Tooltip extends Component<TooltipSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: TooltipSignature['Args']) {
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

// TooltipTrigger Component
interface TooltipTriggerSignature {
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

export class TooltipTrigger extends Component<TooltipTriggerSignature> {
  handleMouseEnter = () => {
    this.args.setOpen?.(true);
  };

  handleMouseLeave = () => {
    this.args.setOpen?.(false);
  };

  handleFocus = () => {
    this.args.setOpen?.(true);
  };

  handleBlur = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @asChild}}
      <div
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
      >
        {{yield}}
      </div>
    {{else}}
      <button
        type="button"
        class={{cn @class}}
        {{on "mouseenter" this.handleMouseEnter}}
        {{on "mouseleave" this.handleMouseLeave}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

// TooltipContent Component
interface TooltipContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    sideOffset?: number;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class TooltipContent extends Component<TooltipContentSignature> {
  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 overflow-hidden rounded-md bg-primary px-3 py-1.5 text-xs text-primary-foreground animate-in fade-in-0 zoom-in-95 data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=closed]:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 bottom-full left-1/2 -translate-x-1/2 mb-2"
          @class
        }}
        role="tooltip"
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export default Tooltip;
