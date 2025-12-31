import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocStrongSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocStrong: TOC<DocStrongSignature> = <template>
  <strong class={{cn "font-medium" @class}} ...attributes>
    {{yield}}
  </strong>
</template>;

export default DocStrong;
