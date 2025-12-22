import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface KbdSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Kbd: TOC<KbdSignature> = <template>
  <kbd
    data-slot="kbd"
    class={{cn
      "bg-muted text-muted-foreground pointer-events-none inline-flex h-5 w-fit min-w-5 select-none items-center justify-center gap-1 rounded-sm px-1 font-sans text-xs font-medium [&_svg:not([class*='size-'])]:size-3 [[data-slot=tooltip-content]_&]:bg-background/20 [[data-slot=tooltip-content]_&]:text-background dark:[[data-slot=tooltip-content]_&]:bg-background/10"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </kbd>
</template>;

interface KbdGroupSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const KbdGroup: TOC<KbdGroupSignature> = <template>
  <kbd
    data-slot="kbd-group"
    class={{cn "inline-flex items-center gap-1" @class}}
    ...attributes
  >
    {{yield}}
  </kbd>
</template>;

export { Kbd as default, KbdGroup };
