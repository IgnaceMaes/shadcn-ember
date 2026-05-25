import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent } from '@/components/ui/card';

import type { DateRange } from '@/components/ui/calendar';

export default class CalendarBookedDates extends Component {
  @tracked date: Date | undefined = new Date(
    new Date().getFullYear(),
    1,
    3,
  );

  bookedDates = Array.from(
    { length: 15 },
    (_, i) => new Date(new Date().getFullYear(), 1, 12 + i),
  );

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  <template>
    <Card @class="mx-auto w-fit p-0">
      <CardContent @class="p-0">
        <Calendar
          @defaultMonth={{this.date}}
          @disabled={{this.bookedDates}}
          @mode="single"
          @modifiers={{this.modifiers}}
          @modifiersClassNames={{this.modifiersClassNames}}
          @onSelect={{this.handleSelect}}
          @selected={{this.date}}
        />
      </CardContent>
    </Card>
  </template>

  get modifiers() {
    return { booked: this.bookedDates };
  }

  get modifiersClassNames() {
    return { booked: '[&>button]:line-through opacity-100' };
  }
}
