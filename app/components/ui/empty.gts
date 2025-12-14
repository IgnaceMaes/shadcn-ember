/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cva } from 'class-variance-authority';
import { cn } from '@/lib/utils';

interface EmptySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class Empty extends Component<EmptySignature> {
  <template>
    <div
      data-slot="empty"
      class={{cn
        "flex min-w-0 flex-1 flex-col items-center justify-center gap-6 text-balance rounded-lg border-dashed p-6 text-center md:p-12"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface EmptyHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class EmptyHeader extends Component<EmptyHeaderSignature> {
  <template>
    <div
      data-slot="empty-header"
      class={{cn "flex max-w-sm flex-col items-center gap-2 text-center" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

const emptyMediaVariants = cva(
  'mb-2 flex shrink-0 items-center justify-center [&_svg]:pointer-events-none [&_svg]:shrink-0',
  {
    variants: {
      variant: {
        default: 'bg-transparent',
        icon: 'bg-muted text-foreground flex size-10 shrink-0 items-center justify-center rounded-lg [&_svg:not([class*=\'size-\'])]:size-6',
      },
    },
    defaultVariants: {
      variant: 'default',
    },
  }
);

interface EmptyMediaSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    variant?: 'default' | 'icon';
  };
  Blocks: {
    default: [];
  };
}

export class EmptyMedia extends Component<EmptyMediaSignature> {
  get classes() {
    return emptyMediaVariants({
      variant: this.args.variant ?? 'default',
      className: this.args.class,
    });
  }

  <template>
    <div
      data-slot="empty-icon"
      data-variant={{if @variant @variant "default"}}
      class={{this.classes}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface EmptyTitleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class EmptyTitle extends Component<EmptyTitleSignature> {
  <template>
    <div
      data-slot="empty-title"
      class={{cn "text-lg font-medium tracking-tight" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface EmptyDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class EmptyDescription extends Component<EmptyDescriptionSignature> {
  <template>
    <div
      data-slot="empty-description"
      class={{cn
        "text-muted-foreground [&>a:hover]:text-primary text-sm/relaxed [&>a]:underline [&>a]:underline-offset-4"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface EmptyContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class EmptyContent extends Component<EmptyContentSignature> {
  <template>
    <div
      data-slot="empty-content"
      class={{cn
        "flex w-full min-w-0 max-w-sm flex-col items-center gap-4 text-balance text-sm"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

export { Empty as default };
