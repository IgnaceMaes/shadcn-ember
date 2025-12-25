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
    <div class={{cn "mx-auto w-full min-w-0 max-w-4xl" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}
