import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent } from '@/components/ui/card';

import type { DateRange } from '@/components/ui/calendar';

function isWeekend(date: Date): boolean {
  const day = date.getDay();
  return day === 0 || day === 6;
}

export default class CalendarCustomDays extends Component {
  @tracked dateRange: DateRange | undefined = {
    from: new Date(new Date().getFullYear(), 11, 2),
    to: new Date(new Date().getFullYear(), 11, 8),
  };

  handleSelect = (range: Date | DateRange | undefined) => {
    this.dateRange = range as DateRange | undefined;
  };

  <template>
    <Card @class="mx-auto w-fit p-0">
      <CardContent @class="p-0">
        <Calendar
          @captionLayout="dropdown"
          @class="[--cell-size:--spacing(12)] rounded-lg border p-2 [--cell-radius:var(--radius-md)] md:[--cell-size:--spacing(14)]"
          @defaultMonth={{this.dateRange.from}}
          @mode="range"
          @onSelect={{this.handleSelect}}
          @selected={{this.dateRange}}
        >
          <:day as |day|>
            {{day.dayOfMonth}}
            {{#unless day.isOutside}}
              <span>{{if (isWeekend day.date) "$120" "$100"}}</span>
            {{/unless}}
          </:day>
        </Calendar>
      </CardContent>
    </Card>
  </template>
}
