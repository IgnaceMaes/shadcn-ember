import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocContent extends Component<DocContentSignature> {
  <template>
    <div
      class={{cn "w-full flex-1 pt-6" @class}}
      data-doc-content
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}
