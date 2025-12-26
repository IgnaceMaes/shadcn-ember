/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import { cn } from '@/lib/utils';
// import PhX from 'ember-phosphor-icons/components/ph-x';
import X from '~icons/lucide/x';

type Side = 'top' | 'bottom' | 'left' | 'right';

function sheetVariants(side: Side = 'right', className?: string): string {
  const baseClasses =
    'fixed z-50 gap-4 bg-background p-6 shadow-lg transition ease-in-out data-[state=closed]:duration-300 data-[state=open]:duration-500 data-[state=open]:animate-in data-[state=closed]:animate-out';

  const sideClasses: Record<Side, string> = {
    top: 'inset-x-0 top-0 border-b data-[state=closed]:slide-out-to-top data-[state=open]:slide-in-from-top',
    bottom:
      'inset-x-0 bottom-0 border-t data-[state=closed]:slide-out-to-bottom data-[state=open]:slide-in-from-bottom',
    left: 'inset-y-0 left-0 h-full w-3/4 border-r data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left sm:max-w-sm',
    right:
      'inset-y-0 right-0 h-full w-3/4 border-l data-[state=closed]:slide-out-to-right data-[state=open]:slide-in-from-right sm:max-w-sm',
  };

  return cn(baseClasses, sideClasses[side], className);
}

// Sheet Root Component
interface SheetSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

export class Sheet extends Component<SheetSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: SheetSignature['Args']) {
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

// SheetTrigger Component
interface SheetTriggerSignature {
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

export class SheetTrigger extends Component<SheetTriggerSignature> {
  handleClick = () => {
    this.args.setOpen?.(true);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
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

// SheetClose Component
interface SheetCloseSignature {
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

export class SheetClose extends Component<SheetCloseSignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
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

// SheetPortal Component
interface SheetPortalSignature {
  Blocks: {
    default: [];
  };
}

export class SheetPortal extends Component<SheetPortalSignature> {
  <template>
    {{! template-lint-disable no-yield-only }}
    {{yield}}
  </template>
}

// SheetOverlay Component
interface SheetOverlaySignature {
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

export class SheetOverlay extends Component<SheetOverlaySignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      {{! template-lint-disable no-invalid-interactive }}
      <div
        class={{cn
          "fixed inset-0 z-50 bg-black/80 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        {{on "click" this.handleClick}}
        ...attributes
      ></div>
    {{/if}}
  </template>
}

// SheetContent Component
interface SheetContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    side?: Side;
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

export class SheetContent extends Component<SheetContentSignature> {
  get classes() {
    return sheetVariants(this.args.side ?? 'right', this.args.class);
  }

  <template>
    {{#if @isOpen}}
      <SheetPortal>
        <SheetOverlay @isOpen={{@isOpen}} @setOpen={{@setOpen}} />
        <div
          class={{this.classes}}
          data-state={{if @isOpen "open" "closed"}}
          role="dialog"
          ...attributes
        >
          <button
            type="button"
            class="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-secondary"
            {{on "click" (if @setOpen (fn @setOpen false) (fn))}}
          >
            <X class="size-4" />
            <span class="sr-only">Close</span>
          </button>
          {{yield}}
        </div>
      </SheetPortal>
    {{/if}}
  </template>
}

// SheetHeader Component
interface SheetHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SheetHeader extends Component<SheetHeaderSignature> {
  <template>
    <div
      class={{cn "flex flex-col space-y-2 text-center sm:text-left" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// SheetFooter Component
interface SheetFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SheetFooter extends Component<SheetFooterSignature> {
  <template>
    <div
      class={{cn
        "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// SheetTitle Component
interface SheetTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SheetTitle extends Component<SheetTitleSignature> {
  <template>
    <h2
      class={{cn "text-lg font-semibold text-foreground" @class}}
      ...attributes
    >
      {{yield}}
    </h2>
  </template>
}

// SheetDescription Component
interface SheetDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SheetDescription extends Component<SheetDescriptionSignature> {
  <template>
    <p class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
      {{yield}}
    </p>
  </template>
}

export default Sheet;
