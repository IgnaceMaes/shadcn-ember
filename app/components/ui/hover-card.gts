/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';

// HoverCard Root Component
interface HoverCardSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
    openDelay?: number;
    closeDelay?: number;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class HoverCard extends Component<HoverCardSignature> {
  @tracked isOpen: boolean;
  openTimeout: number | null = null;
  closeTimeout: number | null = null;

  constructor(owner: Owner, args: HoverCardSignature['Args']) {
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

// HoverCardTrigger Component
interface HoverCardTriggerSignature {
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

export class HoverCardTrigger extends Component<HoverCardTriggerSignature> {
  handleMouseEnter = () => {
    this.args.setOpen?.(true);
  };

  handleMouseLeave = () => {
    this.args.setOpen?.(false);
  };

  <template>
    <div class="relative inline-block">
      {{#if @asChild}}
        <div
          {{on "mouseenter" this.handleMouseEnter}}
          {{on "mouseleave" this.handleMouseLeave}}
        >
          {{yield}}
        </div>
      {{else}}
        <button
          type="button"
          class={{cn @class}}
          {{on "mouseenter" this.handleMouseEnter}}
          {{on "mouseleave" this.handleMouseLeave}}
          ...attributes
        >
          {{yield}}
        </button>
      {{/if}}
    </div>
  </template>
}

// HoverCardContent Component
interface HoverCardContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    align?: 'start' | 'center' | 'end';
    sideOffset?: number;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class HoverCardContent extends Component<HoverCardContentSignature> {
  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute z-50 w-64 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95"
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

export default HoverCard;
