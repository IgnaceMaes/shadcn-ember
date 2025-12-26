import type { TOC } from '@ember/component/template-only';
import Button from '@/components/ui/button';

export interface TocItem {
  id: string;
  title: string;
  depth: number;
}

interface DocTocSignature {
  Element: HTMLDivElement;
  Args: {
    items: TocItem[];
  };
}

const DocToc: TOC<DocTocSignature> = <template>
  <div
    class="sticky top-[calc(var(--header-height)+1px)] z-30 ml-auto hidden h-[calc(100svh-var(--footer-height)+2rem)] w-72 flex-col gap-4 overflow-hidden overscroll-none pb-8 xl:flex"
    ...attributes
  >
    <div class="h-[var(--top-spacing)] shrink-0"></div>
    <div class="no-scrollbar overflow-y-auto px-8">
      <div class="flex flex-col gap-2 p-4 pt-0 text-sm">
        <p class="text-muted-foreground bg-background sticky top-0 h-6 text-xs">
          On This Page
        </p>
        {{#each @items as |item|}}
          <a
            href="#{{item.id}}"
            class="text-muted-foreground hover:text-foreground text-[0.8rem] no-underline transition-colors data-[depth=3]:pl-4 data-[depth=4]:pl-6"
            data-depth={{item.depth}}
          >
            {{item.title}}
          </a>
        {{/each}}
      </div>
      <div class="h-12"></div>
    </div>
    <div class="flex flex-1 flex-col gap-12 px-6">
      <div
        class="bg-muted group relative flex flex-col gap-2 rounded-lg p-6 text-sm"
      >
        <div class="text-balance text-base font-semibold leading-tight group-hover:underline">
          Help build shadcn-ember
        </div>
        <div class="text-muted-foreground">
          shadcn-ember is open source and community-driven.
        </div>
        <div class="text-muted-foreground">
          Contribute components, fix bugs, or improve documentation on GitHub.
        </div>
        <Button @class="mt-2 w-fit">
          Contribute on GitHub
        </Button>
        <a
          href="https://github.com/IgnaceMaes/shadcn-ember"
          target="_blank"
          rel="noopener noreferrer"
          class="absolute inset-0"
        >
          <span class="sr-only">Contribute on GitHub</span>
        </a>
      </div>
    </div>
  </div>
</template>;

export default DocToc;
