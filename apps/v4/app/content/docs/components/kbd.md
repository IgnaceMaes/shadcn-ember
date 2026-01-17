---
title: Kbd
description: Used to display textual user input from keyboard.
---

<ComponentPreview name="kbd-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add kbd
```

### Manual

**Copy and paste the kbd component into your project:**

<ComponentSource name="kbd" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Kbd } from '@/components/ui/kbd';
```

```hbs showLineNumbers
<Kbd>Ctrl</Kbd>
```

## Examples

### Group

Use the `KbdGroup` component to group keyboard keys together.

<ComponentPreview name="kbd-group" />

### Button

Use the `Kbd` component inside a `Button` component to display a keyboard key inside a button.

<ComponentPreview name="kbd-button" />

### Tooltip

You can use the `Kbd` component inside a `Tooltip` component to display a tooltip with a keyboard key.

<ComponentPreview name="kbd-tooltip" />

### Input Group

You can use the `Kbd` component inside a `InputGroupAddon` component to display a keyboard key inside an input group.

<ComponentPreview name="kbd-input-group" />

## API Reference

### Kbd

Use the `Kbd` component to display a keyboard key.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` | ``      |

```hbs showLineNumbers
<Kbd>Ctrl</Kbd>
```

### KbdGroup

Use the `KbdGroup` component to group `Kbd` components together.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` | ``      |

```hbs showLineNumbers
<KbdGroup>
  <Kbd>Ctrl</Kbd>
  <Kbd>B</Kbd>
</KbdGroup>
```
