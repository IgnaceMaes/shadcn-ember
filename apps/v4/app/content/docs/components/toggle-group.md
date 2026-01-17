---
title: Toggle Group
description: A set of two-state buttons that can be toggled on or off.
---

<ComponentPreview name="toggle-group-spacing" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add toggle-group
```

### Manual

**Copy and paste the toggle-group component into your project:**

<ComponentSource name="toggle-group" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { ToggleGroup, ToggleGroupItem } from '@/components/ui/toggle-group';
```

```hbs showLineNumbers
<ToggleGroup @type="single">
  <ToggleGroupItem @value="a">A</ToggleGroupItem>
  <ToggleGroupItem @value="b">B</ToggleGroupItem>
  <ToggleGroupItem @value="c">C</ToggleGroupItem>
</ToggleGroup>
```

## Examples

### Outline

<ComponentPreview name="toggle-group-outline" description="A toggle group using the outline variant." />

### Single

<ComponentPreview name="toggle-group-single" description="A toggle group with single selection." />

### Small

<ComponentPreview name="toggle-group-sm" description="A toggle group using the small size." />

### Large

<ComponentPreview name="toggle-group-lg" description="A toggle group using the large size." />

### Disabled

<ComponentPreview name="toggle-group-disabled" description="A disabled toggle group." />

### Spacing

Use `@spacing={{2}}` to add spacing between toggle group items.

<ComponentPreview name="toggle-group-spacing" description="A toggle group with spacing." />

## API Reference

### ToggleGroup

The main component that wraps toggle group items.

| Prop             | Type                                  | Default     |
| ---------------- | ------------------------------------- | ----------- |
| `@type`          | `"single" \| "multiple"`              | `"single"`  |
| `@variant`       | `"default" \| "outline"`              | `"default"` |
| `@size`          | `"default" \| "sm" \| "lg"`           | `"default"` |
| `@spacing`       | `number`                              | `0`         |
| `@class`         | `string`                              |             |
| `@disabled`      | `boolean`                             | `false`     |
| `@value`         | `string \| string[]`                  |             |
| `@onValueChange` | `(value: string \| string[]) => void` |             |

```hbs
<ToggleGroup @type="single" @variant="outline" @size="sm">
  <ToggleGroupItem @value="a">A</ToggleGroupItem>
  <ToggleGroupItem @value="b">B</ToggleGroupItem>
</ToggleGroup>
```

### ToggleGroupItem

Individual toggle items within a toggle group. Remember to add an `aria-label` to each item for accessibility.

| Prop        | Type      | Default  |
| ----------- | --------- | -------- |
| `@value`    | `string`  | Required |
| `@class`    | `string`  |          |
| `@disabled` | `boolean` | `false`  |
