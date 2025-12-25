import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocHeadingSignature {
  Element: HTMLHeadingElement;
  Args: {
    id?: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocHeading extends Component<DocHeadingSignature> {
  <template>
    <h2
      id={{@id}}
      class={{cn
        "font-heading mt-10 scroll-m-28 text-xl font-medium tracking-tight first:mt-0 lg:mt-16"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </h2>
  </template>
}
