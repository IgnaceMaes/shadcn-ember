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
pnpm add ember-primitives ember-click-outside
```

**Copy and paste the popover component into your project:**

<ComponentSource name="popover" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Popover } from '@/components/ui/popover';
```

```hbs showLineNumbers
<Popover as |p|>
  <p.Trigger>Open</p.Trigger>
  <p.Content>Place content for the popover here.</p.Content>
</Popover>
```
