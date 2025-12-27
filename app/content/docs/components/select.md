---
title: Select
description: Displays a list of options for the user to pick from—triggered by a button.
---

<ComponentPreview name="select-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add select
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-primitives ember-click-outside
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
<Select as |s|>
  <s.Trigger @class="w-[180px]">
    <s.Value @placeholder="Theme" />
  </s.Trigger>
  <s.Content as |c|>
    <c.Item @value="light">Light</c.Item>
    <c.Item @value="dark">Dark</c.Item>
    <c.Item @value="system">System</c.Item>
  </s.Content>
</Select>
```

## Examples

### Scrollable

<ComponentPreview name="select-scrollable" />
