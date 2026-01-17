---
title: Empty
description: Use the Empty component to display an empty state.
---

<ComponentPreview name="empty-demo" class="[&_.preview]:p-0" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add empty
```

### Manual

**Copy and paste the empty component into your project:**

<ComponentSource name="empty" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Empty,
  EmptyContent,
  EmptyDescription,
  EmptyHeader,
  EmptyMedia,
  EmptyTitle,
} from '@/components/ui/empty';
```

```hbs showLineNumbers
<Empty>
  <EmptyHeader>
    <EmptyMedia @variant="icon">
      <Icon />
    </EmptyMedia>
    <EmptyTitle>No data</EmptyTitle>
    <EmptyDescription>No data found</EmptyDescription>
  </EmptyHeader>
  <EmptyContent>
    <Button>Add data</Button>
  </EmptyContent>
</Empty>
```

## Examples

### Outline

Use the `border` utility class to create an outline empty state.

<ComponentPreview name="empty-outline" class="[&_.preview]:p-6 md:[&_.preview]:p-10" />

### Background

Use the `bg-*` and `bg-gradient-*` utilities to add a background to the empty state.

<ComponentPreview name="empty-background" class="[&_.preview]:p-0" />

### Avatar

Use the `EmptyMedia` component to display an avatar in the empty state.

<ComponentPreview name="empty-avatar" class="[&_.preview]:p-0" />

### Avatar Group

Use the `EmptyMedia` component to display an avatar group in the empty state.

<ComponentPreview name="empty-avatar-group" class="[&_.preview]:p-0" />

### InputGroup

You can add an `InputGroup` component to the `EmptyContent` component.

<ComponentPreview name="empty-input-group" class="[&_.preview]:p-0" />

## API Reference

### Empty

The main component of the empty state. Wraps the `EmptyHeader` and `EmptyContent` components.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs showLineNumbers
<Empty>
  <EmptyHeader />
  <EmptyContent />
</Empty>
```

### EmptyHeader

The `EmptyHeader` component wraps the empty media, title, and description.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs showLineNumbers
<EmptyHeader>
  <EmptyMedia />
  <EmptyTitle />
  <EmptyDescription />
</EmptyHeader>
```

### EmptyMedia

Use the `EmptyMedia` component to display the media of the empty state such as an icon or an image. You can also use it to display other components such as an avatar.

| Prop       | Type                  | Default     |
| ---------- | --------------------- | ----------- |
| `@variant` | `"default" \| "icon"` | `"default"` |
| `@class`   | `string`              |             |

```hbs showLineNumbers
<EmptyMedia @variant="icon">
  <Icon />
</EmptyMedia>
```

```hbs showLineNumbers
<EmptyMedia>
  <Avatar>
    <AvatarImage @src="..." />
    <AvatarFallback>CN</AvatarFallback>
  </Avatar>
</EmptyMedia>
```

### EmptyTitle

Use the `EmptyTitle` component to display the title of the empty state.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs showLineNumbers
<EmptyTitle>No data</EmptyTitle>
```

### EmptyDescription

Use the `EmptyDescription` component to display the description of the empty state.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs showLineNumbers
<EmptyDescription>You do not have any notifications.</EmptyDescription>
```

### EmptyContent

Use the `EmptyContent` component to display the content of the empty state such as a button, input or a link.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs showLineNumbers
<EmptyContent>
  <Button>Add Project</Button>
</EmptyContent>
```
