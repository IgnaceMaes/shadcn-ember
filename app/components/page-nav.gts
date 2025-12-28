import { cn } from '@/lib/utils';
import type { TOC } from '@ember/component/template-only';

export interface PageNavSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const PageNav: TOC<PageNavSignature> = <template>
  <div class={{cn "container-wrapper scroll-mt-24" @class}} ...attributes>
    <div
      class="container flex items-center justify-between gap-4 py-4 m-auto px-4"
    >
      {{yield}}
    </div>
  </div>
</template>;

export { PageNav };
