---
title: Drawer
description: A drawer component for Ember.
---

<ComponentPreview name="drawer-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add drawer
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-provide-consume-context ember-modifier
```

**Copy and paste the drawer component into your project:**

<ComponentSource name="drawer" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from '@/components/ui/drawer';
```

```hbs showLineNumbers
<Drawer>
  <DrawerTrigger>Open</DrawerTrigger>
  <DrawerContent>
    <DrawerHeader>
      <DrawerTitle>Are you absolutely sure?</DrawerTitle>
      <DrawerDescription>This action cannot be undone.</DrawerDescription>
    </DrawerHeader>
    <DrawerFooter>
      <Button>Submit</Button>
      <DrawerClose>
        <Button @variant="outline">Cancel</Button>
      </DrawerClose>
    </DrawerFooter>
  </DrawerContent>
</Drawer>
```

## Examples

### Scrollable Content

Keep actions visible while the content scrolls.

<ComponentPreview name="drawer-scrollable-content" />

### Sides

Use the `@direction` argument to set the side of the drawer. Available options are `top`, `right`, `bottom`, and `left`.

<ComponentPreview name="drawer-sides" />

### Responsive Dialog

You can combine the `Dialog` and `Drawer` components to create a responsive dialog. This renders a `Dialog` component on desktop and a `Drawer` on mobile.

<ComponentPreview name="drawer-dialog" />
