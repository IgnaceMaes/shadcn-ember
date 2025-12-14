import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface AlertSignature {
  Element: HTMLDivElement;
  Args: {
    variant?: 'default' | 'destructive';
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

interface AlertTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

interface AlertDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Alert extends Component<AlertSignature> {
  get variantClasses() {
    const { variant = 'default' } = this.args;

    const variants = {
      default: 'bg-background text-foreground',
      destructive:
        'border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive',
    };

    return variants[variant];
  }

  get className() {
    return cn(
      'relative w-full rounded-lg border px-4 py-3 text-sm [&>svg+div]:translate-y-[-3px] [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground [&>svg~*]:pl-7',
      this.variantClasses,
      this.args.class
    );
  }

  <template>
    <div role="alert" class={{this.className}} ...attributes>
      {{yield}}
    </div>
  </template>
}

class AlertTitle extends Component<AlertTitleSignature> {
  get className() {
    return cn('mb-1 font-medium leading-none tracking-tight', this.args.class);
  }

  <template>
    <h5 class={{this.className}} ...attributes>
      {{yield}}
    </h5>
  </template>
}

class AlertDescription extends Component<AlertDescriptionSignature> {
  get className() {
    return cn('text-sm [&_p]:leading-relaxed', this.args.class);
  }

  <template>
    <div class={{this.className}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export { Alert, AlertTitle, AlertDescription };
export default Alert;
