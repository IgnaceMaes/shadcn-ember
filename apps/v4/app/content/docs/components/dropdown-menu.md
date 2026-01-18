---
title: Dropdown Menu
description: Displays a menu to the user — such as a set of actions or functions — triggered by a button.
---

<ComponentPreview name="dropdown-menu-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add dropdown-menu
```

### Manual

**Install the following dependencies:**

```bash
pnpm add @floating-ui/dom ember-click-outside ember-provide-consume-context
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
<DropdownMenu>
  <DropdownMenuTrigger>Open</DropdownMenuTrigger>
  <DropdownMenuContent>
    <DropdownMenuLabel>My Account</DropdownMenuLabel>
    <DropdownMenuSeparator />
    <DropdownMenuItem>Profile</DropdownMenuItem>
    <DropdownMenuItem>Billing</DropdownMenuItem>
    <DropdownMenuItem>Team</DropdownMenuItem>
    <DropdownMenuItem>Subscription</DropdownMenuItem>
  </DropdownMenuContent>
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
