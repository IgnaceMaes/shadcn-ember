---
title: Calendar
description: A calendar component that allows users to select a date or a range of dates.
---

<ComponentPreview name="calendar-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add calendar
```

### Manual

**Install the following dependencies:**

```bash
pnpm add date-fns
```

**Add the `Button` component to your project.**

The `Calendar` component uses the `Button` component. Make sure you have it installed in your project.

**Copy and paste the calendar component into your project:**

<ComponentSource name="calendar" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Calendar } from '@/components/ui/calendar';
```

```hbs showLineNumbers
<Calendar
  @mode="single"
  @selected={{this.date}}
  @onSelect={{this.setDate}}
  @class="rounded-lg border"
/>
```

## About

The `Calendar` component is built using [date-fns](https://date-fns.org) for date math and formatting.

## Date Picker

You can use the `<Calendar>` component to build a date picker. See the [Date Picker](/docs/components/date-picker) page for more information.

## Selected Date (With TimeZone)

The Calendar component accepts a `@timeZone` argument to ensure dates are displayed and selected in the user's local timezone.

## Examples

### Basic

A basic calendar component. We used `@class="rounded-lg border"` to style the calendar.

<ComponentPreview name="calendar-basic" />

### Range Calendar

Use `@mode="range"` to enable range selection.

<ComponentPreview name="calendar-range" class="h-[36rem] md:h-96" />

### Month and Year Selector

Use `@captionLayout="dropdown"` to show month and year dropdowns.

<ComponentPreview name="calendar-caption" />

### Presets

<ComponentPreview name="calendar-presets" class="h-[650px]" />

### Date and Time Picker

<ComponentPreview name="calendar-time" class="h-[650px]" />

### Booked dates

<ComponentPreview name="calendar-booked-dates" />

### Custom Cell Size

<ComponentPreview name="calendar-custom-days" class="h-[560px]" />

You can customize the size of calendar cells using the `--cell-size` CSS variable. You can also make it responsive by using breakpoint-specific values:

```hbs showLineNumbers
<Calendar
  @mode="single"
  @selected={{this.date}}
  @onSelect={{this.setDate}}
  @class="rounded-lg border [--cell-size:--spacing(11)] md:[--cell-size:--spacing(12)]"
/>
```

Or use fixed values:

```hbs showLineNumbers
<Calendar
  @mode="single"
  @selected={{this.date}}
  @onSelect={{this.setDate}}
  @class="rounded-lg border [--cell-size:2.75rem] md:[--cell-size:3rem]"
/>
```

### Week Numbers

Use `@showWeekNumber` to show week numbers.

<ComponentPreview name="calendar-week-numbers" />

### Locale

Use `@locale` to localize the calendar. Pass a [date-fns locale](https://date-fns.org/docs/Locale) to translate month names, weekday labels, and set the first day of the week. Use `@weekStartsOn` to override the week start day.

```gts showLineNumbers
import { nl } from 'date-fns/locale';
```

```hbs showLineNumbers
<Calendar
  @mode="single"
  @locale={{this.nlLocale}}
  @selected={{this.date}}
  @onSelect={{this.setDate}}
  @class="rounded-lg border"
/>
```

<ComponentPreview name="calendar-locale" />

## API Reference

| Argument               | Type                                | Default    | Description                          |
| ---------------------- | ----------------------------------- | ---------- | ------------------------------------ |
| `@mode`                | `'single' \| 'range'`               | `'single'` | Selection mode.                      |
| `@selected`            | `Date \| DateRange`                 | —          | The selected date or range.          |
| `@onSelect`            | `(value) => void`                   | —          | Callback when the selection changes. |
| `@defaultMonth`        | `Date`                              | —          | The initial month to display.        |
| `@month`               | `Date`                              | —          | Controlled display month.            |
| `@onMonthChange`       | `(month: Date) => void`             | —          | Callback when display month changes. |
| `@showOutsideDays`     | `boolean`                           | `true`     | Show days from adjacent months.      |
| `@numberOfMonths`      | `number`                            | `1`        | Number of months to display.         |
| `@captionLayout`       | `'label' \| 'dropdown'`             | `'label'`  | Caption display mode.                |
| `@disabled`            | `Date[] \| (date: Date) => boolean` | —          | Dates to disable.                    |
| `@modifiers`           | `Record<string, Date[]>`            | —          | Custom date modifiers.               |
| `@modifiersClassNames` | `Record<string, string>`            | —          | Class names for modifiers.           |
| `@showWeekNumber`      | `boolean`                           | `false`    | Show week numbers.                   |
| `@fixedWeeks`          | `boolean`                           | `false`    | Always show 6 weeks.                 |
| `@buttonVariant`       | `'default' \| 'ghost' \| 'outline'` | `'ghost'`  | Variant for nav buttons.             |
| `@locale`              | `Locale`                            | —          | date-fns locale for i18n.            |
| `@weekStartsOn`        | `0 \| 1 \| 2 \| 3 \| 4 \| 5 \| 6`   | `0`        | First day of the week (0=Sun).       |
| `@startMonth`          | `Date`                              | —          | Earliest month navigable.            |
| `@endMonth`            | `Date`                              | —          | Latest month navigable.              |
| `@class`               | `string`                            | —          | Additional CSS classes.              |
