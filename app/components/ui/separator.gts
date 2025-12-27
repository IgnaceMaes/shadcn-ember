import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

type Orientation = 'horizontal' | 'vertical';

interface SeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    orientation?: Orientation;
    decorative?: boolean;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

function separatorVariants(
  orientation: Orientation = 'horizontal',
  className?: string
): string {
  const baseClasses = 'shrink-0 bg-border';
  const orientationClasses: Record<Orientation, string> = {
    horizontal: 'h-[1px] w-full',
    vertical: 'h-full w-[1px]',
  };

  return cn(baseClasses, orientationClasses[orientation], className);
}

class Separator extends Component<SeparatorSignature> {
  get classes() {
    return separatorVariants(
      this.args.orientation ?? 'horizontal',
      this.args.class
    );
  }

  get role() {
    return (this.args.decorative ?? true) ? 'none' : 'separator';
  }

  get orientation() {
    return this.args.orientation ?? 'horizontal';
  }

  <template>
    <div
      role={{this.role}}
      data-orientation={{this.orientation}}
      class={{this.classes}}
      ...attributes
    ></div>
  </template>
}

export { Separator };
