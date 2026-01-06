import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocContent: TOC<DocContentSignature> = <template>
  <div class={{cn "w-full" @class}} data-doc-content ...attributes>
    {{yield}}
  </div>
</template>;

export default DocContent;
