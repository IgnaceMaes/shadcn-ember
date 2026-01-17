---
title: Context Menu
description: Displays a menu to the user — such as a set of actions or functions — triggered by right click.
---

<ComponentPreview name="context-menu-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add context-menu
```

### Manual

**Install the following dependency:**

```bash
pnpm add ember-click-outside
```

**Copy and paste the context menu component into your project:**

<ComponentSource name="context-menu" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  ContextMenu,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuTrigger,
} from '@/components/ui/context-menu';
```

```hbs showLineNumbers
<ContextMenu>
  <ContextMenuTrigger>Right click here</ContextMenuTrigger>
  <ContextMenuContent>
    <ContextMenuItem>Profile</ContextMenuItem>
    <ContextMenuItem>Billing</ContextMenuItem>
    <ContextMenuItem>Team</ContextMenuItem>
    <ContextMenuItem>Subscription</ContextMenuItem>
  </ContextMenuContent>
</ContextMenu>
```
