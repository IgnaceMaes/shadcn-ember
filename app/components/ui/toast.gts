/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
// import PhX from 'ember-phosphor-icons/components/ph-x';
import X from '~icons/lucide/x';

type Variant = 'default' | 'destructive';

function toastVariants(
  variant: Variant = 'default',
  className?: string
): string {
  const baseClasses =
    'group pointer-events-auto relative flex w-full items-center justify-between space-x-2 overflow-hidden rounded-md border p-4 pr-6 shadow-lg transition-all data-[swipe=cancel]:translate-x-0 data-[swipe=end]:translate-x-[var(--radix-toast-swipe-end-x)] data-[swipe=move]:translate-x-[var(--radix-toast-swipe-move-x)] data-[swipe=move]:transition-none data-[state=open]:animate-in data-[state=closed]:animate-out data-[swipe=end]:animate-out data-[state=closed]:fade-out-80 data-[state=closed]:slide-out-to-right-full data-[state=open]:slide-in-from-top-full data-[state=open]:sm:slide-in-from-bottom-full';

  const variantClasses: Record<Variant, string> = {
    default: 'border bg-background text-foreground',
    destructive:
      'destructive group border-destructive bg-destructive text-destructive-foreground',
  };

  return cn(baseClasses, variantClasses[variant], className);
}

// ToastProvider Component
interface ToastProviderSignature {
  Args: {
    duration?: number;
  };
  Blocks: {
    default: [];
  };
}

export class ToastProvider extends Component<ToastProviderSignature> {
  <template>{{yield}}</template>
}

// ToastViewport Component
interface ToastViewportSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToastViewport extends Component<ToastViewportSignature> {
  <template>
    <div
      class={{cn
        "fixed top-0 z-[100] flex max-h-screen w-full flex-col-reverse p-4 sm:bottom-0 sm:right-0 sm:top-auto sm:flex-col md:max-w-[420px]"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// Toast Root Component
interface ToastSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    variant?: Variant;
  };
  Blocks: {
    default: [];
  };
}

export class Toast extends Component<ToastSignature> {
  get classes() {
    return toastVariants(this.args.variant ?? 'default', this.args.class);
  }

  <template>
    <div class={{this.classes}} role="alert" ...attributes>
      {{yield}}
    </div>
  </template>
}

// ToastAction Component
interface ToastActionSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    altText?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToastAction extends Component<ToastActionSignature> {
  <template>
    <button
      type="button"
      class={{cn
        "inline-flex h-8 shrink-0 items-center justify-center rounded-md border bg-transparent px-3 text-sm font-medium transition-colors hover:bg-secondary focus:outline-none focus:ring-1 focus:ring-ring disabled:pointer-events-none disabled:opacity-50 group-[.destructive]:border-muted/40 group-[.destructive]:hover:border-destructive/30 group-[.destructive]:hover:bg-destructive group-[.destructive]:hover:text-destructive-foreground group-[.destructive]:focus:ring-destructive"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

// ToastClose Component
interface ToastCloseSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToastClose extends Component<ToastCloseSignature> {
  <template>
    <button
      type="button"
      class={{cn
        "absolute right-1 top-1 rounded-md p-1 text-foreground/50 opacity-0 transition-opacity hover:text-foreground focus:opacity-100 focus:outline-none focus:ring-1 group-hover:opacity-100 group-[.destructive]:text-red-300 group-[.destructive]:hover:text-red-50 group-[.destructive]:focus:ring-red-400 group-[.destructive]:focus:ring-offset-red-600"
        @class
      }}
      ...attributes
    >
      <X class="size-4" />
    </button>
  </template>
}

// ToastTitle Component
interface ToastTitleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToastTitle extends Component<ToastTitleSignature> {
  <template>
    <div
      class={{cn "text-sm font-semibold [&+div]:text-xs" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// ToastDescription Component
interface ToastDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToastDescription extends Component<ToastDescriptionSignature> {
  <template>
    <div class={{cn "text-sm opacity-90" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export default Toast;
export { toastVariants };
