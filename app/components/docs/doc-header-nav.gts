import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

interface DocHeaderNavSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    logo?: [];
    nav?: [];
    actions?: [];
  };
}

const DocHeaderNav: TOC<DocHeaderNavSignature> = <template>
  <header
    class={{cn
      "sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
      @class
    }}
    ...attributes
  >
    <div class="container flex h-14 items-center">
      <div class="mr-4 flex">
        {{yield to="logo"}}
      </div>
      <nav class="flex flex-1 items-center space-x-6 text-sm font-medium">
        {{yield to="nav"}}
      </nav>
      <div class="flex items-center space-x-2">
        {{yield to="actions"}}
      </div>
    </div>
  </header>
</template>;

export default DocHeaderNav;
