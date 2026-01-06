---
title: Item
description: A versatile component that you can use to display any content.
component: true
---

The `Item` component is a straightforward flex container that can house nearly any type of content. Use it to display a title, description, and actions. Group it with the `ItemGroup` component to create a list of items.

You can pretty much achieve the same result with the `div` element and some classes, but **I've built this so many times** that I decided to create a component for it. Now I use it all the time.

<ComponentPreview name="item-demo" className="[&_.preview]:p-4" />

## Installation

<CodeTabs>

<TabsList>
  <TabsTrigger value="cli">CLI</TabsTrigger>
  <TabsTrigger value="manual">Manual</TabsTrigger>
</TabsList>
<TabsContent value="cli">

```bash
npx shadcn-ember@latest add item
```

</TabsContent>

<TabsContent value="manual">

<Steps>

<Step>Copy and paste the following code into your project.</Step>

<ComponentSource name="item" title="components/ui/item.gts" />

<Step>Update the import paths to match your project setup.</Step>

</Steps>

</TabsContent>

</CodeTabs>

## Usage

```gts
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemFooter,
  ItemHeader,
  ItemMedia,
  ItemTitle,
} from '@/components/ui/item';
```

```hbs
<Item>
  <ItemHeader>Item Header</ItemHeader>
  <ItemMedia />
  <ItemContent>
    <ItemTitle>Item</ItemTitle>
    <ItemDescription>Item</ItemDescription>
  </ItemContent>
  <ItemActions />
  <ItemFooter>Item Footer</ItemFooter>
</Item>
```

## Item vs Field

Use `Field` if you need to display a form input such as a checkbox, input, radio, or select.

If you only need to display content such as a title, description, and actions, use `Item`.

## Examples

### Variants

<ComponentPreview name="item-variant" className="[&_.preview]:p-4" />

### Size

The `Item` component has different sizes for different use cases. For example, you can use the `sm` size for a compact item or the `default` size for a standard item.

<ComponentPreview name="item-size" className="[&_.preview]:p-4" />

### Icon

<ComponentPreview name="item-icon" className="[&_.preview]:p-4" />

### Avatar

<ComponentPreview name="item-avatar" className="[&_.preview]:p-4" />

### Image

<ComponentPreview name="item-image" className="[&_.preview]:p-4" />

### Group0p

<ComponentPreview name="item-group" className="[&_.preview]:p-4" />

### Header

<ComponentPreview name="item-header" className="[&_.preview]:p-4" />

### Link

To render an item as a link, use the yielded element. The hover and focus states will be applied to the anchor element.

<ComponentPreview name="item-link" className="[&_.preview]:p-4" />

### Dropdown

<ComponentPreview name="item-dropdown" className="[&_.preview]:p-4" />

## API Reference

### Item

The main component for displaying content with media, title, description, and actions.

| Prop       | Type                                | Default     |
| ---------- | ----------------------------------- | ----------- |
| `@variant` | `"default" \| "outline" \| "muted"` | `"default"` |
| `@size`    | `"default" \| "sm"`                 | `"default"` |
| `@class`   | `string`                            |             |

```hbs
<Item @variant="outline" @size="sm">
  <ItemMedia />
  <ItemContent>
    <ItemTitle>Item</ItemTitle>
    <ItemDescription>Item</ItemDescription>
  </ItemContent>
  <ItemActions />
</Item>
```

### ItemGroup

The `ItemGroup` component is a container that groups related items together with consistent styling.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemGroup>
  <Item />
  <Item />
</ItemGroup>
```

### ItemSeparator

The `ItemSeparator` component is a separator that separates items in the item group.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemGroup>
  <Item />
  <ItemSeparator />
  <Item />
</ItemGroup>
```

### ItemMedia

Use the `ItemMedia` component to display media content such as icons, images, or avatars.

| Prop       | Type                             | Default     |
| ---------- | -------------------------------- | ----------- |
| `@variant` | `"default" \| "icon" \| "image"` | `"default"` |
| `@class`   | `string`                         |             |

```hbs
<ItemMedia @variant="icon">
  <Icon />
</ItemMedia>
```

```hbs
<ItemMedia @variant="image">
  <img src="..." alt="..." />
</ItemMedia>
```

### ItemContent

The `ItemContent` component wraps the title and description of the item.

You can skip `ItemContent` if you only need a title.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemContent>
  <ItemTitle>Item</ItemTitle>
  <ItemDescription>Item</ItemDescription>
</ItemContent>
```

### ItemTitle

Use the `ItemTitle` component to display the title of the item.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemTitle>Item Title</ItemTitle>
```

### ItemDescription

Use the `ItemDescription` component to display the description of the item.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemDescription>Item description</ItemDescription>
```

### ItemActions

Use the `ItemActions` component to display action buttons or other interactive elements.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemActions>
  <Button>Action</Button>
  <Button>Action</Button>
</ItemActions>
```

### ItemHeader

Use the `ItemHeader` component to display a header in the item.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemHeader>Item Header</ItemHeader>
```

### ItemFooter

Use the `ItemFooter` component to display a footer in the item.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

```hbs
<ItemFooter>Item Footer</ItemFooter>
```
