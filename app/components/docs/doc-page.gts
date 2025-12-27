import Component from '@glimmer/component';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { cn } from '@/lib/utils';
import DocToc, { type TocItem } from './doc-toc';
import DocLinkTo from './doc-link-to';
import { getAdjacentPages, type AdjacentPages } from '@/lib/docs-navigation';
import ArrowLeft from '~icons/lucide/arrow-left';
import ArrowRight from '~icons/lucide/arrow-right';

interface DocPageSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    tocItems?: TocItem[];
  };
  Blocks: {
    default: [];
  };
}

export default class DocPage extends Component<DocPageSignature> {
  @service declare router: RouterService;

  get adjacentPages(): AdjacentPages {
    const currentRoute = this.router.currentRouteName;
    const currentPath = this.router.currentRoute?.params?.['path'];
    if (!currentRoute) {
      return { prev: undefined, next: undefined };
    }
    return getAdjacentPages(currentRoute, currentPath as string | undefined);
  }

  get shouldShowToc(): boolean {
    return this.args.tocItems !== undefined;
  }

  <template>
    <div class="flex items-stretch text-[1.05rem] sm:text-[15px] xl:w-full">
      <div class="flex min-w-0 flex-1 flex-col">
        <div
          class={{cn
            "mx-auto flex w-full max-w-2xl min-w-0 flex-1 flex-col gap-8 px-4 py-6 text-neutral-800 md:px-0 lg:py-8 dark:text-neutral-300"
            @class
          }}
          ...attributes
        >
          {{yield}}
        </div>
        <div
          class="mx-auto hidden h-16 w-full max-w-2xl items-center gap-2 px-4 sm:flex md:px-0"
        >
          {{#if this.adjacentPages.prev}}
            <DocLinkTo
              @route={{this.adjacentPages.prev.route}}
              class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 h-8 rounded-md gap-1.5 px-3 has-[>svg]:px-2.5 shadow-none"
            >
              <ArrowLeft />
              {{this.adjacentPages.prev.title}}
            </DocLinkTo>
          {{/if}}
          {{#if this.adjacentPages.next}}
            <DocLinkTo
              @route={{this.adjacentPages.next.route}}
              class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 h-8 rounded-md gap-1.5 px-3 has-[>svg]:px-2.5 ml-auto shadow-none"
            >
              {{this.adjacentPages.next.title}}
              <ArrowRight />
            </DocLinkTo>
          {{/if}}
        </div>
      </div>
      {{#if this.shouldShowToc}}
        <DocToc @items={{@tocItems}} />
      {{/if}}
    </div>
  </template>
}
