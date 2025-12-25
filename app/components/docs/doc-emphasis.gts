import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocEmphasisSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocEmphasis extends Component<DocEmphasisSignature> {
  <template>
    <em class={{cn "text-muted-foreground" @class}} ...attributes>
      {{yield}}
    </em>
  </template>
}
