import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface DocCodeSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocCode: TOC<DocCodeSignature> = <template>
  <code
    class={{cn
      "bg-muted relative rounded-md px-[0.3rem] py-[0.2rem] font-mono text-[0.8rem] break-words outline-none"
      @class
    }}
    ...attributes
  >
    {{~yield~}}
  </code>
</template>;

export default DocCode;
