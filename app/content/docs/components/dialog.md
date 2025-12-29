---
title: Dialog
description: A window overlaid on either the primary window or another dialog window, rendering the content underneath inert.
featured: true
---

<ComponentPreview name="dialog-demo" description="A dialog for editing profile details." />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add dialog
```

### Manual

**Copy and paste the dialog component into your project:**

<ComponentSource name="dialog" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
```

```hbs showLineNumbers
<Dialog>
  <DialogTrigger>Open</DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Are you absolutely sure?</DialogTitle>
      <DialogDescription>
        This action cannot be undone. This will permanently delete your account
        and remove your data from our servers.
      </DialogDescription>
    </DialogHeader>
  </DialogContent>
</Dialog>
```

## Examples

### Custom close button

<ComponentPreview name="dialog-close-button" />

## Notes

To use the `Dialog` component from within a `Context Menu` or `Dropdown Menu`, you must encase the `Context Menu` or `Dropdown Menu` component in the `Dialog` component.

```hbs showLineNumbers {1, 26}
<Dialog>
  <ContextMenu as |cm|>
    <cm.Trigger>Right click</cm.Trigger>
    <cm.Content>
      <cm.Item>Open</cm.Item>
      <cm.Item>Download</cm.Item>
      <DialogTrigger @asChild={{true}}>
        <cm.Item>
          <span>Delete</span>
        </cm.Item>
      </DialogTrigger>
    </cm.Content>
  </ContextMenu>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Are you absolutely sure?</DialogTitle>
      <DialogDescription>
        This action cannot be undone. Are you sure you want to permanently
        delete this file from our servers?
      </DialogDescription>
    </DialogHeader>
    <DialogFooter>
      <Button type="submit">Confirm</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```
