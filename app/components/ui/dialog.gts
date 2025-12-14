/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import PhX from 'ember-phosphor-icons/components/ph-x';

// Dialog Root Component
interface DialogSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [open: boolean, setOpen: (open: boolean) => void];
  };
}

export class Dialog extends Component<DialogSignature> {
  @tracked isOpen = this.args.open ?? false;

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

// Dialog Trigger Component
interface DialogTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    open?: boolean;
    setOpen?: (open: boolean) => void;
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class DialogTrigger extends Component<DialogTriggerSignature> {
  handleClick = (event: MouseEvent) => {
    event.preventDefault();
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

// Dialog Portal Component (just yields in Ember)
interface DialogPortalSignature {
  Blocks: {
    default: [];
  };
}

export class DialogPortal extends Component<DialogPortalSignature> {
  <template>
    <div>
      {{yield}}
    </div>
  </template>
}

// Dialog Overlay Component
interface DialogOverlaySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    open?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

export class DialogOverlay extends Component<DialogOverlaySignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    <div
      class={{cn
        "fixed inset-0 z-50 bg-black/80 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"
        @class
      }}
      data-state={{if @open "open" "closed"}}
      role="button"
      tabindex="0"
      {{on "click" this.handleClick}}
      ...attributes
    ></div>
  </template>
}

// Dialog Close Component
interface DialogCloseSignature {
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

export class DialogClose extends Component<DialogCloseSignature> {
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

// Dialog Content Component
interface DialogContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    open?: boolean;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [setOpen: (open: boolean) => void];
  };
}

export class DialogContent extends Component<DialogContentSignature> {
  handleOverlayClick = (event: MouseEvent) => {
    // Stop propagation to prevent closing when clicking inside content
    event.stopPropagation();
  };

  handleCloseClick = () => {
    this.args.setOpen?.(false);
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Escape') {
      this.args.setOpen?.(false);
    }
  };

  <template>
    {{#if @open}}
      <DialogPortal>
        <DialogOverlay @open={{@open}} @setOpen={{@setOpen}} />
        <div
          class={{cn
            "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg"
            @class
          }}
          data-state={{if @open "open" "closed"}}
          role="dialog"
          aria-modal="true"
          tabindex="-1"
          {{on "click" this.handleOverlayClick}}
          {{on "keydown" this.handleKeyDown}}
          ...attributes
        >
          {{yield (if @setOpen @setOpen (fn))}}
          <button
            type="button"
            class="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
            {{on "click" this.handleCloseClick}}
          >
            <PhX @size={{16}} />
            <span class="sr-only">Close</span>
          </button>
        </div>
      </DialogPortal>
    {{/if}}
  </template>
}

// Dialog Header Component
interface DialogHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DialogHeader extends Component<DialogHeaderSignature> {
  <template>
    <div
      class={{cn "flex flex-col space-y-1.5 text-center sm:text-left" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// Dialog Footer Component
interface DialogFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DialogFooter extends Component<DialogFooterSignature> {
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

// Dialog Title Component
interface DialogTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DialogTitle extends Component<DialogTitleSignature> {
  <template>
    <h2
      class={{cn
        "text-lg font-semibold leading-none tracking-tight"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </h2>
  </template>
}

// Dialog Description Component
interface DialogDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DialogDescription extends Component<DialogDescriptionSignature> {
  <template>
    <p class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
      {{yield}}
    </p>
  </template>
}

export default Dialog;
