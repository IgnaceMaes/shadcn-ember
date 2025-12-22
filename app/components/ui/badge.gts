import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

type Variant = 'default' | 'secondary' | 'destructive' | 'outline';

interface BadgeSignature {
  Element: HTMLDivElement;
  Args: {
    variant?: Variant;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

function badgeVariants(
  variant: Variant = 'default',
  className?: string
): string {
  const baseClasses =
    'inline-flex items-center rounded-md border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2';

  const variantClasses: Record<Variant, string> = {
    default:
      'border-transparent bg-primary text-primary-foreground shadow hover:bg-primary/80',
    secondary:
      'border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80',
    destructive:
      'border-transparent bg-destructive text-destructive-foreground shadow hover:bg-destructive/80',
    outline: 'text-foreground',
  };

  return cn(baseClasses, variantClasses[variant], className);
}

export default class Badge extends Component<BadgeSignature> {
  get classes() {
    return badgeVariants(this.args.variant ?? 'default', this.args.class);
  }

  <template>
    <div class={{this.classes}} ...attributes>
      {{yield}}
    </div>
  </template>
}
