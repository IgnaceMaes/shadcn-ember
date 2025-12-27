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
    class={{cn "animate-pulse rounded-md bg-primary/10" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export { Skeleton };
