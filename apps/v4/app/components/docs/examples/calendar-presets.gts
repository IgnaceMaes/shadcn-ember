import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { addDays } from 'date-fns';

import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import { Card, CardContent, CardFooter } from '@/components/ui/card';

import type { DateRange } from '@/components/ui/calendar';

const PRESETS = [
  { label: 'Today', value: 0 },
  { label: 'Tomorrow', value: 1 },
  { label: 'In 3 days', value: 3 },
  { label: 'In a week', value: 7 },
  { label: 'In 2 weeks', value: 14 },
];

export default class CalendarPresets extends Component {
  @tracked date: Date | undefined = new Date(
    new Date().getFullYear(),
    1,
    12,
  );
  @tracked currentMonth: Date = new Date(
    new Date().getFullYear(),
    new Date().getMonth(),
    1,
  );

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  handleMonthChange = (month: Date) => {
    this.currentMonth = month;
  };

  handlePreset = (value: number) => {
    const newDate = addDays(new Date(), value);
    this.date = newDate;
    this.currentMonth = new Date(
      newDate.getFullYear(),
      newDate.getMonth(),
      1,
    );
  };

  <template>
    <Card @class="mx-auto w-fit max-w-[300px]">
      <CardContent>
        <Calendar
          @class="p-0 [--cell-size:--spacing(9.5)]"
          @fixedWeeks={{true}}
          @mode="single"
          @month={{this.currentMonth}}
          @onMonthChange={{this.handleMonthChange}}
          @onSelect={{this.handleSelect}}
          @selected={{this.date}}
        />
      </CardContent>
      <CardFooter @class="flex flex-wrap gap-2 border-t">
        {{#each PRESETS as |preset|}}
          <Button
            @class="flex-1"
            @size="sm"
            @variant="outline"
            {{on "click" (fn this.handlePreset preset.value)}}
          >
            {{preset.label}}
          </Button>
        {{/each}}
      </CardFooter>
    </Card>
  </template>
}
