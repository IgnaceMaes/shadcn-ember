import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocSidebarSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const DocSidebar: TOC<DocSidebarSignature> = <template>
  <aside
    class={{cn
      "sticky top-[calc(var(--header-height)+1px)] z-30 hidden h-[calc(100svh-var(--footer-height)-4rem)] overscroll-none bg-transparent lg:flex"
      @class
    }}
    ...attributes
  >
    <div
      class="flex min-h-0 flex-1 flex-col gap-2 overflow-auto group-data-[collapsible=icon]:overflow-hidden no-scrollbar overflow-x-hidden px-2"
    >
      <div
        class="from-background via-background/80 to-background/50 sticky -top-1 z-10 h-8 shrink-0 bg-gradient-to-b blur-xs"
      />
      {{yield}}
      <div
        class="from-background via-background/80 to-background/50 sticky -bottom-1 z-10 h-16 shrink-0 bg-gradient-to-t blur-xs"
      />
    </div>
  </aside>
</template>;

export default DocSidebar;
