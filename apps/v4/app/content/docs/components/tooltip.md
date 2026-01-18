---
title: Tooltip
description: A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.
---

<ComponentPreview name="tooltip-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add tooltip
```

### Manual

**Install the following dependencies:**

```bash
pnpm add @floating-ui/dom ember-provide-consume-context
```

**Copy and paste the tooltip component into your project:**

<ComponentSource name="tooltip" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Button } from '@/components/ui/button';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';
```

```hbs showLineNumbers
<Tooltip>
  <TooltipTrigger>
    <Button @variant="outline">Hover</Button>
  </TooltipTrigger>
  <TooltipContent>
    <p>Add to library</p>
  </TooltipContent>
</Tooltip>
```
