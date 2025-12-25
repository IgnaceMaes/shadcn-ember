import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocListSignature {
  Element: HTMLUListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DocList extends Component<DocListSignature> {
  <template>
    <ul class={{cn "my-6 ml-6 list-disc" @class}} ...attributes>
      {{yield}}
    </ul>
  </template>
}

interface DocListItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class DocListItem extends Component<DocListItemSignature> {
  <template>
    <li class={{cn "mt-2" @class}} ...attributes>
      {{yield}}
    </li>
  </template>
}
