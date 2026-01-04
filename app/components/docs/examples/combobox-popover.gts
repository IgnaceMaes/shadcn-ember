import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from '@/components/ui/command';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

interface Status {
  value: string;
  label: string;
}

const statuses: Status[] = [
  { value: 'backlog', label: 'Backlog' },
  { value: 'todo', label: 'Todo' },
  { value: 'in progress', label: 'In Progress' },
  { value: 'done', label: 'Done' },
  { value: 'canceled', label: 'Canceled' },
];

export default class ComboboxPopover extends Component {
  @tracked open = false;
  @tracked selectedStatus: Status | null = null;

  handleSelect = (value: string) => {
    this.selectedStatus =
      statuses.find((status) => status.value === value) || null;
    this.open = false;
  };

  <template>
    <div class="flex items-center space-x-4">
      <p class="text-muted-foreground text-sm">Status</p>
      <Popover @open={{this.open}} @onOpenChange={{fn (mut this.open)}}>
        <PopoverTrigger>
          <Button @variant="outline" @class="w-[150px] justify-start">
            {{#if this.selectedStatus}}
              {{this.selectedStatus.label}}
            {{else}}
              + Set status
            {{/if}}
          </Button>
        </PopoverTrigger>
        <PopoverContent @class="p-0" @side="right" @align="start">
          <Command>
            <CommandInput @placeholder="Change status..." />
            <CommandList>
              <CommandEmpty>No results found.</CommandEmpty>
              <CommandGroup>
                {{#each statuses as |status|}}
                  <CommandItem
                    @value={{status.value}}
                    @onSelect={{this.handleSelect}}
                  >
                    {{status.label}}
                  </CommandItem>
                {{/each}}
              </CommandGroup>
            </CommandList>
          </Command>
        </PopoverContent>
      </Popover>
    </div>
  </template>
}
