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
import { Dialog } from '@/components/ui/dialog';
```

```hbs showLineNumbers
<Dialog as |d|>
  <d.Trigger>Open</d.Trigger>
  <d.Content>
    <d.Header>
      <d.Title>Are you absolutely sure?</d.Title>
      <d.Description>
        This action cannot be undone. This will permanently delete your account
        and remove your data from our servers.
      </d.Description>
    </d.Header>
  </d.Content>
</Dialog>
```

## Examples

### Custom close button

<ComponentPreview name="dialog-close-button" />

## Notes

To use the `Dialog` component from within a `Context Menu` or `Dropdown Menu`, you must encase the `Context Menu` or `Dropdown Menu` component in the `Dialog` component.

```gts showLineNumbers {1, 26}
<Dialog as |d|>
  <ContextMenu as |cm|>
    <cm.Trigger>Right click</cm.Trigger>
    <cm.Content>
      <cm.Item>Open</cm.Item>
      <cm.Item>Download</cm.Item>
      <d.Trigger @asChild={{true}}>
        <cm.Item>
          <span>Delete</span>
        </cm.Item>
      </d.Trigger>
    </cm.Content>
  </ContextMenu>
  <d.Content>
    <d.Header>
      <d.Title>Are you absolutely sure?</d.Title>
      <d.Description>
        This action cannot be undone. Are you sure you want to permanently
        delete this file from our servers?
      </d.Description>
    </d.Header>
    <d.Footer>
      <Button type="submit">Confirm</Button>
    </d.Footer>
  </d.Content>
</Dialog>
```
