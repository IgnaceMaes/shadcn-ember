---
title: Popover
description: Displays rich content in a portal, triggered by a button.
---

<ComponentPreview name="popover-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add popover
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-click-outside
```

**Copy and paste the popover component into your project:**

<ComponentSource name="popover" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Popover,
  PopoverTrigger,
  PopoverContent,
} from '@/components/ui/popover';
```

```hbs showLineNumbers
<Popover>
  <PopoverTrigger>Open</PopoverTrigger>
  <PopoverContent>Place content for the popover here.</PopoverContent>
</Popover>
```
