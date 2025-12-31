import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocEmphasisSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocEmphasis: TOC<DocEmphasisSignature> = <template>
  <em class={{cn "text-muted-foreground" @class}} ...attributes>
    {{yield}}
  </em>
</template>;

export default DocEmphasis;
