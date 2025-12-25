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
        "relative h-[30px] w-fit overflow-visible border border-transparent text-[0.8rem] font-medium after:absolute after:inset-x-0 after:-inset-y-1 after:z-0 after:rounded-md flex items-center rounded-md px-2 text-foreground/70 hover:text-foreground [&.active]:bg-accent [&.active]:border-accent [&.active]:text-foreground"
        @class
      }}
      ...attributes
    >
      <span class="absolute inset-0 flex bg-transparent" />
      {{yield}}
    </LinkTo>
  </template>
}
