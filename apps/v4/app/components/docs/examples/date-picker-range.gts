import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { addDays, format } from 'date-fns';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Field, FieldLabel } from '@/components/ui/field';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

import CalendarIcon from '~icons/lucide/calendar';

export default class DatePickerWithRange extends Component {
  @tracked date: DateRange | undefined = {
    from: new Date(new Date().getFullYear(), 0, 20),
    to: addDays(new Date(new Date().getFullYear(), 0, 20), 20),
  };

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as DateRange | undefined;
  };

  get formattedRange() {
    if (!this.date?.from) return undefined;
    if (this.date.to) {
      return `${format(this.date.from, 'LLL dd, y')} - ${format(this.date.to, 'LLL dd, y')}`;
    }
    return format(this.date.from, 'LLL dd, y');
  }

  <template>
    <Field @class="mx-auto w-60">
      <FieldLabel>Date Picker Range</FieldLabel>
      <Popover>
        <PopoverTrigger @asChild={{true}} as |trigger|>
          <Button
            @class="justify-start px-2.5 font-normal"
            @variant="outline"
            {{trigger.modifiers}}
          >
            <CalendarIcon />
            {{#if this.formattedRange}}
              {{this.formattedRange}}
            {{else}}
              <span>Pick a date</span>
            {{/if}}
          </Button>
        </PopoverTrigger>
        <PopoverContent @align="start" @class="w-auto p-0">
          <Calendar
            @defaultMonth={{this.date.from}}
            @mode="range"
            @numberOfMonths={{2}}
            @onSelect={{this.handleSelect}}
            @selected={{this.date}}
          />
        </PopoverContent>
      </Popover>
    </Field>
  </template>
}
