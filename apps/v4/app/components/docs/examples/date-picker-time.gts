import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { format } from 'date-fns';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Field, FieldGroup, FieldLabel } from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

import ChevronDownIcon from '~icons/lucide/chevron-down';

export default class DatePickerTime extends Component {
  @tracked open = false;
  @tracked date: Date | undefined;

  handleOpenChange = (open: boolean) => {
    this.open = open;
  };

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
    this.open = false;
  };

  get formattedDate() {
    return this.date ? format(this.date, 'PPP') : undefined;
  }

  <template>
    <FieldGroup @class="mx-auto max-w-xs flex-row">
      <Field>
        <FieldLabel>Date</FieldLabel>
        <Popover @onOpenChange={{this.handleOpenChange}} @open={{this.open}}>
          <PopoverTrigger @asChild={{true}} as |trigger|>
            <Button
              @class="w-32 justify-between font-normal"
              @variant="outline"
              {{trigger.modifiers}}
            >
              {{#if this.formattedDate}}
                {{this.formattedDate}}
              {{else}}
                Select date
              {{/if}}
              <ChevronDownIcon />
            </Button>
          </PopoverTrigger>
          <PopoverContent
            @align="start"
            @class="w-auto overflow-hidden p-0"
          >
            <Calendar
              @captionLayout="dropdown"
              @defaultMonth={{this.date}}
              @mode="single"
              @onSelect={{this.handleSelect}}
              @selected={{this.date}}
            />
          </PopoverContent>
        </Popover>
      </Field>
      <Field @class="w-32">
        <FieldLabel>Time</FieldLabel>
        <Input
          @class="appearance-none bg-background [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
          step="1"
          type="time"
          value="10:30:00"
        />
      </Field>
    </FieldGroup>
  </template>
}
