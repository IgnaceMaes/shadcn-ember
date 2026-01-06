import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocListSignature {
  Element: HTMLUListElement | HTMLOListElement;
  Args: {
    class?: string;
    ordered?: boolean;
    start?: number;
  };
  Blocks: {
    default: [];
  };
}

export const DocList: TOC<DocListSignature> = <template>
  {{#if @ordered}}
    <ol
      class={{cn "my-6 ml-6 list-decimal" @class}}
      start={{@start}}
      ...attributes
    >
      {{yield}}
    </ol>
  {{else}}
    <ul class={{cn "my-6 ml-6 list-disc" @class}} ...attributes>
      {{yield}}
    </ul>
  {{/if}}
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
