import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocParagraphSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocParagraph extends Component<DocParagraphSignature> {
  <template>
    <p
      class={{cn "leading-relaxed [&:not(:first-child)]:mt-6" @class}}
      ...attributes
    >
      {{yield}}
    </p>
  </template>
}
