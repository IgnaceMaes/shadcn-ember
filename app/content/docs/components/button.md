---
title: Button
description: Displays a button or a component that looks like a button.
featured: true
---

<ComponentPreview name="button-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add button
```

### Manual

**Copy and paste the button component into your project:**

<ComponentSource name="button" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Button } from '@/components/ui/button';
```

```hbs showLineNumbers
<Button @variant="outline">Button</Button>
<Button @variant="outline" @size="icon" aria-label="Submit">
  <ArrowUpIcon />
</Button>
```

## Cursor

Tailwind v4 switched from `cursor: pointer` to `cursor: default` for the button component.

If you want to keep the `cursor: pointer` behavior, add the following code to your CSS file:

```css showLineNumbers title="app.css"
@layer base {
  button:not(:disabled),
  [role="button"]:not(:disabled) {
    cursor: pointer;
  }
}
```

## Examples

### Size

<ComponentPreview name="button-size" />

### Default

<ComponentPreview name="button-default" />

### Outline

<ComponentPreview name="button-outline" />

### Secondary

<ComponentPreview name="button-secondary" />

### Ghost

<ComponentPreview name="button-ghost" />

### Destructive

<ComponentPreview name="button-destructive" />

### Link

<ComponentPreview name="button-link" />

### Icon

<ComponentPreview name="button-icon" />

### With Icon

The spacing between the icon and the text is automatically adjusted based on the size of the button. You do not need any margin on the icon.

<ComponentPreview name="button-with-icon" />

### Rounded

Use the `rounded-full` class to make the button rounded.

<ComponentPreview name="button-rounded" />

### Spinner

<ComponentPreview name="button-loading" />

### Button Group

To create a button group, use the `ButtonGroup` component. See the [Button Group](/docs/components/button-group) documentation for more details.

<ComponentPreview name="button-group-demo" />

### Link Component

You can use the `@asChild` argument to make another component look like a button. Here's an example of a link that looks like a button:

<ComponentPreview name="button-as-link" />

## API Reference

### Button

The `Button` component is a wrapper around the `button` element that adds a variety of styles and functionality.

| Prop        | Type                                                                          | Default     |
| ----------- | ----------------------------------------------------------------------------- | ----------- |
| `@variant`  | `"default" \| "outline" \| "ghost" \| "destructive" \| "secondary" \| "link"` | `"default"` |
| `@size`     | `"default" \| "sm" \| "lg" \| "icon" \| "icon-sm" \| "icon-lg"`               | `"default"` |
| `@asChild`  | `boolean`                                                                     | `false`     |
| `@disabled` | `boolean`                                                                     | `false`     |
| `@type`     | `"button" \| "submit" \| "reset"`                                             | `"button"`  |
| `@class`    | `string`                                                                      | `undefined` |
