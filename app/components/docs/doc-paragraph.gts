import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface DocParagraphSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocParagraph: TOC<DocParagraphSignature> = <template>
  <p
    class={{cn "leading-relaxed [&:not(:first-child)]:mt-6" @class}}
    ...attributes
  >
    {{yield}}
  </p>
</template>;

export default DocParagraph;
