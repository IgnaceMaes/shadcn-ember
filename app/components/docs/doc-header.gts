import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
import DocHeaderCopy from './doc-header-copy';

interface DocHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    title: string;
    description?: string;
    class?: string;
    markdown?: string;
  };
  Blocks: {
    default?: [];
  };
}

const DocHeader: TOC<DocHeaderSignature> = <template>
  <div class={{cn "flex flex-col gap-2" @class}} ...attributes>
    <div class="flex items-start justify-between">
      <h1
        class="scroll-m-20 text-4xl font-semibold tracking-tight sm:text-3xl xl:text-4xl"
      >
        {{@title}}
      </h1>
      <DocHeaderCopy @markdown={{@markdown}} />
      {{yield}}
    </div>
    {{#if @description}}
      <p
        class="text-muted-foreground text-[1.05rem] text-balance sm:text-base"
      >
        {{@description}}
      </p>
    {{/if}}
  </div>
</template>;

export default DocHeader;
