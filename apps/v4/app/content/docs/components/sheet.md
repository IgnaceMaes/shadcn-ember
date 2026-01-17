---
title: Sheet
description: Extends the Dialog component to display content that complements the main content of the screen.
---

<ComponentPreview name="sheet-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add sheet
```

### Manual

**Copy and paste the sheet component into your project:**

<ComponentSource name="sheet" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from '@/components/ui/sheet';
```

```hbs showLineNumbers
<Sheet as |isOpen setOpen|>
  <SheetTrigger @setOpen={{setOpen}}>Open</SheetTrigger>
  <SheetContent @isOpen={{isOpen}} @setOpen={{setOpen}}>
    <SheetHeader>
      <SheetTitle>Are you absolutely sure?</SheetTitle>
      <SheetDescription>
        This action cannot be undone. This will permanently delete your account
        and remove your data from our servers.
      </SheetDescription>
    </SheetHeader>
  </SheetContent>
</Sheet>
```

## Examples

### Side

Use the `@side` argument to `<SheetContent />` to indicate the edge of the screen where the component will appear. The values can be `top`, `right`, `bottom` or `left`.

<ComponentPreview name="sheet-side" />

### Size

You can adjust the size of the sheet using CSS classes:

```hbs showLineNumbers {3}
<Sheet as |isOpen setOpen|>
  <SheetTrigger @setOpen={{setOpen}}>Open</SheetTrigger>
  <SheetContent @isOpen={{isOpen}} @setOpen={{setOpen}} @class="w-[400px] sm:w-[540px]">
    <SheetHeader>
      <SheetTitle>Are you absolutely sure?</SheetTitle>
      <SheetDescription>
        This action cannot be undone. This will permanently delete your account
        and remove your data from our servers.
      </SheetDescription>
    </SheetHeader>
  </SheetContent>
</Sheet>
```
