import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { eq } from 'ember-truth-helpers';
import { Button } from '@/components/ui/button';

export interface TocItem {
  id: string;
  title: string;
  depth: number;
}

interface DocTocSignature {
  Element: HTMLDivElement;
  Args: {
    items: TocItem[];
  };
}

export default class DocToc extends Component<DocTocSignature> {
  @tracked activeId: string | null = null;

  observeTocHeadings = modifier((element: Element, [items]: [TocItem[]]) => {
    const observer = new IntersectionObserver(
      (entries) => {
        // Find the first intersecting entry that's near the top of the viewport
        const intersecting = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top);

        if (intersecting.length > 0) {
          const topEntry = intersecting[0];
          if (topEntry) {
            this.activeId = topEntry.target.id;
          }
        }
      },
      {
        rootMargin: '-100px 0px -66% 0px',
        threshold: 0,
      }
    );

    // Observe all heading elements
    requestAnimationFrame(() => {
      items.forEach((item) => {
        const headingElement = document.getElementById(item.id);
        if (headingElement) {
          observer.observe(headingElement);
        }
      });
    });

    return () => {
      observer.disconnect();
    };
  });

  <template>
    <div
      class="sticky top-[calc(var(--header-height)+1px)] z-30 ml-auto hidden h-[calc(100svh-var(--footer-height)+2rem)] w-72 flex-col gap-4 overflow-hidden overscroll-none pb-8 xl:flex"
      {{this.observeTocHeadings @items}}
      ...attributes
    >
      <div class="h-[var(--top-spacing)] shrink-0"></div>
      <div class="no-scrollbar overflow-y-auto px-8">
        {{#if @items.length}}
          <div class="flex flex-col gap-2 p-4 pt-0 text-sm">
            <p
              class="text-muted-foreground bg-background sticky top-0 h-6 text-xs"
            >
              On This Page
            </p>
            {{#each @items as |item|}}
              <a
                class="text-muted-foreground hover:text-foreground data-[active=true]:text-foreground text-[0.8rem] no-underline transition-colors data-[depth=3]:pl-4 data-[depth=4]:pl-6"
                data-active={{if (eq this.activeId item.id) "true" "false"}}
                data-depth={{item.depth}}
                href="#{{item.id}}"
              >
                {{item.title}}
              </a>
            {{/each}}
          </div>
          <div class="h-12"></div>
        {{/if}}
      </div>
      <div class="flex flex-1 flex-col gap-12 px-6">
        <div
          class="bg-muted group relative flex flex-col gap-2 rounded-lg p-6 text-sm"
        >
          <div
            class="text-balance text-base font-semibold leading-tight group-hover:underline"
          >
            Help build shadcn-ember
          </div>
          <div class="text-muted-foreground">
            shadcn-ember is open source and community-driven.
          </div>
          <div class="text-muted-foreground">
            Contribute components, fix bugs, or improve documentation on GitHub.
          </div>
          <Button @class="mt-2 w-fit">
            Contribute on GitHub
          </Button>
          <a
            class="absolute inset-0"
            href="https://github.com/IgnaceMaes/shadcn-ember"
            rel="noopener noreferrer"
            target="_blank"
          >
            <span class="sr-only">Contribute on GitHub</span>
          </a>
        </div>
      </div>
    </div>
  </template>
}
