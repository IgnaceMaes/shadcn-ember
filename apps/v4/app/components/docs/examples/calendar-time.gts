import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent } from '@/components/ui/card';
import { Field, FieldGroup, FieldLabel } from '@/components/ui/field';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
} from '@/components/ui/input-group';

import type { DateRange } from '@/components/ui/calendar';

import Clock2 from '~icons/lucide/clock-2';

export default class CalendarTime extends Component {
  @tracked date: Date | undefined = new Date();
  @tracked startTime = '10:30:00';
  @tracked endTime = '12:30:00';

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  handleStartTimeChange = (event: Event) => {
    this.startTime = (event.target as HTMLInputElement).value;
  };

  handleEndTimeChange = (event: Event) => {
    this.endTime = (event.target as HTMLInputElement).value;
  };

  <template>
    <Card @class="mx-auto w-fit max-w-[300px]">
      <CardContent>
        <Calendar
          @class="p-0 [--cell-size:--spacing(9.5)]"
          @fixedWeeks={{true}}
          @mode="single"
          @onSelect={{this.handleSelect}}
          @selected={{this.date}}
        />
      </CardContent>
      <CardContent @class="border-t pt-6">
        <FieldGroup>
          <Field>
            <FieldLabel>Start Time</FieldLabel>
            <InputGroup>
              <InputGroupInput
                step="1"
                type="time"
                value={{this.startTime}}
                {{on "change" this.handleStartTimeChange}}
              />
              <InputGroupAddon @align="inline-end">
                <Clock2 />
              </InputGroupAddon>
            </InputGroup>
          </Field>
          <Field>
            <FieldLabel>End Time</FieldLabel>
            <InputGroup>
              <InputGroupInput
                step="1"
                type="time"
                value={{this.endTime}}
                {{on "change" this.handleEndTimeChange}}
              />
              <InputGroupAddon @align="inline-end">
                <Clock2 />
              </InputGroupAddon>
            </InputGroup>
          </Field>
        </FieldGroup>
      </CardContent>
    </Card>
  </template>
}
