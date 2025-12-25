import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocLayoutSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    sidebar: [];
    default: [];
  };
}

export default class DocLayout extends Component<DocLayoutSignature> {
  <template>
    <div class="flex-1">
      <div
        class={{cn
          "flex-1 md:grid md:grid-cols-[220px_1fr] md:gap-6 lg:grid-cols-[240px_1fr] lg:gap-10"
          @class
        }}
        ...attributes
      >
        {{yield to="sidebar"}}

        <main class="relative py-6 lg:gap-10 lg:py-8">
          {{yield}}
        </main>
      </div>
    </div>
  </template>
}
