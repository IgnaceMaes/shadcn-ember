import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocPageSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocPage extends Component<DocPageSignature> {
  <template>
    <div
      class={{cn
        "mx-auto flex w-full max-w-2xl min-w-0 flex-1 flex-col gap-8 px-4 py-6 text-neutral-800 md:px-0 lg:py-8 dark:text-neutral-300"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}
