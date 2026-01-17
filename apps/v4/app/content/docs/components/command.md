---
title: Command
description: Fast, composable, unstyled command menu for Ember.
---

<ComponentPreview name="command-demo" description="A command menu" class="[&>div]:max-w-[450px]" align="start" />

## About

The `<Command />` component uses the [`cmdk`](https://cmdk.paco.me) component by [pacocoursey](https://twitter.com/pacocoursey).

## Installation

### CLI

```bash
npx shadcn-ember@latest add command
```

### Manual

**Install the following dependencies:**

```bash
pnpm add cmdk
```

**Copy and paste the command component into your project:**

<ComponentSource name="command" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Command,
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
  CommandShortcut,
} from '@/components/ui/command';
```

```hbs showLineNumbers
<Command>
  <CommandInput @placeholder="Type a command or search..." />
  <CommandList>
    <CommandEmpty>No results found.</CommandEmpty>
    <CommandGroup @heading="Suggestions">
      <CommandItem>Calendar</CommandItem>
      <CommandItem>Search Emoji</CommandItem>
      <CommandItem>Calculator</CommandItem>
    </CommandGroup>
    <CommandSeparator />
    <CommandGroup @heading="Settings">
      <CommandItem>Profile</CommandItem>
      <CommandItem>Billing</CommandItem>
      <CommandItem>Settings</CommandItem>
    </CommandGroup>
  </CommandList>
</Command>
```

## Examples

### Dialog

<ComponentPreview name="command-dialog" description="A command menu in a dialog" />

To show the command menu in a dialog, use the `<CommandDialog />` component.

### Combobox

You can use the `<Command />` component as a combobox. See the [Combobox](/docs/components/combobox) page for more information.
