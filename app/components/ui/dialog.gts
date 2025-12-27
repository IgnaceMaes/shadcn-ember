import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import X from '~icons/lucide/x';

// Dialog Root Component
interface DialogSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [
      {
        Trigger: ComponentLike<DialogTriggerSignature>;
        Content: ComponentLike<DialogContentSignature>;
        Header: ComponentLike<DialogHeaderSignature>;
        Footer: ComponentLike<DialogFooterSignature>;
        Title: ComponentLike<DialogTitleSignature>;
        Description: ComponentLike<DialogDescriptionSignature>;
        Close: ComponentLike<DialogCloseSignature>;
      },
    ];
  };
}

class Dialog extends Component<DialogSignature> {
  @tracked isOpen = this.args.open ?? false;

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  <template>
    <div data-slot="dialog">
      {{yield
        (hash
          Trigger=(component DialogTrigger open=this.open setOpen=this.setOpen)
          Content=(component DialogContent open=this.open setOpen=this.setOpen)
          Header=DialogHeader
          Footer=DialogFooter
          Title=DialogTitle
          Description=DialogDescription
          Close=(component DialogClose setOpen=this.setOpen)
        )
      }}
    </div>
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

class DialogTrigger extends Component<DialogTriggerSignature> {
  handleClick = (event: MouseEvent) => {
    event.preventDefault();
    this.args.setOpen?.(true);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        data-slot="dialog-trigger"
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

const DialogPortal: TOC<DialogPortalSignature> = <template>
  <div data-slot="dialog-portal">
    {{yield}}
  </div>
</template>;

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

class DialogOverlay extends Component<DialogOverlaySignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    <div
      data-slot="dialog-overlay"
      class={{cn
        "data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 fixed inset-0 z-50 bg-black/50"
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

class DialogClose extends Component<DialogCloseSignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        data-slot="dialog-close"
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
    showCloseButton?: boolean;
  };
  Blocks: {
    default: [setOpen: (open: boolean) => void];
  };
}

class DialogContent extends Component<DialogContentSignature> {
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
          data-slot="dialog-content"
          class={{cn
            "bg-background data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border p-6 shadow-lg duration-200 outline-none sm:max-w-lg"
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
          {{#if (if @showCloseButton @showCloseButton true)}}
            <button
              data-slot="dialog-close"
              type="button"
              class="ring-offset-background focus:ring-ring data-[state=open]:bg-accent data-[state=open]:text-muted-foreground absolute top-4 right-4 rounded-xs opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
              data-state={{if @open "open" "closed"}}
              {{on "click" this.handleCloseClick}}
            >
              <X />
              <span class="sr-only">Close</span>
            </button>
          {{/if}}
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

const DialogHeader: TOC<DialogHeaderSignature> = <template>
  <div
    data-slot="dialog-header"
    class={{cn "flex flex-col gap-2 text-center sm:text-left" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

const DialogFooter: TOC<DialogFooterSignature> = <template>
  <div
    data-slot="dialog-footer"
    class={{cn "flex flex-col-reverse gap-2 sm:flex-row sm:justify-end" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

const DialogTitle: TOC<DialogTitleSignature> = <template>
  <h2
    data-slot="dialog-title"
    class={{cn "text-lg leading-none font-semibold" @class}}
    ...attributes
  >
    {{yield}}
  </h2>
</template>;

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

const DialogDescription: TOC<DialogDescriptionSignature> = <template>
  <p
    data-slot="dialog-description"
    class={{cn "text-muted-foreground text-sm" @class}}
    ...attributes
  >
    {{yield}}
  </p>
</template>;

export {
  Dialog,
  DialogTrigger,
  DialogPortal,
  DialogOverlay,
  DialogContent,
  DialogHeader,
  DialogFooter,
  DialogTitle,
  DialogDescription,
  DialogClose,
};
