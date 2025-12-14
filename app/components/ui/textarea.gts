import { cn } from '@/lib/utils';
import type { TOC } from '@ember/component/template-only';

export interface TextareaSignature {
  Element: HTMLTextAreaElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Textarea: TOC<TextareaSignature> = <template>
  <textarea
    class={{cn
      "flex min-h-[60px] w-full rounded-md border border-input bg-transparent px-3 py-2 text-base shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"
      @class
    }}
    ...attributes
  />
</template>;

export default Textarea;
