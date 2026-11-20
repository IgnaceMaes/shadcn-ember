import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { nl } from 'date-fns/locale';

import { Calendar } from '@/components/ui/calendar';

import type { DateRange } from '@/components/ui/calendar';

export default class CalendarLocale extends Component {
  locale = nl;

  @tracked date: Date | undefined = new Date();

  handleSelect = (date: Date | DateRange | undefined) => {
    this.date = date as Date | undefined;
  };

  <template>
    <Calendar
      @class="rounded-md border shadow-sm"
      @locale={{this.locale}}
      @mode="single"
      @onSelect={{this.handleSelect}}
      @selected={{this.date}}
    />
  </template>
}
