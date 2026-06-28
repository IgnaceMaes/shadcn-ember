import { hash } from '@ember/helper';
import Component from '@glimmer/component';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

type Variant = 'default' | 'separator' | 'border';

function markerVariants(
  variant: Variant = 'default',
  className?: string
): string {
  const baseClasses =
    "group/marker relative flex min-h-4 w-full items-center gap-2 text-left text-sm text-muted-foreground [&_svg:not([class*='size-'])]:size-4 [a]:underline [a]:underline-offset-3 [a]:hover:text-foreground";

  const variantClasses: Record<Variant, string> = {
    default: '',
    separator:
      'before:mr-1 before:h-px before:min-w-0 before:flex-1 before:bg-border after:ml-1 after:h-px after:min-w-0 after:flex-1 after:bg-border',
    border: 'border-b border-border pb-2',
  };

  return cn(baseClasses, variantClasses[variant], className);
}

interface MarkerSignature {
  Element: HTMLDivElement;
  Args: {
    variant?: Variant;
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [{ classes: string }?];
  };
}

class Marker extends Component<MarkerSignature> {
  get variant(): Variant {
    return this.args.variant ?? 'default';
  }

  get classes() {
    return markerVariants(this.variant, this.args.class);
  }

  <template>
    {{#if @asChild}}
      {{yield (hash classes=this.classes)}}
    {{else}}
      <div
        class={{this.classes}}
        data-slot="marker"
        data-variant={{this.variant}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

interface MarkerIconSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MarkerIcon: TOC<MarkerIconSignature> = <template>
  <span
    aria-hidden="true"
    class={{cn "size-4 shrink-0 [&_svg:not([class*='size-'])]:size-4" @class}}
    data-slot="marker-icon"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

interface MarkerContentSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MarkerContent: TOC<MarkerContentSignature> = <template>
  <span
    class={{cn
      "min-w-0 wrap-break-word group-data-[variant=separator]/marker:flex-none group-data-[variant=separator]/marker:text-center *:[a]:underline *:[a]:underline-offset-3 *:[a]:hover:text-foreground"
      @class
    }}
    data-slot="marker-content"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

export { Marker, MarkerIcon, MarkerContent, markerVariants };
