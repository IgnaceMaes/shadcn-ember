import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import { buttonVariants } from './button.gts';

// AlertDialog Root Component
interface AlertDialogSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [isOpen: boolean, setOpen: (open: boolean) => void];
  };
}

class AlertDialog extends Component<AlertDialogSignature> {
  @tracked isOpen: boolean;

  constructor(owner: Owner, args: AlertDialogSignature['Args']) {
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

// AlertDialogTrigger Component
interface AlertDialogTriggerSignature {
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

class AlertDialogTrigger extends Component<AlertDialogTriggerSignature> {
  handleClick = () => {
    this.args.setOpen?.(true);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        class={{cn @class}}
        type="button"
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

// AlertDialogPortal Component
interface AlertDialogPortalSignature {
  Blocks: {
    default: [];
  };
}

const AlertDialogPortal: TOC<AlertDialogPortalSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

// AlertDialogOverlay Component
interface AlertDialogOverlaySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

const AlertDialogOverlay: TOC<AlertDialogOverlaySignature> = <template>
  {{#if @isOpen}}
    <div
      class={{cn
        "fixed inset-0 z-50 bg-black/80 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0"
        @class
      }}
      data-state={{if @isOpen "open" "closed"}}
      ...attributes
    ></div>
  {{/if}}
</template>;

// AlertDialogContent Component
interface AlertDialogContentSignature {
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

const AlertDialogContent: TOC<AlertDialogContentSignature> = <template>
  {{#if @isOpen}}
    <AlertDialogPortal>
      <AlertDialogOverlay @isOpen={{@isOpen}} />
      <div
        class={{cn
          "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        role="alertdialog"
        ...attributes
      >
        {{yield}}
      </div>
    </AlertDialogPortal>
  {{/if}}
</template>;

// AlertDialogHeader Component
interface AlertDialogHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AlertDialogHeader: TOC<AlertDialogHeaderSignature> = <template>
  <div
    class={{cn "flex flex-col space-y-2 text-center sm:text-left" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// AlertDialogFooter Component
interface AlertDialogFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AlertDialogFooter: TOC<AlertDialogFooterSignature> = <template>
  <div
    class={{cn
      "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// AlertDialogTitle Component
interface AlertDialogTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AlertDialogTitle: TOC<AlertDialogTitleSignature> = <template>
  <h2 class={{cn "text-lg font-semibold" @class}} ...attributes>
    {{yield}}
  </h2>
</template>;

// AlertDialogDescription Component
interface AlertDialogDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AlertDialogDescription: TOC<AlertDialogDescriptionSignature> = <template>
  <p class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
    {{yield}}
  </p>
</template>;

// AlertDialogAction Component
interface AlertDialogActionSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class AlertDialogAction extends Component<AlertDialogActionSignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    <button
      class={{cn (buttonVariants) @class}}
      type="button"
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

// AlertDialogCancel Component
interface AlertDialogCancelSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    setOpen?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

class AlertDialogCancel extends Component<AlertDialogCancelSignature> {
  handleClick = () => {
    this.args.setOpen?.(false);
  };

  <template>
    <button
      class={{cn
        "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0 border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground h-9 px-4 py-2 mt-2 sm:mt-0"
        @class
      }}
      type="button"
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

export {
  AlertDialog,
  AlertDialogTrigger,
  AlertDialogPortal,
  AlertDialogOverlay,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogAction,
  AlertDialogCancel,
};
