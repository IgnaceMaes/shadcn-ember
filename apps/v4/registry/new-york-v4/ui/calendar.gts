import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import {
  addDays,
  addMonths,
  eachDayOfInterval,
  endOfMonth,
  endOfWeek,
  format,
  getWeek,
  isSameDay,
  isSameMonth,
  isToday,
  startOfMonth,
  startOfWeek,
  subMonths,
} from 'date-fns';

import { buttonVariants } from '@/components/ui/button';
import { cn } from '@/lib/utils';

import type Owner from '@ember/owner';

import ChevronDown from '~icons/lucide/chevron-down';
import ChevronLeft from '~icons/lucide/chevron-left';
import ChevronRight from '~icons/lucide/chevron-right';

interface DateRange {
  from?: Date;
  to?: Date;
}

interface CalendarSignature {
  Element: HTMLDivElement;
  Args: {
    mode?: 'single' | 'range';
    selected?: Date | DateRange;
    onSelect?: (value: Date | DateRange | undefined) => void;
    defaultMonth?: Date;
    month?: Date;
    onMonthChange?: (month: Date) => void;
    showOutsideDays?: boolean;
    numberOfMonths?: number;
    captionLayout?: 'label' | 'dropdown';
    disabled?: Date[] | ((date: Date) => boolean);
    modifiers?: Record<string, Date[]>;
    modifiersClassNames?: Record<string, string>;
    showWeekNumber?: boolean;
    fixedWeeks?: boolean;
    class?: string;
    buttonVariant?: 'default' | 'ghost' | 'outline';
    timeZone?: string;
    startMonth?: Date;
    endMonth?: Date;
  };
  Blocks: {
    default: [];
    day: [DayInfo];
  };
}

interface DayInfo {
  date: Date;
  isOutside: boolean;
  isToday: boolean;
  isSelected: boolean;
  isRangeStart: boolean;
  isRangeEnd: boolean;
  isRangeMiddle: boolean;
  isDisabled: boolean;
  isFocused: boolean;
  modifierClasses: string;
  dayOfMonth: number;
}

interface WeekInfo {
  weekNumber: number;
  days: DayInfo[];
}

interface MonthData {
  month: number;
  year: number;
  label: string;
  labelShort: string;
  weeks: WeekInfo[];
}

const WEEKDAY_LABELS = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
const MONTH_NAMES_SHORT = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

function eq(a: unknown, b: unknown): boolean {
  return a === b;
}

function notFn(value: unknown): boolean {
  return !value;
}

function and(a: unknown, b: unknown): boolean {
  return Boolean(a) && Boolean(b);
}

function selectedSingle(day: DayInfo): boolean {
  return (
    day.isSelected &&
    !day.isRangeStart &&
    !day.isRangeEnd &&
    !day.isRangeMiddle
  );
}

function monthNameShort(index: number): string {
  return MONTH_NAMES_SHORT[index] ?? '';
}

class Calendar extends Component<CalendarSignature> {
  @tracked _displayMonth: Date;
  @tracked focusedDate: Date | null = null;

  constructor(owner: Owner, args: CalendarSignature['Args']) {
    super(owner, args);
    const initial =
      args.month ?? args.defaultMonth ?? this.selectedStartDate ?? new Date();
    this._displayMonth = startOfMonth(initial);
  }

  get showOutsideDays(): boolean {
    return this.args.showOutsideDays ?? true;
  }

  get numberOfMonths(): number {
    return this.args.numberOfMonths ?? 1;
  }

  get captionLayout(): 'label' | 'dropdown' {
    return this.args.captionLayout ?? 'label';
  }

  get btnVariant(): 'default' | 'ghost' | 'outline' {
    return this.args.buttonVariant ?? 'ghost';
  }

  get displayMonth(): Date {
    if (this.args.month) {
      return startOfMonth(this.args.month);
    }
    return this._displayMonth;
  }

  get selectedStartDate(): Date | undefined {
    if (!this.args.selected) return undefined;
    if (this.args.mode === 'range') {
      return (this.args.selected as DateRange).from;
    }
    return this.args.selected as Date;
  }

  get startYear(): number {
    return (
      this.args.startMonth?.getFullYear() ??
      this.displayMonth.getFullYear() - 100
    );
  }

  get endYear(): number {
    return (
      this.args.endMonth?.getFullYear() ??
      this.displayMonth.getFullYear() + 10
    );
  }

  get yearOptions(): number[] {
    const years: number[] = [];
    for (let y = this.startYear; y <= this.endYear; y++) {
      years.push(y);
    }
    return years;
  }

  get monthOptions(): { value: number; label: string }[] {
    return MONTH_NAMES_SHORT.map((label, i) => ({ value: i, label }));
  }

  get months(): MonthData[] {
    const result: MonthData[] = [];
    for (let i = 0; i < this.numberOfMonths; i++) {
      const m = addMonths(this.displayMonth, i);
      result.push(this.buildMonthData(m));
    }
    return result;
  }

  get canGoBack(): boolean {
    if (!this.args.startMonth) return true;
    const prev = subMonths(this.displayMonth, 1);
    return prev >= startOfMonth(this.args.startMonth);
  }

  get canGoForward(): boolean {
    if (!this.args.endMonth) return true;
    const next = addMonths(this.displayMonth, this.numberOfMonths);
    return next <= startOfMonth(this.args.endMonth);
  }

  buildMonthData(monthDate: Date): MonthData {
    const monthStart = startOfMonth(monthDate);
    const monthEnd = endOfMonth(monthDate);
    const calendarStart = startOfWeek(monthStart);
    const calendarEnd = endOfWeek(monthEnd);

    const allDays = eachDayOfInterval({ start: calendarStart, end: calendarEnd });

    if (this.args.fixedWeeks) {
      const targetDays = 42;
      while (allDays.length < targetDays) {
        allDays.push(addDays(allDays[allDays.length - 1]!, 1));
      }
    }

    const weeks: WeekInfo[] = [];

    for (let i = 0; i < allDays.length; i += 7) {
      const weekDays = allDays.slice(i, i + 7);
      const days: DayInfo[] = weekDays.map((date) => {
        const outside = !isSameMonth(date, monthDate);
        const selected = this.isDateSelected(date);
        const rangeStart = this.isRangeStart(date);
        const rangeEnd = this.isRangeEnd(date);
        const rangeMiddle = this.isRangeMiddle(date);
        const disabled = this.isDateDisabled(date);
        const focused =
          this.focusedDate !== null && isSameDay(date, this.focusedDate);

        return {
          date,
          isOutside: outside,
          isToday: isToday(date),
          isSelected: selected,
          isRangeStart: rangeStart,
          isRangeEnd: rangeEnd,
          isRangeMiddle: rangeMiddle,
          isDisabled: disabled,
          isFocused: focused,
          modifierClasses: this.getModifierClasses(date),
          dayOfMonth: date.getDate(),
        };
      });

      weeks.push({
        weekNumber: getWeek(weekDays[0]!),
        days,
      });
    }

    return {
      month: monthDate.getMonth(),
      year: monthDate.getFullYear(),
      label: format(monthDate, 'MMMM yyyy'),
      labelShort: format(monthDate, 'MMM'),
      weeks,
    };
  }

  isDateSelected(date: Date): boolean {
    if (!this.args.selected) return false;

    if (this.args.mode === 'range') {
      const range = this.args.selected as DateRange;
      if (range.from && isSameDay(date, range.from)) return true;
      if (range.to && isSameDay(date, range.to)) return true;
      return false;
    }

    return isSameDay(date, this.args.selected as Date);
  }

  isRangeStart(date: Date): boolean {
    if (this.args.mode !== 'range' || !this.args.selected) return false;
    const range = this.args.selected as DateRange;
    return !!range.from && isSameDay(date, range.from);
  }

  isRangeEnd(date: Date): boolean {
    if (this.args.mode !== 'range' || !this.args.selected) return false;
    const range = this.args.selected as DateRange;
    return !!range.to && isSameDay(date, range.to);
  }

  isRangeMiddle(date: Date): boolean {
    if (this.args.mode !== 'range' || !this.args.selected) return false;
    const range = this.args.selected as DateRange;
    if (!range.from || !range.to) return false;
    return date > range.from && date < range.to;
  }

  isDateDisabled(date: Date): boolean {
    if (!this.args.disabled) return false;
    if (typeof this.args.disabled === 'function') {
      return this.args.disabled(date);
    }
    return this.args.disabled.some((d) => isSameDay(d, date));
  }

  getModifierClasses(date: Date): string {
    if (!this.args.modifiers || !this.args.modifiersClassNames) return '';
    const classes: string[] = [];
    for (const [key, dates] of Object.entries(this.args.modifiers)) {
      if (dates.some((d) => isSameDay(d, date))) {
        const cls = this.args.modifiersClassNames[key];
        if (cls) classes.push(cls);
      }
    }
    return classes.join(' ');
  }

  setDisplayMonth = (date: Date) => {
    this._displayMonth = startOfMonth(date);
    this.args.onMonthChange?.(this._displayMonth);
  };

  goToPreviousMonth = () => {
    if (!this.canGoBack) return;
    this.setDisplayMonth(subMonths(this.displayMonth, 1));
  };

  goToNextMonth = () => {
    if (!this.canGoForward) return;
    this.setDisplayMonth(addMonths(this.displayMonth, 1));
  };

  handleMonthSelect = (event: Event) => {
    const target = event.target as HTMLSelectElement;
    const month = parseInt(target.value, 10);
    this.setDisplayMonth(
      new Date(this.displayMonth.getFullYear(), month, 1),
    );
  };

  handleYearSelect = (event: Event) => {
    const target = event.target as HTMLSelectElement;
    const year = parseInt(target.value, 10);
    this.setDisplayMonth(
      new Date(year, this.displayMonth.getMonth(), 1),
    );
  };

  selectDate = (day: DayInfo) => {
    if (day.isDisabled || (day.isOutside && !this.showOutsideDays)) return;

    if (this.args.mode === 'range') {
      const range = (this.args.selected as DateRange | undefined) ?? {};
      if (!range.from || (range.from && range.to)) {
        this.args.onSelect?.({ from: day.date, to: undefined });
      } else {
        if (day.date < range.from) {
          this.args.onSelect?.({ from: day.date, to: range.from });
        } else {
          this.args.onSelect?.({ from: range.from, to: day.date });
        }
      }
    } else {
      if (
        this.args.selected &&
        isSameDay(day.date, this.args.selected as Date)
      ) {
        this.args.onSelect?.(undefined);
      } else {
        this.args.onSelect?.(day.date);
      }
    }
  };

  handleKeydown = (day: DayInfo, event: KeyboardEvent) => {
    let newDate: Date | null = null;

    switch (event.key) {
      case 'ArrowLeft':
        newDate = addDays(day.date, -1);
        break;
      case 'ArrowRight':
        newDate = addDays(day.date, 1);
        break;
      case 'ArrowUp':
        newDate = addDays(day.date, -7);
        break;
      case 'ArrowDown':
        newDate = addDays(day.date, 7);
        break;
      case 'Enter':
      case ' ':
        event.preventDefault();
        this.selectDate(day);
        return;
      default:
        return;
    }

    event.preventDefault();

    if (newDate) {
      this.focusedDate = newDate;

      if (!isSameMonth(newDate, this.displayMonth)) {
        this.setDisplayMonth(startOfMonth(newDate));
      }
    }
  };

  <template>
    <div
      class={{cn
        "bg-background p-3 [--cell-radius:var(--radius-md)] [--cell-size:--spacing(8)] in-data-[slot=card-content]:bg-transparent in-data-[slot=popover-content]:bg-transparent"
        @class
      }}
      data-slot="calendar"
      ...attributes
    >
      <div class="relative flex flex-col gap-4 md:flex-row">
        {{#each this.months as |monthData monthIdx|}}
          <div class="flex w-full flex-col gap-4">
            {{#if (eq monthIdx 0)}}
              <div
                class="absolute inset-x-0 top-0 flex w-full items-center justify-between gap-1"
              >
                <button
                  aria-disabled={{if (notFn this.canGoBack) "true"}}
                  aria-label="Go to previous month"
                  class={{cn
                    (buttonVariants this.btnVariant "icon")
                    "size-(--cell-size) p-0 select-none aria-disabled:opacity-50"
                  }}
                  type="button"
                  {{on "click" this.goToPreviousMonth}}
                >
                  <ChevronLeft class="size-4" />
                </button>
                <button
                  aria-disabled={{if (notFn this.canGoForward) "true"}}
                  aria-label="Go to next month"
                  class={{cn
                    (buttonVariants this.btnVariant "icon")
                    "size-(--cell-size) p-0 select-none aria-disabled:opacity-50"
                  }}
                  type="button"
                  {{on "click" this.goToNextMonth}}
                >
                  <ChevronRight class="size-4" />
                </button>
              </div>
            {{/if}}

            <div
              class="flex h-(--cell-size) w-full items-center justify-center px-(--cell-size)"
            >
              {{#if (eq this.captionLayout "dropdown")}}
                <div
                  class="flex h-(--cell-size) w-full items-center justify-center gap-1.5 text-sm font-medium"
                >
                  <div class="relative rounded-(--cell-radius)">
                    <span
                      class="flex items-center gap-1 rounded-(--cell-radius) text-sm"
                    >
                      {{monthNameShort monthData.month}}
                      <ChevronDown
                        class="size-3.5 text-muted-foreground"
                      />
                    </span>
                    <select
                      aria-label="Select month"
                      class="absolute inset-0 cursor-pointer opacity-0"
                      {{on "change" this.handleMonthSelect}}
                    >
                      {{#each this.monthOptions as |opt|}}
                        <option
                          selected={{eq opt.value monthData.month}}
                          value={{opt.value}}
                        >
                          {{opt.label}}
                        </option>
                      {{/each}}
                    </select>
                  </div>
                  <div class="relative rounded-(--cell-radius)">
                    <span
                      class="flex items-center gap-1 rounded-(--cell-radius) text-sm"
                    >
                      {{monthData.year}}
                      <ChevronDown
                        class="size-3.5 text-muted-foreground"
                      />
                    </span>
                    <select
                      aria-label="Select year"
                      class="absolute inset-0 cursor-pointer opacity-0"
                      {{on "change" this.handleYearSelect}}
                    >
                      {{#each this.yearOptions as |year|}}
                        <option
                          selected={{eq year monthData.year}}
                          value={{year}}
                        >
                          {{year}}
                        </option>
                      {{/each}}
                    </select>
                  </div>
                </div>
              {{else}}
                <span class="text-sm font-medium select-none">
                  {{monthData.label}}
                </span>
              {{/if}}
            </div>

            <table class="w-full border-collapse">
              <thead>
                <tr class="flex">
                  {{#if @showWeekNumber}}
                    <th class="w-(--cell-size) select-none" scope="col">
                      <span class="sr-only">Week number</span>
                    </th>
                  {{/if}}
                  {{#each WEEKDAY_LABELS as |label|}}
                    <th
                      class="flex-1 rounded-(--cell-radius) text-[0.8rem] font-normal text-muted-foreground select-none"
                      scope="col"
                    >
                      {{label}}
                    </th>
                  {{/each}}
                </tr>
              </thead>
              <tbody>
                {{#each monthData.weeks as |week|}}
                  <tr class="mt-2 flex w-full">
                    {{#if @showWeekNumber}}
                      <td class="flex-none">
                        <div
                          class="flex size-(--cell-size) items-center justify-center text-center text-[0.8rem] text-muted-foreground select-none"
                        >
                          {{week.weekNumber}}
                        </div>
                      </td>
                    {{/if}}
                    {{#each week.days as |day|}}
                      <td
                        class={{cn
                          "flex-1"
                          (if
                            (notFn
                              (and day.isOutside (notFn this.showOutsideDays))
                            )
                            (cn
                              "group/day relative aspect-square h-full w-full rounded-(--cell-radius) p-0 text-center select-none [&:last-child[data-selected=true]_button]:rounded-r-(--cell-radius)"
                              (if
                                @showWeekNumber
                                "[&:nth-child(2)[data-selected=true]_button]:rounded-l-(--cell-radius)"
                                "[&:first-child[data-selected=true]_button]:rounded-l-(--cell-radius)"
                              )
                              (if
                                day.isRangeStart
                                "relative isolate z-0 rounded-l-(--cell-radius) bg-muted after:absolute after:inset-y-0 after:right-0 after:w-4 after:bg-muted"
                              )
                              (if day.isRangeMiddle "rounded-none")
                              (if
                                day.isRangeEnd
                                "relative isolate z-0 rounded-r-(--cell-radius) bg-muted after:absolute after:inset-y-0 after:left-0 after:w-4 after:bg-muted"
                              )
                              (if
                                day.isToday
                                "rounded-(--cell-radius) bg-muted text-foreground data-[selected=true]:rounded-none"
                              )
                              (if
                                day.isOutside
                                "text-muted-foreground aria-selected:text-muted-foreground"
                              )
                              (if
                                day.isDisabled
                                "text-muted-foreground opacity-50"
                              )
                              day.modifierClasses
                            )
                            "invisible"
                          )
                        }}
                        data-day={{day.date.toLocaleDateString}}
                        data-focused={{if day.isFocused "true"}}
                        data-outside={{if day.isOutside "true"}}
                        data-range-end={{if day.isRangeEnd "true"}}
                        data-range-middle={{if day.isRangeMiddle "true"}}
                        data-range-start={{if day.isRangeStart "true"}}
                        data-selected={{if day.isSelected "true"}}
                        data-today={{if day.isToday "true"}}
                      >
                        {{#if
                          (notFn
                            (and day.isOutside (notFn this.showOutsideDays))
                          )
                        }}
                          {{#if (has-block "day")}}
                            <CalendarDayButton
                              @day={{day}}
                              @isSelectedSingle={{selectedSingle day}}
                              @onKeydown={{fn this.handleKeydown day}}
                              @onSelect={{fn this.selectDate day}}
                            >
                              {{yield day to="day"}}
                            </CalendarDayButton>
                          {{else}}
                            <CalendarDayButton
                              @day={{day}}
                              @isSelectedSingle={{selectedSingle day}}
                              @onKeydown={{fn this.handleKeydown day}}
                              @onSelect={{fn this.selectDate day}}
                            />
                          {{/if}}
                        {{/if}}
                      </td>
                    {{/each}}
                  </tr>
                {{/each}}
              </tbody>
            </table>
          </div>
        {{/each}}
      </div>
    </div>
  </template>
}

interface CalendarDayButtonSignature {
  Element: HTMLButtonElement;
  Args: {
    day: DayInfo;
    isSelectedSingle: boolean;
    onSelect: () => void;
    onKeydown: (event: KeyboardEvent) => void;
  };
  Blocks: {
    default: [];
  };
}

class CalendarDayButton extends Component<CalendarDayButtonSignature> {
  get classes(): string {
    return cn(
      buttonVariants('ghost', 'icon'),
      'relative isolate z-10 flex aspect-square size-auto w-full min-w-(--cell-size) flex-col gap-1 border-0 leading-none font-normal',
      'group-data-[focused=true]/day:relative group-data-[focused=true]/day:z-10 group-data-[focused=true]/day:border-ring group-data-[focused=true]/day:ring-[3px] group-data-[focused=true]/day:ring-ring/50',
      'data-[range-end=true]:rounded-(--cell-radius) data-[range-end=true]:rounded-r-(--cell-radius) data-[range-end=true]:bg-primary data-[range-end=true]:text-primary-foreground',
      'data-[range-middle=true]:rounded-none data-[range-middle=true]:bg-muted data-[range-middle=true]:text-foreground',
      'data-[range-start=true]:rounded-(--cell-radius) data-[range-start=true]:rounded-l-(--cell-radius) data-[range-start=true]:bg-primary data-[range-start=true]:text-primary-foreground',
      'data-[selected-single=true]:bg-primary data-[selected-single=true]:text-primary-foreground',
      'dark:hover:text-foreground [&>span]:text-xs [&>span]:opacity-70',
    );
  }

  <template>
    <button
      class={{this.classes}}
      data-day={{@day.date.toLocaleDateString}}
      data-range-end={{if @day.isRangeEnd "true"}}
      data-range-middle={{if @day.isRangeMiddle "true"}}
      data-range-start={{if @day.isRangeStart "true"}}
      data-selected-single={{if @isSelectedSingle "true"}}
      disabled={{@day.isDisabled}}
      tabindex={{if @day.isFocused "0" "-1"}}
      type="button"
      {{on "click" @onSelect}}
      {{on "keydown" @onKeydown}}
    >
      {{#if (has-block)}}
        {{yield}}
      {{else}}
        {{@day.dayOfMonth}}
      {{/if}}
    </button>
  </template>
}

export { Calendar, CalendarDayButton };
export type { DateRange };
