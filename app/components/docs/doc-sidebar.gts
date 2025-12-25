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
        "fixed top-14 z-30 hidden h-[calc(100vh-3.5rem)] w-full shrink-0 overflow-y-auto border-r py-6 pr-2 md:sticky md:block lg:py-8"
        @class
      }}
      ...attributes
    >
      <div class="space-y-4">
        {{yield}}
      </div>
    </aside>
  </template>
}
