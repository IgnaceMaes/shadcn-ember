import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { modifier } from 'ember-modifier';
import onKey from 'ember-keyboard/helpers/on-key';
import RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import { cn } from '@/lib/utils';
import { docsNavigation } from '@/lib/docs-navigation';
import type { DocNavItem } from '@/lib/docs-navigation';
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
import ArrowRight from '~icons/lucide/arrow-right';
import CornerDownLeft from '~icons/lucide/corner-down-left';
import CircleDashed from '~icons/lucide/circle-dashed';

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
  @tracked searchValue = '';
  @tracked selectedType: 'page' | 'component' | null = null;
  @tracked selectedIndex = 0;

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
    if (!open) {
      this.searchValue = '';
      this.selectedType = null;
      this.selectedIndex = 0;
    }
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
      // Convert route to path for catch-all route
      const path = route.replace(/^docs\./, '').replace(/\./g, '/');
      this.router.transitionTo('docs.catch-all', path);
    }
  };

  handleSearchChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    this.searchValue = target.value;
    this.selectedIndex = 0;
  };

  handleItemHighlight = (item: DocNavItem, isComponent: boolean) => {
    this.selectedType = isComponent ? 'component' : 'page';
    const index = this.allItems.indexOf(item);
    if (index !== -1) {
      this.selectedIndex = index;
    }
  };

  filterItems = (items: DocNavItem[]) => {
    if (!this.searchValue.trim()) {
      return items;
    }

    const search = this.searchValue.toLowerCase();
    return items.filter(
      (item) =>
        item.title.toLowerCase().includes(search) ||
        item.route.toLowerCase().includes(search)
    );
  };

  get hasResults() {
    const filteredPages = this.filterItems(this.pageItems);
    const filteredComponents = this.filterItems(this.componentItems);
    return filteredPages.length > 0 || filteredComponents.length > 0;
  }

  get allItems() {
    return [
      ...this.filterItems(this.pageItems),
      ...this.filterItems(this.componentItems),
    ];
  }

  navigateDown = (event: KeyboardEvent) => {
    const allItems = this.allItems;
    if (allItems.length === 0) return;
    event.preventDefault();
    this.selectedIndex = Math.min(this.selectedIndex + 1, allItems.length - 1);
    this.scrollToSelectedItem();
  };

  navigateUp = (event: KeyboardEvent) => {
    const allItems = this.allItems;
    if (allItems.length === 0) return;
    event.preventDefault();
    this.selectedIndex = Math.max(this.selectedIndex - 1, 0);
    this.scrollToSelectedItem();
  };

  selectItem = (event: KeyboardEvent) => {
    const allItems = this.allItems;
    if (allItems.length === 0) return;
    event.preventDefault();
    const selectedItem = allItems[this.selectedIndex];
    if (selectedItem) {
      this.handleSelect(selectedItem.route);
    }
  };

  isItemSelected = (item: DocNavItem) => {
    return this.allItems[this.selectedIndex] === item;
  };

  scrollToSelectedItem = () => {
    // Use setTimeout to ensure DOM has updated with new selection state
    setTimeout(() => {
      const selectedElement = document.querySelector(
        '[data-slot="command-item"][data-selected="true"]'
      );
      if (selectedElement) {
        selectedElement.scrollIntoView({
          block: 'nearest',
          behavior: 'instant',
        });
      }
    }, 0);
  };

  focusOnInsert = modifier((element: HTMLInputElement) => {
    element.focus();
  });

  <template>
    {{! Global keyboard shortcuts }}
    {{onKey "cmd+k" this.toggleOpen}}
    {{onKey "/" this.toggleOpen}}

    <div class={{cn @class}} ...attributes>
      <Button
        @variant="outline"
        @size="sm"
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
        @open={{this.isOpen}}
        @onOpenChange={{this.setOpen}}
        @title="Search documentation..."
        @description="Search for a command to run..."
        @showCloseButton={{false}}
        @class="rounded-xl border-none bg-clip-padding p-2 pb-11 shadow-2xl ring-4 ring-neutral-200/80 dark:bg-neutral-900 dark:ring-neutral-800"
      >
        {{! Dialog-specific keyboard shortcuts - only active when dialog is open }}
        {{#if this.isOpen}}
          {{onKey "ArrowDown" this.navigateDown}}
          {{onKey "ArrowUp" this.navigateUp}}
          {{onKey "Enter" this.selectItem}}
        {{/if}}

        <CommandInput
          @placeholder="Search documentation..."
          @class="bg-input/50 border-input rounded-md border !h-9"
          {{this.focusOnInsert}}
          {{on "input" this.handleSearchChange}}
        />

        <CommandList @class="no-scrollbar min-h-80 scroll-pt-2 scroll-pb-1.5">
          {{#unless this.hasResults}}
            <CommandEmpty
              @class="text-muted-foreground py-12 text-center text-sm"
            >
              No results found.
            </CommandEmpty>
          {{/unless}}

          {{#if (this.filterItems this.pageItems)}}
            <CommandGroup
              @heading="Pages"
              @class="!p-0 [&_[data-cmdk-group-heading]]:scroll-mt-16 [&_[data-cmdk-group-heading]]:!p-3 [&_[data-cmdk-group-heading]]:!pb-1"
            >
              {{#each (this.filterItems this.pageItems) as |item|}}
                <CommandItem
                  @class="data-[selected=true]:border-input data-[selected=true]:bg-input/50 hover:data-[selected=true]:bg-input/70 h-9 rounded-md border border-transparent !px-3 font-medium"
                  data-selected={{if (this.isItemSelected item) "true" "false"}}
                  {{on "click" (fn this.handleSelect item.route)}}
                  {{on
                    "mouseenter"
                    (fn this.handleItemHighlight item false)
                    passive=true
                  }}
                >
                  <ArrowRight />
                  {{item.title}}
                </CommandItem>
              {{/each}}
            </CommandGroup>
          {{/if}}

          {{#if (this.filterItems this.componentItems)}}
            <CommandGroup @heading="Components">
              {{#each (this.filterItems this.componentItems) as |item|}}
                <CommandItem
                  @class="data-[selected=true]:border-input data-[selected=true]:bg-input/50 hover:data-[selected=true]:bg-input/70 h-9 rounded-md border border-transparent !px-3 font-medium"
                  data-selected={{if (this.isItemSelected item) "true" "false"}}
                  {{on "click" (fn this.handleSelect item.route)}}
                  {{on
                    "mouseenter"
                    (fn this.handleItemHighlight item true)
                    passive=true
                  }}
                >
                  <CircleDashed
                    class="border-muted-foreground aspect-square size-4 rounded-full border border-dashed"
                  />
                  {{item.title}}
                </CommandItem>
              {{/each}}
            </CommandGroup>
          {{/if}}
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
            {{#if this.selectedType}}
              Go to Page
            {{/if}}
          </div>
        </div>
      </CommandDialog>
    </div>
  </template>
}
