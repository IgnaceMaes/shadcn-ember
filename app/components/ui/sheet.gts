import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';

import X from '~icons/lucide/x';

type Side = 'top' | 'bottom' | 'left' | 'right';

function sheetVariants(side: Side = 'right', className?: string): string {
  const baseClasses =
    'bg-background data-[state=open]:animate-in data-[state=closed]:animate-out fixed z-50 flex flex-col gap-4 shadow-lg transition ease-in-out data-[state=closed]:duration-300 data-[state=open]:duration-500';

  const sideClasses: Record<Side, string> = {
    right:
      'data-[state=closed]:slide-out-to-right data-[state=open]:slide-in-from-right inset-y-0 right-0 h-full w-3/4 border-l sm:max-w-sm',
    left: 'data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm',
    top: 'data-[state=closed]:slide-out-to-top data-[state=open]:slide-in-from-top inset-x-0 top-0 h-auto border-b',
    bottom:
      'data-[state=closed]:slide-out-to-bottom data-[state=open]:slide-in-from-bottom inset-x-0 bottom-0 h-auto border-t',
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

class Sheet extends Component<SheetSignature> {
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

  <template>
    <div data-slot="sheet">
      {{yield this.open this.setOpen}}
    </div>
  </template>
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

class SheetTrigger extends Component<SheetTriggerSignature> {
  handleClick = () => {
    this.args.setOpen?.(true);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        class={{cn @class}}
        data-slot="sheet-trigger"
        type="button"
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

class SheetClose extends Component<SheetCloseSignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        class={{cn @class}}
        data-slot="sheet-close"
        type="button"
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

const SheetPortal: TOC<SheetPortalSignature> = <template>
  <div data-slot="sheet-portal">
    {{yield}}
  </div>
</template>;

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

class SheetOverlay extends Component<SheetOverlaySignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @isOpen}}
      {{! template-lint-disable no-invalid-interactive }}
      <div
        class={{cn
          "data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 fixed inset-0 z-50 bg-black/50"
          @class
        }}
        data-slot="sheet-overlay"
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

class SheetContent extends Component<SheetContentSignature> {
  get classes() {
    return sheetVariants(this.args.side ?? 'right', this.args.class);
  }

  <template>
    {{#if @isOpen}}
      <SheetPortal>
        <SheetOverlay @isOpen={{@isOpen}} @setOpen={{@setOpen}} />
        <div
          class={{this.classes}}
          data-slot="sheet-content"
          data-state={{if @isOpen "open" "closed"}}
          role="dialog"
          ...attributes
        >
          {{yield}}
          <button
            class="ring-offset-background focus:ring-ring data-[state=open]:bg-secondary absolute top-4 right-4 rounded-xs opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none"
            type="button"
            {{on "click" (if @setOpen (fn @setOpen false) (fn))}}
          >
            <X class="size-4" />
            <span class="sr-only">Close</span>
          </button>
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

const SheetHeader: TOC<SheetHeaderSignature> = <template>
  <div
    class={{cn "flex flex-col gap-1.5 p-4" @class}}
    data-slot="sheet-header"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

const SheetFooter: TOC<SheetFooterSignature> = <template>
  <div
    class={{cn "mt-auto flex flex-col gap-2 p-4" @class}}
    data-slot="sheet-footer"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

const SheetTitle: TOC<SheetTitleSignature> = <template>
  <h2
    class={{cn "text-foreground font-semibold" @class}}
    data-slot="sheet-title"
    ...attributes
  >
    {{yield}}
  </h2>
</template>;

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

const SheetDescription: TOC<SheetDescriptionSignature> = <template>
  <p
    class={{cn "text-muted-foreground text-sm" @class}}
    data-slot="sheet-description"
    ...attributes
  >
    {{yield}}
  </p>
</template>;

export {
  Sheet,
  SheetTrigger,
  SheetClose,
  SheetPortal,
  SheetOverlay,
  SheetContent,
  SheetHeader,
  SheetFooter,
  SheetTitle,
  SheetDescription,
};
