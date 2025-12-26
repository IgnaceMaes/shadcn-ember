import { cn } from '@/lib/utils';
import DocToc, { type TocItem } from './doc-toc';
import type { TOC } from '@ember/component/template-only';

interface DocPageSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    tocItems?: TocItem[];
  };
  Blocks: {
    default: [];
  };
}

const DocPage: TOC<DocPageSignature> = <template>
  <div class="flex items-stretch text-[1.05rem] sm:text-[15px] xl:w-full">
    <div class="flex min-w-0 flex-1 flex-col">
      <div
        class={{cn
          "mx-auto flex w-full max-w-2xl min-w-0 flex-1 flex-col gap-8 px-4 py-6 text-neutral-800 md:px-0 lg:py-8 dark:text-neutral-300"
          @class
        }}
        ...attributes
      >
        {{yield}}
      </div>
    </div>
    {{#if @tocItems}}
      <DocToc @items={{@tocItems}} />
    {{/if}}
  </div>
</template>;

export default DocPage;
