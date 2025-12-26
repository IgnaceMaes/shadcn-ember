import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocCodeSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocCode extends Component<DocCodeSignature> {
  <template>
    <code
      class={{cn
        "bg-muted relative rounded-md px-[0.3rem] py-[0.2rem] font-mono text-[0.8rem] break-words outline-none"
        @class
      }}
      ...attributes
    >
      {{~yield~}}
    </code>
  </template>
}
