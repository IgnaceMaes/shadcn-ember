import { fn } from '@ember/helper';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { eq } from 'ember-truth-helpers';

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
import { cn } from '@/lib/utils';

import CheckIcon from '~icons/lucide/check';
import ChevronsUpDownIcon from '~icons/lucide/chevrons-up-down';

const frameworks = [
  { value: 'next.js', label: 'Next.js' },
  { value: 'sveltekit', label: 'SvelteKit' },
  { value: 'nuxt.js', label: 'Nuxt.js' },
  { value: 'remix', label: 'Remix' },
  { value: 'astro', label: 'Astro' },
];

export default class ComboboxDemo extends Component {
  @tracked open = false;
  @tracked value = '';

  get selectedLabel() {
    const framework = frameworks.find((f) => f.value === this.value);
    return framework?.label || 'Select framework...';
  }

  handleSelect = (currentValue: string) => {
    this.value = currentValue === this.value ? '' : currentValue;
    this.open = false;
  };

  <template>
    <Popover @onOpenChange={{fn (mut this.open)}} @open={{this.open}}>
      <PopoverTrigger>
        <Button
          @class="w-[200px] justify-between"
          @variant="outline"
          aria-expanded={{this.open}}
          role="combobox"
        >
          {{this.selectedLabel}}
          <ChevronsUpDownIcon class="opacity-50" />
        </Button>
      </PopoverTrigger>
      <PopoverContent @class="w-[200px] p-0">
        <Command>
          <CommandInput @placeholder="Search framework..." />
          <CommandList>
            <CommandEmpty>No framework found.</CommandEmpty>
            <CommandGroup>
              {{#each frameworks as |framework|}}
                <CommandItem
                  @onSelect={{this.handleSelect}}
                  @value={{framework.value}}
                >
                  {{framework.label}}
                  <CheckIcon
                    class={{cn
                      "ml-auto size-4"
                      (if
                        (eq this.value framework.value)
                        "opacity-100"
                        "opacity-0"
                      )
                    }}
                  />
                </CommandItem>
              {{/each}}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  </template>
}
