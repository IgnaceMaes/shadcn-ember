import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocSidebarSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocSidebar extends Component<DocSidebarSignature> {
  <template>
    <aside
      class={{cn
        "sticky top-[calc(var(--header-height)+1px)] z-30 hidden h-[calc(100svh-var(--footer-height)-4rem)] overscroll-none bg-transparent lg:flex"
        @class
      }}
      ...attributes
    >
      <div class="no-scrollbar overflow-x-hidden px-2">
        <div class="from-background via-background/80 to-background/50 sticky -top-1 z-10 h-8 shrink-0 bg-gradient-to-b blur-xs" />
        {{yield}}
        <div class="from-background via-background/80 to-background/50 sticky -bottom-1 z-10 h-16 shrink-0 bg-gradient-to-t blur-xs" />
      </div>
    </aside>
  </template>
}
