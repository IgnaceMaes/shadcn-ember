import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { cn } from '@/lib/utils';

interface DocSidebarLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    route: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocSidebarLink extends Component<DocSidebarLinkSignature> {
  <template>
    <LinkTo
      @route={{@route}}
      class={{cn
        "group flex w-full items-center rounded-md border border-transparent px-2 py-1 hover:underline text-muted-foreground"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </LinkTo>
  </template>
}
