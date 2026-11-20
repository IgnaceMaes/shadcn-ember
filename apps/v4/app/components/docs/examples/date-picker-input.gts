import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Calendar } from '@/components/ui/calendar';
import { Field, FieldLabel } from '@/components/ui/field';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from '@/components/ui/input-group';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import type { DateRange } from '@/components/ui/calendar';

import CalendarIcon from '~icons/lucide/calendar';

function formatDate(date: Date | undefined) {
  if (!date) return '';
  return date.toLocaleDateString('en-US', {
    day: '2-digit',
    month: 'long',
    year: 'numeric',
  });
}

function isValidDate(date: Date | undefined) {
  if (!date) return false;
  return !isNaN(date.getTime());
}

export default class DatePickerInput extends Component {
  @tracked open = false;
  @tracked date: Date | undefined = new Date('2025-06-01');
  @tracked month: Date | undefined = this.date;
  @tracked value = formatDate(this.date);

  handleOpenChange = (open: boolean) => {
    this.open = open;
  };

  handleInputChange = (event: Event) => {
    const inputValue = (event.target as HTMLInputElement).value;
    this.value = inputValue;
    const date = new Date(inputValue);
    if (isValidDate(date)) {
      this.date = date;
      this.month = date;
    }
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'ArrowDown') {
      event.preventDefault();
      this.open = true;
    }
  };

  handleSelect = (date: Date | DateRange | undefined) => {
    const selected = date as Date | undefined;
    this.date = selected;
    this.value = formatDate(selected);
    this.open = false;
  };

  handleMonthChange = (month: Date) => {
    this.month = month;
  };

  <template>
    <Field @class="mx-auto w-48">
      <FieldLabel>Subscription Date</FieldLabel>
      <InputGroup>
        <InputGroupInput
          placeholder="June 01, 2025"
          value={{this.value}}
          {{on "input" this.handleInputChange}}
          {{on "keydown" this.handleKeyDown}}
        />
        <InputGroupAddon @align="inline-end">
          <Popover @onOpenChange={{this.handleOpenChange}} @open={{this.open}}>
            <PopoverTrigger @asChild={{true}} as |trigger|>
              <InputGroupButton
                @size="icon-xs"
                @variant="ghost"
                aria-label="Select date"
                {{trigger.modifiers}}
              >
                <CalendarIcon />
                <span class="sr-only">Select date</span>
              </InputGroupButton>
            </PopoverTrigger>
            <PopoverContent
              @align="end"
              @class="w-auto overflow-hidden p-0"
              @sideOffset={{10}}
            >
              <Calendar
                @mode="single"
                @month={{this.month}}
                @onMonthChange={{this.handleMonthChange}}
                @onSelect={{this.handleSelect}}
                @selected={{this.date}}
              />
            </PopoverContent>
          </Popover>
        </InputGroupAddon>
      </InputGroup>
    </Field>
  </template>
}
