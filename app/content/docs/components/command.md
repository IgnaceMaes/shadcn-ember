---
title: Command
description: Fast, composable, unstyled command menu for Ember.
---

<ComponentPreview name="command-demo" description="A command menu" class="[&_.preview>div]:max-w-[450px]" align="start" />

## About

The `<Command />` component uses the [`cmdk`](https://cmdk.paco.me) component by [pacocoursey](https://twitter.com/pacocoursey).

## Installation

### CLI

```bash
npx embercli-shadcn@latest add command
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

```gts showLineNumbers
import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
  CommandShortcut,
} from '@/components/ui/command';
import Calendar from '~icons/lucide/calendar';
import Smile from '~icons/lucide/smile';
import Calculator from '~icons/lucide/calculator';

export default class CommandMenu extends Component {
  @tracked open = false;

  handleKeyDown = (e: KeyboardEvent) => {
    if (e.key === 'k' && (e.metaKey || e.ctrlKey)) {
      e.preventDefault();
      this.open = !this.open;
    }
  };

  <template>
    {{! template-lint-disable no-invalid-interactive }}
    <div {{on "keydown" this.handleKeyDown}}>
      <CommandDialog
        @open={{this.open}}
        @onOpenChange={{(fn (mut this.open))}}
      >
        <CommandInput @placeholder="Type a command or search..." />
        <CommandList>
          <CommandEmpty>No results found.</CommandEmpty>
          <CommandGroup @heading="Suggestions">
            <CommandItem>
              <Calendar />
              <span>Calendar</span>
            </CommandItem>
            <CommandItem>
              <Smile />
              <span>Search Emoji</span>
            </CommandItem>
            <CommandItem>
              <Calculator />
              <span>Calculator</span>
            </CommandItem>
          </CommandGroup>
        </CommandList>
      </CommandDialog>
    </div>
  </template>
}
```

### Combobox

You can use the `<Command />` component as a combobox. See the [Combobox](/docs/components/combobox) page for more information.
