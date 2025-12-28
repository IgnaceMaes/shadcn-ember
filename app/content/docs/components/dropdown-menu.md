---
title: Dropdown Menu
description: Displays a menu to the user — such as a set of actions or functions — triggered by a button.
---

<ComponentPreview name="dropdown-menu-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add dropdown-menu
```

### Manual

**Install the following dependency:**

```bash
pnpm add ember-click-outside
```

**Copy and paste the dropdown menu component into your project:**

<ComponentSource name="dropdown-menu" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
```

```hbs showLineNumbers
<DropdownMenu as |dm|>
  <dm.Trigger>Open</dm.Trigger>
  <dm.Content>
    <DropdownMenuLabel>My Account</DropdownMenuLabel>
    <DropdownMenuSeparator />
    <DropdownMenuItem>Profile</DropdownMenuItem>
    <DropdownMenuItem>Billing</DropdownMenuItem>
    <DropdownMenuItem>Team</DropdownMenuItem>
    <DropdownMenuItem>Subscription</DropdownMenuItem>
  </dm.Content>
</DropdownMenu>
```

## Examples

### Checkboxes

<ComponentPreview name="dropdown-menu-checkboxes" />

### Radio Group

<ComponentPreview name="dropdown-menu-radio-group" />

### Dialog

This example shows how to open a dialog from a dropdown menu.

<ComponentPreview name="dropdown-menu-dialog" />
