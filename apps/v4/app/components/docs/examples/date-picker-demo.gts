import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { format } from 'date-fns';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

import ChevronDownIcon from '~icons/lucide/chevron-down';

export default class DatePickerDemo extends Component {
  @tracked date: Date | undefined;

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  get formattedDate() {
    return this.date ? format(this.date, 'PPP') : undefined;
  }

  <template>
    <Popover>
      <PopoverTrigger @asChild={{true}} as |trigger|>
        <Button
          @class="w-[212px] justify-between text-left font-normal {{unless this.date 'text-muted-foreground'}}"
          @variant="outline"
          {{trigger.modifiers}}
        >
          {{#if this.formattedDate}}
            {{this.formattedDate}}
          {{else}}
            <span>Pick a date</span>
          {{/if}}
          <ChevronDownIcon />
        </Button>
      </PopoverTrigger>
      <PopoverContent @align="start" @class="w-auto p-0">
        <Calendar
          @defaultMonth={{this.date}}
          @mode="single"
          @onSelect={{this.handleSelect}}
          @selected={{this.date}}
        />
      </PopoverContent>
    </Popover>
  </template>
}
