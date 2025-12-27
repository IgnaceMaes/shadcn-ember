import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface SkeletonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Skeleton: TOC<SkeletonSignature> = <template>
  <div
    data-slot="skeleton"
    class={{cn "bg-accent animate-pulse rounded-md" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export { Skeleton };
