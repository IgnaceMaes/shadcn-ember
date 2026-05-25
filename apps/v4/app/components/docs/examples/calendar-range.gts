import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { addDays } from 'date-fns';

import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent } from '@/components/ui/card';

import type { DateRange } from '@/components/ui/calendar';

export default class CalendarRange extends Component {
  @tracked dateRange: DateRange | undefined = {
    from: new Date(new Date().getFullYear(), 0, 12),
    to: addDays(new Date(new Date().getFullYear(), 0, 12), 30),
  };

  handleSelect = (range: Date | DateRange | undefined) => {
    this.dateRange = range as DateRange | undefined;
  };

  <template>
    <Card @class="mx-auto w-fit p-0">
      <CardContent @class="p-0">
        <Calendar
          @defaultMonth={{this.dateRange.from}}
          @mode="range"
          @numberOfMonths={{2}}
          @onSelect={{this.handleSelect}}
          @selected={{this.dateRange}}
        />
      </CardContent>
    </Card>
  </template>
}
