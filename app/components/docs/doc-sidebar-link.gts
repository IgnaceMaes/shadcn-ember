import Component from '@glimmer/component';
import { service } from '@ember/service';
import DocLinkTo from './doc-link-to';
import { cn } from '@/lib/utils';
import type RouterService from '@ember/routing/router-service';

interface DocSidebarLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    route?: string;
    href?: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocSidebarLink extends Component<DocSidebarLinkSignature> {
  @service declare router: RouterService;

  get isActive() {
    if (!this.args.route) return false;

    const currentRoute = this.router.currentRouteName;

    // Direct route match
    if (
      currentRoute === this.args.route ||
      currentRoute === `${this.args.route}.index`
    ) {
      return true;
    }

    // Check if we're on the catch-all route and compare the path
    if (currentRoute === 'docs.catch-all') {
      const currentPath = this.router.currentRoute?.params?.['path'];
      const expectedPath = this.args.route
        .replace(/^docs\./, '')
        .replace(/\./g, '/');
      return currentPath === expectedPath;
    }

    return false;
  }

  <template>
    <li class="group/menu-item relative">
      {{#if @href}}
        <a
          href={{@href}}
          class={{cn
            "peer/menu-button flex items-center gap-2 rounded-md p-2 text-left outline-hidden ring-sidebar-ring transition-[width,height,padding] focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 group-has-data-[sidebar=menu-action]/menu-item:pr-8 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-[active=true]:font-medium data-[active=true]:text-sidebar-accent-foreground data-[state=open]:hover:bg-sidebar-accent data-[state=open]:hover:text-sidebar-accent-foreground group-data-[collapsible=icon]:size-8! group-data-[collapsible=icon]:p-2! [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0 hover:bg-sidebar-accent hover:text-sidebar-accent-foreground relative h-[30px] w-fit overflow-visible border border-transparent text-[0.8rem] font-medium after:absolute after:inset-x-0 after:-inset-y-1 after:z-0 after:rounded-md"
            @class
          }}
          ...attributes
        >
          <span
            class="absolute inset-0 flex w-(--sidebar-width) bg-transparent"
          />
          {{yield}}
        </a>
      {{else}}
        <DocLinkTo
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
        </DocLinkTo>
      {{/if}}
    </li>
  </template>
}
