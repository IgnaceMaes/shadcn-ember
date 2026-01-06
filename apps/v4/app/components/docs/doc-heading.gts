import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

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

const DocHeading: TOC<DocHeadingSignature> = <template>
  <h2
    class={{cn
      "font-heading [&+]*:[code]:text-xl mt-10 scroll-m-28 text-xl font-medium tracking-tight first:mt-0 lg:mt-16 [&+.steps]:!mt-0 [&+.steps>h3]:!mt-4 [&+h3]:!mt-6 [&+p]:!mt-4"
      @class
    }}
    id={{@id}}
    ...attributes
  >
    {{yield}}
  </h2>
</template>;

export default DocHeading;
