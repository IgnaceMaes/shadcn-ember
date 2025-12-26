import Component from '@glimmer/component';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { cn } from '@/lib/utils';
import DocHeaderCopy from './doc-header-copy';
import DocLinkTo from './doc-link-to';
import { getAdjacentPages, type AdjacentPages } from '@/lib/docs-navigation';
import ArrowLeft from '~icons/lucide/arrow-left';
import ArrowRight from '~icons/lucide/arrow-right';

interface DocHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    title: string;
    description?: string;
    class?: string;
    markdown?: string;
  };
  Blocks: {
    default?: [];
  };
}

export default class DocHeader extends Component<DocHeaderSignature> {
  @service declare router: RouterService;

  get adjacentPages(): AdjacentPages {
    const currentRoute = this.router.currentRouteName;
    const currentPath = this.router.currentRoute?.params?.['path'];
    if (!currentRoute) {
      return { prev: undefined, next: undefined };
    }
    return getAdjacentPages(currentRoute, currentPath as string | undefined);
  }

  <template>
    <div class={{cn "flex flex-col gap-2" @class}} ...attributes>
      <div class="flex items-start justify-between">
        <h1
          class="scroll-m-20 text-4xl font-semibold tracking-tight sm:text-3xl xl:text-4xl"
        >
          {{@title}}
        </h1>
        <div
          class="docs-nav bg-background/80 border-border/50 fixed inset-x-0 bottom-0 isolate z-50 flex items-center gap-2 border-t px-6 py-4 backdrop-blur-sm sm:static sm:z-0 sm:border-t-0 sm:bg-transparent sm:px-0 sm:pt-1.5 sm:backdrop-blur-none"
        >
          <DocHeaderCopy @markdown={{@markdown}} />
          {{#if this.adjacentPages.prev}}
            <DocLinkTo
              @route={{this.adjacentPages.prev.route}}
              class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 extend-touch-target ml-auto size-8 shadow-none md:size-7"
            >
              <ArrowLeft />
              <span class="sr-only">Previous:
                {{this.adjacentPages.prev.title}}</span>
            </DocLinkTo>
          {{/if}}
          {{#if this.adjacentPages.next}}
            <DocLinkTo
              @route={{this.adjacentPages.next.route}}
              class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 extend-touch-target size-8 shadow-none md:size-7"
            >
              <span class="sr-only">Next:
                {{this.adjacentPages.next.title}}</span>
              <ArrowRight />
            </DocLinkTo>
          {{/if}}
        </div>
        {{yield}}
      </div>
      {{#if @description}}
        <p
          class="text-muted-foreground text-[1.05rem] text-balance sm:text-base"
        >
          {{@description}}
        </p>
      {{/if}}
    </div>
  </template>
}
