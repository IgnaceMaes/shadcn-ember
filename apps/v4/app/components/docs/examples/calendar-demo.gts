import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';

import type { DateRange } from '@/components/ui/calendar';

export default class CalendarDemo extends Component {
  @tracked date: Date | undefined = new Date();

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  <template>
    <Calendar
      @captionLayout="dropdown"
      @class="rounded-md border shadow-sm"
      @mode="single"
      @onSelect={{this.handleSelect}}
      @selected={{this.date}}
    />
  </template>
}
