---
title: Date Picker
description: A date picker component with range and presets.
---

<ComponentPreview name="date-picker-demo" />

## Installation

The Date Picker is built using a composition of the `<Popover />` and the `<Calendar />` components.

See installation instructions for the [Popover](/docs/components/popover) and the [Calendar](/docs/components/calendar) components.

## Usage

```gts showLineNumbers
import { format } from 'date-fns';
import { Button } from '@/components/ui/button';
import { Calendar } from '@/components/ui/calendar';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
```

```hbs showLineNumbers
<Popover>
  <PopoverTrigger @asChild={{true}} as |trigger|>
    <Button
      @variant="outline"
      @class="w-[280px] justify-start text-left font-normal"
      {{trigger.modifiers}}
    >
      {{#if this.formattedDate}}
        {{this.formattedDate}}
      {{else}}
        <span>Pick a date</span>
      {{/if}}
    </Button>
  </PopoverTrigger>
  <PopoverContent @class="w-auto p-0">
    <Calendar
      @mode="single"
      @selected={{this.date}}
      @onSelect={{this.handleSelect}}
    />
  </PopoverContent>
</Popover>
```

## Composition

A date picker is built from Popover and Calendar (there is no DatePicker root component):

```
Popover
├── PopoverTrigger
└── PopoverContent
    └── Calendar
```

## Examples

### Basic

A basic date picker component.

<ComponentPreview name="date-picker-simple" />

### Range Picker

A date picker component for selecting a range of dates.

<ComponentPreview name="date-picker-range" />

### Date of Birth

A date picker component for selecting a date of birth. This component includes a dropdown caption layout for date and month selection.

<ComponentPreview name="date-picker-dob" />

### Input

A date picker component with an input field for selecting a date.

<ComponentPreview name="date-picker-input" />

### Time Picker

A date picker component with a time input field for selecting a time.

<ComponentPreview name="date-picker-time" />
