import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { format } from 'date-fns';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Field, FieldLabel } from '@/components/ui/field';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

export default class DatePickerSimple extends Component {
  @tracked date: Date | undefined;

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  get formattedDate() {
    return this.date ? format(this.date, 'PPP') : undefined;
  }

  <template>
    <Field @class="mx-auto w-44">
      <FieldLabel>Date</FieldLabel>
      <Popover>
        <PopoverTrigger @asChild={{true}} as |trigger|>
          <Button
            @class="justify-start font-normal"
            @variant="outline"
            {{trigger.modifiers}}
          >
            {{#if this.formattedDate}}
              {{this.formattedDate}}
            {{else}}
              <span>Pick a date</span>
            {{/if}}
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
    </Field>
  </template>
}
