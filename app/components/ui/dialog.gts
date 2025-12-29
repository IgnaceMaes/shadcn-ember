import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import type Owner from '@ember/owner';
import { provide, consume } from 'ember-provide-consume-context';
import { cn } from '@/lib/utils';
import XIcon from '~icons/lucide/x';

const DialogContext = 'dialog-context' as const;

interface DialogContextValue {
  open: boolean;
  setOpen: (open: boolean) => void;
}

interface ContextRegistry {
  [DialogContext]: DialogContextValue;
}

interface DialogSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    class?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

class Dialog extends Component<DialogSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: DialogSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? false;
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  @provide(DialogContext)
  get context(): DialogContextValue {
    return {
      open: this.open,
      setOpen: this.setOpen,
    };
  }

  <template>
    <div data-slot="dialog" class={{cn @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

interface DialogTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DialogTrigger extends Component<DialogTriggerSignature> {
  @consume(DialogContext) context!: ContextRegistry[typeof DialogContext];

  handleClick = (event: MouseEvent) => {
    event.preventDefault();
    this.context.setOpen(true);
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

interface DialogOverlaySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class DialogOverlay extends Component<DialogOverlaySignature> {
  @consume(DialogContext) context!: ContextRegistry[typeof DialogContext];

  handleClick = () => {
    this.context.setOpen(false);
  };

  <template>
    <div
      data-slot="dialog-overlay"
      class={{cn
        "data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 fixed inset-0 z-50 bg-black/50"
        @class
      }}
      data-state={{if this.context.open "open" "closed"}}
      role="button"
      tabindex="0"
      {{on "click" this.handleClick}}
      ...attributes
    ></div>
  </template>
}

interface DialogCloseSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DialogClose extends Component<DialogCloseSignature> {
  @consume(DialogContext) context!: ContextRegistry[typeof DialogContext];

  handleClick = () => {
    this.context.setOpen(false);
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

interface DialogContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    showCloseButton?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class DialogContent extends Component<DialogContentSignature> {
  @consume(DialogContext) context!: ContextRegistry[typeof DialogContext];

  get showCloseButton() {
    return this.args.showCloseButton ?? true;
  }

  handleOverlayClick = (event: MouseEvent) => {
    event.stopPropagation();
  };

  handleCloseClick = () => {
    this.context.setOpen(false);
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Escape') {
      this.context.setOpen(false);
    }
  };

  <template>
    {{#if this.context.open}}
      <DialogPortal>
        <DialogOverlay />
        <div
          data-slot="dialog-content"
          class={{cn
            "bg-background data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border p-6 shadow-lg duration-200 outline-none sm:max-w-lg"
            @class
          }}
          data-state={{if this.context.open "open" "closed"}}
          role="dialog"
          aria-modal="true"
          tabindex="-1"
          {{on "click" this.handleOverlayClick}}
          {{on "keydown" this.handleKeyDown}}
          ...attributes
        >
          {{yield}}
          {{#if this.showCloseButton}}
            <button
              data-slot="dialog-close"
              type="button"
              class="ring-offset-background focus:ring-ring data-[state=open]:bg-accent data-[state=open]:text-muted-foreground absolute top-4 right-4 rounded-xs opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
              data-state={{if this.context.open "open" "closed"}}
              {{on "click" this.handleCloseClick}}
            >
              <XIcon />
              <span class="sr-only">Close</span>
            </button>
          {{/if}}
        </div>
      </DialogPortal>
    {{/if}}
  </template>
}

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
