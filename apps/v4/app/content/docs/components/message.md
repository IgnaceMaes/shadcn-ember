---
title: Message
description: Displays a message in a conversation, with optional avatar, header, footer, and alignment.
---

<ComponentPreview name="message-demo" />

The `Message` component lays out a single message in a conversation. It handles the avatar, alignment, header, and footer around the message surface.

For AI apps, you can render reasoning steps, tool calls and assistant messages using the `Message` component.

## Installation

### CLI

```bash
npx shadcn-ember@latest add message
```

### Manual

**Copy and paste the message component into your project:**

<ComponentSource name="message" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Bubble, BubbleContent } from '@/components/ui/bubble';
import {
  Message,
  MessageAvatar,
  MessageContent,
} from '@/components/ui/message';
```

```hbs showLineNumbers
<Message>
  <MessageAvatar>
    <Avatar>
      <AvatarImage @alt="@shadcn" @src="https://github.com/shadcn.png" />
      <AvatarFallback>CN</AvatarFallback>
    </Avatar>
  </MessageAvatar>
  <MessageContent>
    <Bubble>
      <BubbleContent>How can I help you today?</BubbleContent>
    </Bubble>
  </MessageContent>
</Message>
```

> [!NOTE]
> `Message` owns the row layout—avatar, alignment, header, and footer. Render the visible message surface inside it with [`Bubble`](/docs/components/bubble).

## Composition

Use the following composition to build a message:

```txt
Message
├── MessageAvatar
└── MessageContent
    ├── MessageHeader
    ├── Bubble
    └── MessageFooter
```

Use `MessageGroup` to stack consecutive messages from the same sender:

```txt
MessageGroup
├── Message
└── Message
```

## Features

- Start and end alignment for sender and receiver rows via the `@align` argument
- Avatar slot that anchors to the bottom of the message and stays clear of the footer
- Header and footer slots for sender names, status, and message actions
- Footer follows the message side; actions stay aligned on `@align="end"` rows
- Group wrapper for stacking consecutive messages from the same sender
- Customizable styling through the `@class` argument on every part

## Examples

### Avatar

Use `MessageAvatar` to render an avatar next to the message. Set `@align="end"` on the message to align the avatar to the end of the message.

<ComponentPreview name="message-avatar" />

| align   | Description                                         |
| ------- | --------------------------------------------------- |
| `start` | Align the message to the start of the conversation. |
| `end`   | Align the message to the end of the conversation.   |

### Group

Use `MessageGroup` to stack consecutive messages from the same sender. Render an empty `MessageAvatar` on the earlier messages to keep them aligned with the avatar on the last one.

<ComponentPreview name="message-group" />

### Header and Footer

Use `MessageHeader` for a sender name and `MessageFooter` for metadata such as a delivery or read status.

<ComponentPreview name="message-header-footer" />

### Actions

Place message-level actions in `MessageFooter`, such as copy, retry, or feedback buttons.

<ComponentPreview name="message-actions" />

## Accessibility

`Message` is a presentational layout wrapper. Accessibility comes from the content you place inside it.

### Label icon-only actions

Action buttons in `MessageFooter` are usually icon-only, so give each one an `aria-label`.

```hbs showLineNumbers
<MessageFooter>
  <Button aria-label="Copy" @size="icon" @variant="ghost">
    <CopyIcon />
  </Button>
</MessageFooter>
```

### Status updates

For in-progress messages, use a [`Marker`](/docs/components/marker) with `role="status"` so assistive tech announces the update as it appears.

```hbs showLineNumbers
<Message>
  <Marker role="status">
    <MarkerIcon>
      <Spinner />
    </MarkerIcon>
    <MarkerContent>Checking the logs...</MarkerContent>
  </Marker>
</Message>
```

## API Reference

### Message

The message row wrapper.

| Prop     | Type               | Default   | Description                                       |
| -------- | ------------------ | --------- | ------------------------------------------------- |
| `@align` | `"start" \| "end"` | `"start"` | The alignment of the message in the conversation. |
| `@class` | `string`           | `-`       | Additional classes to apply to the row.           |

### MessageGroup

Groups consecutive messages from the same sender.

| Prop     | Type     | Default | Description                                    |
| -------- | -------- | ------- | ---------------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the group root. |

### MessageAvatar

The avatar slot, aligned to the bottom of the message. When the message has a `MessageFooter`, the avatar shifts up to stay aligned with the message surface instead of the footer.

| Prop     | Type     | Default | Description                                     |
| -------- | -------- | ------- | ----------------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the avatar slot. |

### MessageContent

Wraps the header, message surface, and footer.

| Prop     | Type     | Default | Description                                      |
| -------- | -------- | ------- | ------------------------------------------------ |
| `@class` | `string` | `-`     | Additional classes to apply to the content slot. |

### MessageHeader

Displays content above the message, such as a sender name. Stays aligned to the start regardless of `@align`.

| Prop     | Type     | Default | Description                                |
| -------- | -------- | ------- | ------------------------------------------ |
| `@class` | `string` | `-`     | Additional classes to apply to the header. |

### MessageFooter

Displays content below the message, such as status or actions. Aligns to the message side.

| Prop     | Type     | Default | Description                                |
| -------- | -------- | ------- | ------------------------------------------ |
| `@class` | `string` | `-`     | Additional classes to apply to the footer. |
