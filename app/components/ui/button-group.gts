import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
import Separator from '@/components/ui/separator';

type Orientation = 'horizontal' | 'vertical';

interface ButtonGroupSignature {
  Element: HTMLDivElement;
  Args: {
    orientation?: Orientation;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

interface ButtonGroupTextSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

interface ButtonGroupSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    orientation?: Orientation;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

function buttonGroupVariants(
  orientation: Orientation = 'horizontal',
  className?: string
): string {
  const baseClasses =
    "flex w-fit items-stretch [&>*]:focus-visible:z-10 [&>*]:focus-visible:relative [&>[data-slot=select-trigger]:not([class*='w-'])]:w-fit [&>input]:flex-1 has-[select[aria-hidden=true]:last-child]:[&>[data-slot=select-trigger]:last-of-type]:rounded-r-md has-[>[data-slot=button-group]]:gap-2";

  const orientationClasses: Record<Orientation, string> = {
    horizontal:
      '[&>*:not(:first-child)]:rounded-l-none [&>*:not(:first-child)]:border-l-0 [&>*:not(:last-child)]:rounded-r-none',
    vertical:
      'flex-col [&>*:not(:first-child)]:rounded-t-none [&>*:not(:first-child)]:border-t-0 [&>*:not(:last-child)]:rounded-b-none',
  };

  return cn(baseClasses, orientationClasses[orientation], className);
}

export class ButtonGroup extends Component<ButtonGroupSignature> {
  get classes() {
    return buttonGroupVariants(
      this.args.orientation ?? 'horizontal',
      this.args.class
    );
  }

  <template>
    <div
      role="group"
      data-slot="button-group"
      data-orientation={{if @orientation @orientation "horizontal"}}
      class={{this.classes}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

export class ButtonGroupText extends Component<ButtonGroupTextSignature> {
  get classes() {
    return cn(
      "bg-muted flex items-center gap-2 rounded-md border px-4 text-sm font-medium shadow-xs [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4",
      this.args.class
    );
  }

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <div class={{this.classes}} ...attributes>
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export class ButtonGroupSeparator extends Component<ButtonGroupSeparatorSignature> {
  get classes() {
    return cn(
      'bg-input relative !m-0 self-stretch data-[orientation=vertical]:h-auto',
      this.args.class
    );
  }

  <template>
    <Separator
      data-slot="button-group-separator"
      @orientation={{if @orientation @orientation "vertical"}}
      @class={{this.classes}}
      ...attributes
    />
  </template>
}

export { buttonGroupVariants };
