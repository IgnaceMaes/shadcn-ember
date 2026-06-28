---
title: Bubble
description: Displays conversational content in a message bubble. Supports variants, alignment, grouping, reactions, and collapsible content.
---

<ComponentPreview name="bubble-demo" class="h-[560px]" />

The `Bubble` component displays framed conversational content. Use it for chat text, short structured output, quoted replies, suggestions, and reactions.

For full-featured chat interfaces, use the `Message` component. `Bubble` is intentionally scoped to the bubble surface. Place avatars, names, timestamps, metadata, and message-level actions in `Message`.

## Installation

### CLI

```bash
npx shadcn-ember@latest add bubble
```

### Manual

**Copy and paste the bubble component into your project:**

<ComponentSource name="bubble" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Bubble,
  BubbleContent,
  BubbleReactions,
} from '@/components/ui/bubble';
```

```hbs showLineNumbers
<Bubble>
  <BubbleContent>
    I checked the registry output and removed the stale route.
  </BubbleContent>
  <BubbleReactions>
    <span>👍</span>
  </BubbleReactions>
</Bubble>
```

## Composition

Use the following composition to build a bubble:

```txt
Bubble
├── BubbleContent
└── BubbleReactions
```

Use `BubbleGroup` to group consecutive bubbles from the same sender:

```txt
BubbleGroup
├── Bubble
│   └── BubbleContent
└── Bubble
    └── BubbleContent
```

## Features

- Seven visual variants, from a strong primary bubble to unframed ghost content
- Start and end alignment for sender and receiver bubbles
- Reactions that anchor to the bubble edge with configurable side and alignment
- Bubbles size to their content, up to 80% of the container width
- Polymorphic content via `@asChild` for link and button bubbles
- Customizable styling through the `@class` argument on every part

## Examples

### Variants

Use `@variant` to change the visual treatment of the bubble.

<ComponentPreview name="bubble-variants" class="h-[950px]" />

| Variant       | Description                                            |
| ------------- | ------------------------------------------------------ |
| `default`     | A strong primary bubble, usually for the current user. |
| `secondary`   | The standard neutral bubble for conversation content.  |
| `muted`       | A lower-emphasis bubble for quiet supporting content.  |
| `tinted`      | A subtle primary-tinted bubble.                        |
| `outline`     | A bordered bubble for secondary or rich content.       |
| `ghost`       | Unframed content for assistant text or rich content.   |
| `destructive` | A destructive bubble for error or failed actions.      |

A bubble sizes to its content, up to 80% of the container width. The `ghost` variant removes the max-width so assistant text and rich content can span the full row.

### Alignment

Use `@align` on `Bubble` to align the bubble to the start or end of the conversation.

<ComponentPreview name="bubble-alignment" />

| align   | Description                                        |
| ------- | -------------------------------------------------- |
| `start` | Align the bubble to the start of the conversation. |
| `end`   | Align the bubble to the end of the conversation.   |

> [!NOTE]
> When building chat interfaces, you probably want to use alignment on the `Message` component itself, not the `Bubble` component. You can use the `@role` argument on the `Message` component to automatically align the bubble to the start or end of the conversation.

### Bubble Group

Use `BubbleGroup` to group consecutive bubbles from the same sender. Note the `@align` argument should be set on the `Bubble` component itself, not the `BubbleGroup` component.

```txt
BubbleGroup
├── Bubble
│   └── BubbleContent
└── Bubble
    └── BubbleContent
```

<ComponentPreview name="bubble-group" class="h-[540px]" />

### Links and Buttons

You can turn a bubble into a link or button by using the `@asChild` argument on `BubbleContent`. Apply the yielded `classes` and the `data-slot="bubble-content"` attribute to your element.

<ComponentPreview name="bubble-link-button" />

```gts showLineNumbers
import { Bubble, BubbleContent } from '@/components/ui/bubble';

<template>
  <Bubble @variant="muted">
    <BubbleContent @asChild={{true}} as |content|>
      <button
        type="button"
        class={{content.classes}}
        data-slot="bubble-content"
      >
        Click here
      </button>
    </BubbleContent>
  </Bubble>
</template>
```

### Reactions

Use `BubbleReactions` for bubble reactions. You can use it to display reactions or quick action buttons. Use `@side` and `@align` to position the row — `@side="top"` anchors it to the upper edge. Reactions overlap the bubble edge, so leave vertical space between rows — the examples below use a larger gap for this reason.

<ComponentPreview name="bubble-reactions" class="h-[640px]" />

### Show More / Collapsible

Long bubble content can be composed with `Collapsible` to allow for a show more or show less interaction. Use the `CollapsibleTrigger` component to trigger the collapsible content.

<ComponentPreview name="bubble-collapsible" />

### Tooltip

Wrap a bubble in a `Tooltip` to reveal metadata on hover, such as when a message was read.

<ComponentPreview name="bubble-tooltip" />

### Popover

Pair a bubble with a `Popover` to surface more information on demand, such as the full error message for a failed action.

<ComponentPreview name="bubble-popover" />

## Accessibility

`Bubble` renders the presentational message surface. Keep conversation-level semantics on the surrounding container and follow the guidelines below.

### Labeling Reactions

Reactions render as a row of emoji. A screen reader reads each glyph with no context, and counters like `+8` are announced as "plus eight". Group the row as a single image with a descriptive `aria-label` so it announces once. `role="img"` also hides the individual emoji from assistive tech, so no `aria-hidden` is needed.

```hbs showLineNumbers
<BubbleReactions role="img" aria-label="Reactions: thumbs up, fire, and 8 more">
  <span>👍</span>
  <span>🔥</span>
  <span>+8</span>
</BubbleReactions>
```

When reactions are interactive, render buttons instead and give icon-only buttons an `aria-label`.

```hbs showLineNumbers
<BubbleReactions>
  <Button aria-label="Thumbs up" @variant="secondary" @size="icon-sm">
    <ThumbsUp />
  </Button>
</BubbleReactions>
```

### Interactive Bubbles

When a bubble is clickable, render it as a real `<button>` or `<a>` with the `@asChild` argument so it is focusable and exposes the correct role. `BubbleContent` ships a visible focus ring for interactive elements, and the accessible name comes from the bubble text. No extra label is needed.

```hbs showLineNumbers
<Bubble @variant="muted" @align="end">
  <BubbleContent @asChild={{true}} as |content|>
    <button
      type="button"
      class={{content.classes}}
      data-slot="bubble-content"
      {{on "click" this.onReply}}
    >
      I forgot my password
    </button>
  </BubbleContent>
</Bubble>
```

### Meaning Beyond Color

Bubble variants signal role and tone with color. Pair them with text, alignment, or icons so meaning is not conveyed by color alone. For a destructive bubble, keep the error context in the message text rather than relying on the color treatment.

## API Reference

### Bubble

The root bubble wrapper.

| Prop       | Type                                                                                       | Default     | Description                              |
| ---------- | ------------------------------------------------------------------------------------------ | ----------- | ---------------------------------------- |
| `@variant` | `"default" \| "secondary" \| "muted" \| "tinted" \| "outline" \| "ghost" \| "destructive"` | `"default"` | The bubble visual treatment.             |
| `@align`   | `"start" \| "end"`                                                                         | `"start"`   | The inline alignment of the bubble.      |
| `@class`   | `string`                                                                                   | `-`         | Additional classes for the root element. |

### BubbleContent

The bubble content wrapper.

| Prop       | Type      | Default | Description                                 |
| ---------- | --------- | ------- | ------------------------------------------- |
| `@asChild` | `boolean` | `false` | Render the content as the child element.    |
| `@class`   | `string`  | `-`     | Additional classes for the content element. |

### BubbleReactions

Displays overlapped reactions for a bubble.

| Prop     | Type                | Default    | Description                                     |
| -------- | ------------------- | ---------- | ----------------------------------------------- |
| `@side`  | `"top" \| "bottom"` | `"bottom"` | The side of the bubble to anchor the reactions. |
| `@align` | `"start" \| "end"`  | `"end"`    | The inline alignment of the reactions.          |
| `@class` | `string`            | `-`        | Additional classes for the reaction row.        |

### BubbleGroup

Groups consecutive bubbles from the same sender.

| Prop     | Type     | Default | Description                            |
| -------- | -------- | ------- | -------------------------------------- |
| `@class` | `string` | `-`     | Additional classes for the group root. |
