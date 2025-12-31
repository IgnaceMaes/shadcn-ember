import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocListSignature {
  Element: HTMLUListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const DocList: TOC<DocListSignature> = <template>
  <ul class={{cn "my-6 ml-6 list-disc" @class}} ...attributes>
    {{yield}}
  </ul>
</template>;

interface DocListItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const DocListItem: TOC<DocListItemSignature> = <template>
  <li class={{cn "mt-2" @class}} ...attributes>
    {{yield}}
  </li>
</template>;
