import Component from '@glimmer/component';
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

export class Skeleton extends Component<SkeletonSignature> {
  <template>
    <div class={{cn "animate-pulse rounded-md bg-primary/10" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export default Skeleton;
