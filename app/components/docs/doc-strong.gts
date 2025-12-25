import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocStrongSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocStrong extends Component<DocStrongSignature> {
  <template>
    <strong class={{cn "font-medium" @class}} ...attributes>
      {{yield}}
    </strong>
  </template>
}
