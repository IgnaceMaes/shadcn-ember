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
import Button from '@/components/ui/button';
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

```hbs showLineNumbers
// Small
<Button @size="sm" @variant="outline">Small</Button>
<Button @size="icon-sm" aria-label="Submit" @variant="outline">
  <ArrowUpRightIcon />
</Button>

// Medium
<Button @variant="outline">Default</Button>
<Button @size="icon" aria-label="Submit" @variant="outline">
  <ArrowUpRightIcon />
</Button>

// Large
<Button @size="lg" @variant="outline">Large</Button>
<Button @size="icon-lg" aria-label="Submit" @variant="outline">
  <ArrowUpRightIcon />
</Button>
```

### Default

<ComponentPreview name="button-default" />

```hbs showLineNumbers
<Button>Button</Button>
```

### Outline

<ComponentPreview name="button-outline" />

```hbs showLineNumbers
<Button @variant="outline">Outline</Button>
```

### Secondary

<ComponentPreview name="button-secondary" />

```hbs showLineNumbers
<Button @variant="secondary">Secondary</Button>
```

### Ghost

<ComponentPreview name="button-ghost" />

```hbs showLineNumbers
<Button @variant="ghost">Ghost</Button>
```

### Destructive

<ComponentPreview name="button-destructive" />

```hbs showLineNumbers
<Button @variant="destructive">Destructive</Button>
```

### Link

<ComponentPreview name="button-link" />

```hbs showLineNumbers
<Button @variant="link">Link</Button>
```

### Icon

<ComponentPreview name="button-icon" />

```hbs showLineNumbers
<Button @variant="outline" @size="icon" aria-label="Submit">
  <CircleFadingArrowUpIcon />
</Button>
```

### With Icon

The spacing between the icon and the text is automatically adjusted based on the size of the button. You do not need any margin on the icon.

<ComponentPreview name="button-with-icon" />

```hbs showLineNumbers
<Button @variant="outline" @size="sm">
  <GitBranch />
  New Branch
</Button>
```

### Rounded

Use the `rounded-full` class to make the button rounded.

<ComponentPreview name="button-rounded" />

```hbs showLineNumbers
<Button @variant="outline" @size="icon" @class="rounded-full">
  <ArrowUpRightIcon />
</Button>
```

### Spinner

<ComponentPreview name="button-loading" />

```hbs showLineNumbers
<Button @size="sm" @variant="outline" @disabled={{true}}>
  <Spinner />
  Submit
</Button>
```

### Button Group

To create a button group, use the `ButtonGroup` component. See the [Button Group](/docs/components/button-group) documentation for more details.

<ComponentPreview name="button-group-demo" />

```hbs showLineNumbers
<ButtonGroup>
  <ButtonGroup>
    <Button @variant="outline" @size="icon" aria-label="Go Back">
      <ArrowLeftIcon />
    </Button>
  </ButtonGroup>
  <ButtonGroup>
    <Button @variant="outline">Archive</Button>
    <Button @variant="outline">Report</Button>
  </ButtonGroup>
  <ButtonGroup>
    <Button @variant="outline">Snooze</Button>
    <DropdownMenu>
      <DropdownMenuTrigger @asChild={{true}}>
        <Button @variant="outline" @size="icon" aria-label="More Options">
          <MoreHorizontalIcon />
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent />
    </DropdownMenu>
  </ButtonGroup>
</ButtonGroup>
```

### Link Component

You can use the `@asChild` argument to make another component look like a button. Here's an example of a link that looks like a button:

<ComponentPreview name="button-as-link" />

```gts showLineNumbers
import { LinkTo } from '@ember/routing';
import Button from '@/components/ui/button';

<template>
  <Button @asChild={{true}}>
    <LinkTo @route="index">Login</LinkTo>
  </Button>
</template>
```

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
