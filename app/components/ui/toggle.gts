import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';

type Variant = 'default' | 'outline';
type Size = 'default' | 'sm' | 'lg';

interface ToggleSignature {
  Element: HTMLButtonElement;
  Args: {
    variant?: Variant;
    size?: Size;
    class?: string;
    pressed?: boolean;
    defaultPressed?: boolean;
    onPressedChange?: (pressed: boolean) => void;
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

function toggleVariants(
  variant: Variant = 'default',
  size: Size = 'default',
  className?: string
): string {
  const baseClasses =
    'inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-colors hover:bg-muted hover:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 data-[state=on]:bg-accent data-[state=on]:text-accent-foreground [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0';

  const variantClasses: Record<Variant, string> = {
    default: 'bg-transparent',
    outline:
      'border border-input bg-transparent shadow-sm hover:bg-accent hover:text-accent-foreground',
  };

  const sizeClasses: Record<Size, string> = {
    default: 'h-9 px-2 min-w-9',
    sm: 'h-8 px-1.5 min-w-8',
    lg: 'h-10 px-2.5 min-w-10',
  };

  return cn(baseClasses, variantClasses[variant], sizeClasses[size], className);
}

export default class Toggle extends Component<ToggleSignature> {
  @tracked internalPressed: boolean;

  constructor(owner: Owner, args: ToggleSignature['Args']) {
    super(owner, args);
    this.internalPressed = args.pressed ?? args.defaultPressed ?? false;
  }

  get pressed() {
    return this.args.pressed ?? this.internalPressed;
  }

  get classes() {
    return toggleVariants(
      this.args.variant ?? 'default',
      this.args.size ?? 'default',
      this.args.class
    );
  }

  handleClick = () => {
    if (!this.args.disabled) {
      const newPressed = !this.pressed;
      this.internalPressed = newPressed;
      this.args.onPressedChange?.(newPressed);
    }
  };

  <template>
    <button
      type="button"
      class={{this.classes}}
      disabled={{@disabled}}
      data-state={{if this.pressed "on" "off"}}
      aria-pressed={{this.pressed}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

export { toggleVariants };
