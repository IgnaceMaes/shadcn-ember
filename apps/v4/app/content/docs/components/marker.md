---
title: Marker
description: Displays an inline status, system note, bordered row, or labeled separator in a conversation.
---

<ComponentPreview name="marker-demo" />

The `Marker` component displays inline conversation markers such as status updates, system notes, bordered rows, and labeled separators. Compose it with `Message` in a conversation thread.

## Installation

### CLI

```bash
npx shadcn-ember@latest add marker
```

### Manual

**Copy and paste the marker component into your project:**

<ComponentSource name="marker" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Marker, MarkerContent, MarkerIcon } from '@/components/ui/marker';
```

```hbs showLineNumbers
<Marker>
  <MarkerIcon>
    <CheckIcon />
  </MarkerIcon>
  <MarkerContent>Explored 4 files</MarkerContent>
</Marker>
```

## Composition

Use the following composition to build a marker:

```txt
Marker
├── MarkerIcon
└── MarkerContent
```

## Features

- Inline marker, bordered row, and labeled separator variants
- Decorative icon slot that is hidden from assistive tech
- Polymorphic root via `@asChild` for link and button markers
- Pairs with the `shimmer` utility for streaming status text
- Customizable styling through the `@class` argument on every part

## Examples

### Variants

Use `@variant` to switch between an inline marker, bordered row, and labeled separator.

<ComponentPreview name="marker-variants" />

| Variant     | Description                                          |
| ----------- | ---------------------------------------------------- |
| `default`   | An inline marker for status, notes, and actions.     |
| `border`    | A default marker with a bottom border under the row. |
| `separator` | A centered label with divider lines on each side.    |

### Status

Set `role="status"` and include a `Spinner` for streaming or in-progress markers so updates are announced.

<ComponentPreview name="marker-status" />

### Shimmer

Add the `shimmer` utility class to `MarkerContent` for an animated streaming-text effect.

<ComponentPreview name="marker-shimmer" />

### Separator

Use the `separator` variant for labeled dividers, such as dates or section breaks, in a conversation.

<ComponentPreview name="marker-separator" />

### Border

Use the `border` variant for status rows that should keep the default marker alignment while separating the next row.

<ComponentPreview name="marker-border" />

### With Icon

Use `MarkerIcon` to render an icon alongside the content. Use `flex-col` to stack the icon above the content.

<ComponentPreview name="marker-icon" />

### Links and Buttons

Turn a marker into a link or button with the `@asChild` argument on `Marker`. Apply the yielded `classes` and the `data-slot="marker"` attribute to your element.

<ComponentPreview name="marker-link-button" />

```gts showLineNumbers
import { Marker, MarkerContent } from '@/components/ui/marker';

<template>
  <Marker @asChild={{true}} as |marker|>
    <a class={{marker.classes}} data-slot="marker" data-variant="default" href="#">
      <MarkerContent>View the pull request</MarkerContent>
    </a>
  </Marker>
</template>
```

## Accessibility

`Marker` is presentational by default. The correct semantics depend on how you use it, so choose the role based on intent rather than relying on a single default.

### Status and Progress

For streaming or progress markers such as "Thinking..." or a running tool, set `role="status"` so assistive tech announces the update as it appears. `Marker` forwards `role` to the underlying element.

```hbs showLineNumbers
<Marker role="status">
  <MarkerIcon>
    <Spinner />
  </MarkerIcon>
  <MarkerContent>Compacting conversation</MarkerContent>
</Marker>
```

### Labeled Separators

A separator that carries text, such as a date or a section label, needs no role. The divider lines are decorative CSS pseudo-elements, and the text is announced as ordinary content.

```hbs showLineNumbers
<Marker @variant="separator">
  <MarkerContent>Today</MarkerContent>
</Marker>
```

> [!NOTE]
> Do not add `role="separator"` to a labeled divider. A separator takes its accessible name from `aria-label`, not from its text, and its contents are treated as presentational, so the visible label would not be announced. Reserve `role="separator"` for a divider with no meaningful text.

### Bordered Markers

A bordered marker keeps the same semantics as the default marker. The bottom border is decorative, so choose `role="status"`, `@asChild`, or no role based on the marker's purpose.

```hbs showLineNumbers
<Marker @variant="border">
  <MarkerIcon>
    <FileTextIcon />
  </MarkerIcon>
  <MarkerContent>Opened implementation notes</MarkerContent>
</Marker>
```

### Decorative Icons

`MarkerIcon` is decorative and hidden from assistive tech with `aria-hidden`, so the adjacent `MarkerContent` carries the meaning. For an icon-only marker, provide an `aria-label` or visible text so it is not announced as empty.

```hbs showLineNumbers
<Marker aria-label="Synced">
  <MarkerIcon>
    <CheckIcon />
  </MarkerIcon>
</Marker>
```

### Interactive Markers

When a marker links or triggers an action, render it as a real `<button>` or `<a>` with the `@asChild` argument so it is focusable and exposes the correct role. The accessible name comes from the marker text.

```hbs showLineNumbers
<Marker @asChild={{true}} as |marker|>
  <a class={{marker.classes}} data-slot="marker" data-variant="default" href="/files">
    <MarkerIcon>
      <FileTextIcon />
    </MarkerIcon>
    <MarkerContent>Explored 4 files</MarkerContent>
  </a>
</Marker>
```

## API Reference

### Marker

The root marker element. The file also exports `markerVariants` for composing the marker styles into custom components.

| Prop       | Type                                   | Default     | Description                                      |
| ---------- | -------------------------------------- | ----------- | ------------------------------------------------ |
| `@variant` | `"default" \| "border" \| "separator"` | `"default"` | The marker layout.                               |
| `@asChild` | `boolean`                              | `false`     | Render as the child element, such as a link.     |
| `@class`   | `string`                               | `-`         | Additional classes to apply to the root element. |

### MarkerIcon

A decorative icon slot. Hidden from assistive tech with `aria-hidden`.

| Prop     | Type     | Default | Description                                   |
| -------- | -------- | ------- | --------------------------------------------- |
| `@class` | `string` | `-`     | Additional classes to apply to the icon slot. |

### MarkerContent

The marker text content.

| Prop     | Type     | Default | Description                                      |
| -------- | -------- | ------- | ------------------------------------------------ |
| `@class` | `string` | `-`     | Additional classes to apply to the content slot. |
