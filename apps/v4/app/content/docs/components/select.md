---
title: Select
description: Displays a list of options for the user to pick from—triggered by a button.
---

<ComponentPreview name="select-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add select
```

### Manual

**Install the following dependencies:**

```bash
pnpm add @floating-ui/dom ember-click-outside ember-provide-consume-context
```

**Copy and paste the select component into your project:**

<ComponentSource name="select" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
```

```hbs showLineNumbers
<Select>
  <SelectTrigger @class="w-[180px]">
    <SelectValue @placeholder="Theme" />
  </SelectTrigger>
  <SelectContent>
    <SelectItem @value="light">Light</SelectItem>
    <SelectItem @value="dark">Dark</SelectItem>
    <SelectItem @value="system">System</SelectItem>
  </SelectContent>
</Select>
```

## Examples

### Scrollable

<ComponentPreview name="select-scrollable" />
