import Component from '@glimmer/component';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import type RouterService from '@ember/routing/router-service';
import { eq } from 'ember-truth-helpers';

interface TocItem {
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
  @service declare router: RouterService;
  @tracked activeId = '';

  get tocItems() {
    return this.args.items ?? [];
  }

  <template>
    <div
      class="sticky top-[calc(var(--header-height)+1px)] z-30 ml-auto hidden h-[calc(100svh-var(--footer-height)+2rem)] w-72 flex-col gap-4 overflow-hidden overscroll-none pb-8 xl:flex"
      ...attributes
    >
      <div class="h-[var(--top-spacing)] shrink-0"></div>
      <div class="no-scrollbar overflow-y-auto px-8">
        <div class="flex flex-col gap-2 p-4 pt-0 text-sm">
          <p
            class="text-muted-foreground bg-background sticky top-0 h-6 text-xs"
          >
            On This Page
          </p>
          {{#each this.tocItems as |item|}}
            <a
              href="#{{item.id}}"
              class="text-muted-foreground hover:text-foreground data-[active=true]:text-foreground text-[0.8rem] no-underline transition-colors data-[depth=3]:pl-4 data-[depth=4]:pl-6"
              data-active={{if (eq this.activeId item.id) "true" "false"}}
              data-depth={{item.depth}}
            >
              {{item.title}}
            </a>
          {{/each}}
        </div>
        <div class="h-12"></div>
      </div>
    </div>
  </template>
}
