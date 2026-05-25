import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent } from '@/components/ui/card';

import type { DateRange } from '@/components/ui/calendar';

export default class CalendarWeekNumbers extends Component {
  @tracked date: Date | undefined = new Date(
    new Date().getFullYear(),
    1,
    12,
  );

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  <template>
    <Card @class="mx-auto w-fit p-0">
      <CardContent @class="p-0">
        <Calendar
          @defaultMonth={{this.date}}
          @mode="single"
          @onSelect={{this.handleSelect}}
          @selected={{this.date}}
          @showWeekNumber={{true}}
        />
      </CardContent>
    </Card>
  </template>
}
