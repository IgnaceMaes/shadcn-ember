---
title: Attachment
description: Displays a file or image attachment with media, metadata, upload state, and actions.
---

<ComponentPreview name="attachment-demo" />

The `Attachment` component displays a file or image attachment, its media, name, and metadata, with optional actions and upload state. Use it for files and images in chat composers, message threads, and upload lists.

## Installation

### CLI

```bash
npx shadcn-ember@latest add attachment
```

### Manual

**Install the required dependencies:**

```bash
npx shadcn-ember@latest add button
```

**Copy and paste the attachment component into your project:**

<ComponentSource name="attachment" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Attachment,
  AttachmentAction,
  AttachmentActions,
  AttachmentContent,
  AttachmentDescription,
  AttachmentMedia,
  AttachmentTitle,
} from '@/components/ui/attachment';
```

```hbs showLineNumbers
<Attachment>
  <AttachmentMedia>
    <FileTextIcon />
  </AttachmentMedia>
  <AttachmentContent>
    <AttachmentTitle>sales-dashboard.pdf</AttachmentTitle>
    <AttachmentDescription>PDF · 2.4 MB</AttachmentDescription>
  </AttachmentContent>
  <AttachmentActions>
    <AttachmentAction aria-label="Remove sales-dashboard.pdf">
      <XIcon />
    </AttachmentAction>
  </AttachmentActions>
</Attachment>
```

## Composition

Use the following composition to build an attachment:

```txt
Attachment
├── AttachmentMedia
├── AttachmentContent
│   ├── AttachmentTitle
│   └── AttachmentDescription
├── AttachmentActions
│   └── AttachmentAction
└── AttachmentTrigger
```

Use `AttachmentGroup` to lay out multiple attachments in a scrollable row:

```txt
AttachmentGroup
├── Attachment
└── Attachment
```

## Features

- Icon and image media through `AttachmentMedia`
- Upload states: `idle`, `uploading`, `processing`, `error`, and `done` with built-in styling and a shimmer while in progress
- Three sizes and horizontal or vertical orientation
- A full-card `AttachmentTrigger` that opens a link or dialog while the actions stay independently clickable
- Scrollable, snapping `AttachmentGroup` with an edge fade
- Customizable styling through the `@class` argument on every part

## Examples

### Image

Set `@variant="image"` on `AttachmentMedia` and render an `<img>` inside it. Use `@orientation="vertical"` to stack the media above the content.

<ComponentPreview name="attachment-image" />

### States

Set `@state` to reflect the upload lifecycle. `uploading` and `processing` shimmer the title, and `error` switches to a destructive treatment.

<ComponentPreview name="attachment-states" />

### Sizes

Use `@size` to switch between `default`, `sm`, and `xs`.

<ComponentPreview name="attachment-sizes" />

### Group

Wrap attachments in `AttachmentGroup` to lay them out in a horizontally scrollable, snapping row with an edge fade.

<ComponentPreview name="attachment-group" />

### Trigger

Add an `AttachmentTrigger` to make the whole card open a link or dialog. It fills the card behind the actions, so the actions stay clickable.

<ComponentPreview name="attachment-trigger" />

```hbs showLineNumbers
<Dialog>
  <Attachment>
    {{! media, content, actions }}
    <DialogTrigger @asChild={{true}} as |trigger|>
      <AttachmentTrigger
        aria-label="Preview research-summary.pdf"
        {{trigger.modifiers}}
      />
    </DialogTrigger>
  </Attachment>
  <DialogContent>{{! ... }}</DialogContent>
</Dialog>
```

## Accessibility

`AttachmentAction` renders a `Button`, and `AttachmentTrigger` renders a real `<button>` (or your element via `@asChild`). Follow the guidance below so both are operable and announced.

### Label icon-only actions

`AttachmentAction` is usually icon-only, so give each one an `aria-label` describing the action and its target.

```hbs showLineNumbers
<AttachmentAction aria-label="Remove sales-dashboard.pdf">
  <XIcon />
</AttachmentAction>
```

### Label the trigger

`AttachmentTrigger` covers the card with no text of its own, so give it an `aria-label` for what activating it does.

```hbs showLineNumbers
<AttachmentTrigger @asChild={{true}} as |trigger|>
  <a
    aria-label="Open workspace.png"
    class={{trigger.classes}}
    data-slot="attachment-trigger"
    href={{this.url}}
    rel="noreferrer"
    target="_blank"
  ></a>
</AttachmentTrigger>
```

The trigger sits behind the actions in the stacking order, so an `AttachmentAction` and the `AttachmentTrigger` never trap each other — both remain separately focusable and clickable.

### Keyboard scrolling

An `AttachmentGroup` scrolls horizontally. When its attachments are interactive—a trigger or actions—keyboard users reach off-screen items by tabbing to them. For a row of presentational attachments, make the group itself focusable and scrollable by adding `tabindex="0"`, `role="group"`, and an `aria-label`.

### Meaning beyond color

The `error` state uses a destructive color. Keep the failure reason in `AttachmentDescription` so the state is not conveyed by color alone.

## API Reference

### Attachment

The root attachment container.

| Prop           | Type                                                         | Default        | Description                                       |
| -------------- | ------------------------------------------------------------ | -------------- | ------------------------------------------------- |
| `@state`       | `"idle" \| "uploading" \| "processing" \| "error" \| "done"` | `"done"`       | The upload state. Drives styling and the shimmer. |
| `@size`        | `"default" \| "sm" \| "xs"`                                  | `"default"`    | The attachment size.                              |
| `@orientation` | `"horizontal" \| "vertical"`                                 | `"horizontal"` | Lay the media beside or above the content.        |
| `@class`       | `string`                                                     | `-`            | Additional classes to apply to the root element.  |

### AttachmentMedia

The media slot for an icon or image preview.

| Prop       | Type                | Default  | Description                                    |
| ---------- | ------------------- | -------- | ---------------------------------------------- |
| `@variant` | `"icon" \| "image"` | `"icon"` | Whether the media holds an icon or an `<img>`. |
| `@class`   | `string`            | `-`      | Additional classes to apply to the media slot. |

### AttachmentContent

Wraps the title and description.

| Prop     | Type     | Default | Description                                      |
| -------- | -------- | ------- | ------------------------------------------------ |
| `@class` | `string` | `-`     | Additional classes to apply to the content slot. |

### AttachmentTitle

The attachment name. Shimmers while the attachment is `uploading` or `processing`.

| Prop     | Type     | Default | Description                               |
| -------- | -------- | ------- | ----------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the title. |

### AttachmentDescription

Secondary metadata such as the file type, size, or upload status.

| Prop     | Type     | Default | Description                                     |
| -------- | -------- | ------- | ----------------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the description. |

### AttachmentActions

A container for one or more actions, aligned to the end of the attachment.

| Prop     | Type     | Default | Description                                 |
| -------- | -------- | ------- | ------------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the actions. |

### AttachmentAction

An action button. Renders a [`Button`](/docs/components/button) and accepts all of its arguments.

| Prop       | Type     | Default     | Description                                |
| ---------- | -------- | ----------- | ------------------------------------------ |
| `@variant` | `string` | `"ghost"`   | The button variant.                        |
| `@size`    | `string` | `"icon-xs"` | The button size.                           |
| `@class`   | `string` | `-`         | Additional classes to apply to the button. |

### AttachmentTrigger

A full-card overlay that activates the attachment. Renders a `<button>` by default.

| Prop       | Type      | Default | Description                                                     |
| ---------- | --------- | ------- | --------------------------------------------------------------- |
| `@asChild` | `boolean` | `false` | Yield `{ classes }` to render your own element, such as a link. |
| `@class`   | `string`  | `-`     | Additional classes to apply to the trigger element.             |

### AttachmentGroup

Lays out attachments in a horizontally scrollable, snapping row.

| Prop     | Type     | Default | Description                               |
| -------- | -------- | ------- | ----------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the group. |
