import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    href: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocLink extends Component<DocLinkSignature> {
  <template>
    <a
      href={{@href}}
      class={{cn "font-medium underline underline-offset-4" @class}}
      target="_blank"
      rel="noopener noreferrer"
      ...attributes
    >
      {{yield}}
    </a>
  </template>
}
