import Component from '@glimmer/component';
import { service } from '@ember/service';
import { LinkTo } from '@ember/routing';
import { cn } from '@/lib/utils';
import type RouterService from '@ember/routing/router-service';

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
  @service declare router: RouterService;

  get isActive() {
    const currentRoute = this.router.currentRouteName;
    return (
      currentRoute === this.args.route ||
      currentRoute === `${this.args.route}.index`
    );
  }

  <template>
    <li class="group/menu-item relative">
      <LinkTo
        @route={{@route}}
        class={{cn
          "peer/menu-button flex items-center gap-2 rounded-md p-2 text-left outline-hidden ring-sidebar-ring transition-[width,height,padding] focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 group-has-data-[sidebar=menu-action]/menu-item:pr-8 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-[active=true]:font-medium data-[active=true]:text-sidebar-accent-foreground data-[state=open]:hover:bg-sidebar-accent data-[state=open]:hover:text-sidebar-accent-foreground group-data-[collapsible=icon]:size-8! group-data-[collapsible=icon]:p-2! [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0 hover:bg-sidebar-accent hover:text-sidebar-accent-foreground relative h-[30px] w-fit overflow-visible border border-transparent text-[0.8rem] font-medium after:absolute after:inset-x-0 after:-inset-y-1 after:z-0 after:rounded-md"
          (if this.isActive "bg-accent border-accent")
          @class
        }}
        ...attributes
      >
        <span
          class="absolute inset-0 flex w-(--sidebar-width) bg-transparent"
        />
        {{yield}}
      </LinkTo>
    </li>
  </template>
}
