import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Field, FieldLabel } from '@/components/ui/field';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

export default class DatePickerDob extends Component {
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
    return this.date ? this.date.toLocaleDateString() : undefined;
  }

  <template>
    <Field @class="mx-auto w-44">
      <FieldLabel>Date of birth</FieldLabel>
      <Popover @onOpenChange={{this.handleOpenChange}} @open={{this.open}}>
        <PopoverTrigger @asChild={{true}} as |trigger|>
          <Button
            @class="justify-start font-normal"
            @variant="outline"
            {{trigger.modifiers}}
          >
            {{#if this.formattedDate}}
              {{this.formattedDate}}
            {{else}}
              Select date
            {{/if}}
          </Button>
        </PopoverTrigger>
        <PopoverContent @align="start" @class="w-auto overflow-hidden p-0">
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
  </template>
}
