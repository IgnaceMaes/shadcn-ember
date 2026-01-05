---
title: Spinner
description: An indicator that can be used to show a loading state.
---

<ComponentPreview name="spinner-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add spinner
```

### Manual

**Copy and paste the spinner component into your project:**

<ComponentSource name="spinner" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Spinner } from '@/components/ui/spinner';
```

```hbs showLineNumbers
<Spinner />
```

## Customization

You can replace the default spinner icon with any other icon by editing the `Spinner` component.

<ComponentPreview name="spinner-custom" />

## Examples

### Size

Use the `size-*` utility class to change the size of the spinner.

<ComponentPreview name="spinner-size" />

### Color

Use the `text-` utility class to change the color of the spinner.

<ComponentPreview name="spinner-color" />

### Button

Add a spinner to a button to indicate a loading state. The `<Button />` will handle the spacing between the spinner and the text.

<ComponentPreview name="spinner-button" />

### Badge

You can also use a spinner inside a badge.

<ComponentPreview name="spinner-badge" />

### Input Group

Input Group can have spinners inside `<InputGroupAddon>`.

<ComponentPreview name="spinner-input-group" />

### Empty

<ComponentPreview name="spinner-empty" />

### Item

Use the spinner inside `<ItemMedia>` to indicate a loading state.

<ComponentPreview name="spinner-item" />

## API Reference

### Spinner

Use the `Spinner` component to display a spinner.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` | ``      |

```hbs
<Spinner />
```
