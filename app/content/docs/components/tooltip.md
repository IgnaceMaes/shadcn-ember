---
title: Tooltip
description: A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.
---

<ComponentPreview name="tooltip-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add tooltip
```

### Manual

**Copy and paste the tooltip component into your project:**

<ComponentSource name="tooltip" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Tooltip } from '@/components/ui/tooltip';
```

```hbs showLineNumbers
<Tooltip as |t|>
  <t.Trigger>Hover</t.Trigger>
  <t.Content>
    <p>Add to library</p>
  </t.Content>
</Tooltip>
```
