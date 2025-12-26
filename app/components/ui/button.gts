import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

type Variant =
  | 'default'
  | 'destructive'
  | 'outline'
  | 'secondary'
  | 'ghost'
  | 'link';
type Size = 'default' | 'sm' | 'lg' | 'icon';

interface ButtonSignature {
  Element: HTMLButtonElement;
  Args: {
    variant?: Variant;
    size?: Size;
    class?: string;
    asChild?: boolean;
    type?: 'button' | 'submit' | 'reset';
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

function buttonVariants(
  variant: Variant = 'default',
  size: Size = 'default',
  className?: string
): string {
  const baseClasses =
    'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0';

  const variantClasses: Record<Variant, string> = {
    default: 'bg-primary text-primary-foreground shadow hover:bg-primary/90',
    destructive:
      'bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90',
    outline:
      'border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground',
    secondary:
      'bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/80',
    ghost: 'hover:bg-accent hover:text-accent-foreground',
    link: 'text-primary underline-offset-4 hover:underline',
  };

  const sizeClasses: Record<Size, string> = {
    default: 'h-9 px-4 py-2',
    sm: 'h-8 rounded-md px-3 text-xs',
    lg: 'h-10 rounded-md px-8',
    icon: 'h-9 w-9',
  };

  return cn(baseClasses, variantClasses[variant], sizeClasses[size], className);
}

export default class Button extends Component<ButtonSignature> {
  get classes() {
    return buttonVariants(
      this.args.variant ?? 'default',
      this.args.size ?? 'default',
      this.args.class
    );
  }

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        class={{this.classes}}
        type={{if @type @type "button"}}
        disabled={{@disabled}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

export { buttonVariants };
