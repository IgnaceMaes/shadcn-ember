import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import onKey from 'ember-keyboard/helpers/on-key';

import { Button } from '@/components/ui/button';
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import { Kbd } from '@/components/ui/kbd';
import { docsNavigation } from '@/lib/docs-navigation';
import { cn } from '@/lib/utils';

import ArrowRight from '~icons/lucide/arrow-right';
import CircleDashed from '~icons/lucide/circle-dashed';
import CornerDownLeft from '~icons/lucide/corner-down-left';

interface CommandMenuSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class CommandMenu extends Component<CommandMenuSignature> {
  @service declare router: RouterService;
  @tracked isOpen = false;

  navItems = docsNavigation;
  componentItems = docsNavigation.filter((item) =>
    item.route.includes('components.')
  );
  pageItems = docsNavigation.filter(
    (item) => !item.route.includes('components.')
  );

  toggleOpen = () => {
    this.isOpen = !this.isOpen;
  };

  setOpen = (open: boolean) => {
    this.isOpen = open;
  };

  routeExists(route: string): boolean {
    try {
      this.router.recognize(this.router.urlFor(route));
      return true;
    } catch {
      return false;
    }
  }

  handleSelect = (route: string) => {
    this.isOpen = false;

    if (this.routeExists(route)) {
      this.router.transitionTo(route);
    } else {
      const path = route.replace(/^docs\./, '').replace(/\./g, '/');
      this.router.transitionTo('docs.catch-all', path);
    }
  };

  <template>
    {{! Global keyboard shortcuts }}
    {{onKey "cmd+k" this.toggleOpen}}
    {{onKey "/" this.toggleOpen}}

    <div class={{cn @class}} ...attributes>
      <Button
        @size="sm"
        @variant="outline"
        class="relative h-8 w-full justify-start pl-3 font-normal shadow-none sm:pr-12 md:w-48 lg:w-56 xl:w-64 text-foreground dark:bg-card hover:bg-muted/50"
        {{on "click" (fn this.setOpen true)}}
      >
        <span class="hidden lg:inline-flex">Search documentation...</span>
        <span class="inline-flex lg:hidden">Search...</span>
        <div class="absolute end-1.5 top-1.5 hidden gap-1 sm:flex">
          <Kbd>⌘K</Kbd>
        </div>
      </Button>

      <CommandDialog
        @class="rounded-xl border-none bg-clip-padding p-2 pb-11 shadow-2xl ring-4 ring-neutral-200/80 dark:bg-neutral-900 dark:ring-neutral-800"
        @description="Search for a command to run..."
        @onOpenChange={{this.setOpen}}
        @open={{this.isOpen}}
        @showCloseButton={{false}}
        @title="Search documentation..."
      >
        <CommandInput
          @class="bg-input/50 border-input rounded-md border !h-9"
          @placeholder="Search documentation..."
        />

        <CommandList @class="no-scrollbar min-h-80 scroll-pt-2 scroll-pb-1.5">
          <CommandEmpty
            @class="text-muted-foreground py-12 text-center text-sm"
          >
            No results found.
          </CommandEmpty>

          <CommandGroup
            @class="!p-0 [&_[data-cmdk-group-heading]]:scroll-mt-16 [&_[data-cmdk-group-heading]]:!p-3 [&_[data-cmdk-group-heading]]:!pb-1"
            @heading="Pages"
          >
            {{#each this.pageItems as |item|}}
              <CommandItem
                @class="data-[selected=true]:border-input data-[selected=true]:bg-input/50 hover:data-[selected=true]:bg-input/70 h-9 rounded-md border border-transparent !px-3 font-medium"
                @onSelect={{fn this.handleSelect item.route}}
                @value={{item.route}}
              >
                <ArrowRight />
                {{item.title}}
              </CommandItem>
            {{/each}}
          </CommandGroup>

          <CommandGroup @heading="Components">
            {{#each this.componentItems as |item|}}
              <CommandItem
                @class="data-[selected=true]:border-input data-[selected=true]:bg-input/50 hover:data-[selected=true]:bg-input/70 h-9 rounded-md border border-transparent !px-3 font-medium"
                @onSelect={{fn this.handleSelect item.route}}
                @value={{item.route}}
              >
                <CircleDashed
                  class="border-muted-foreground aspect-square size-4 rounded-full border border-dashed"
                />
                {{item.title}}
              </CommandItem>
            {{/each}}
          </CommandGroup>
        </CommandList>

        <div
          class="text-muted-foreground absolute inset-x-0 bottom-0 z-20 flex h-10 items-center gap-2 rounded-b-xl border-t border-t-neutral-100 bg-neutral-50 px-4 text-xs font-medium dark:border-t-neutral-700 dark:bg-neutral-800"
        >
          <div class="flex items-center gap-2">
            <kbd
              class="bg-background text-muted-foreground pointer-events-none flex h-5 items-center justify-center gap-1 rounded border px-1 font-sans text-[0.7rem] font-medium select-none [&_svg:not([class*='size-'])]:size-3"
            >
              <CornerDownLeft />
            </kbd>
            Go to Page
          </div>
        </div>
      </CommandDialog>
    </div>
  </template>
}
