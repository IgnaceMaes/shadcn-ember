---
title: Pagination
description: Pagination with page navigation, next and previous links.
---

<ComponentPreview name="pagination-demo" description="A pagination with previous and next links." />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add pagination
```

### Manual

**Copy and paste the pagination component into your project:**

<ComponentSource name="pagination" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination';
```

```hbs showLineNumbers
<Pagination>
  <PaginationContent>
    <PaginationItem>
      <PaginationPrevious href="#" />
    </PaginationItem>
    <PaginationItem>
      <PaginationLink href="#">1</PaginationLink>
    </PaginationItem>
    <PaginationItem>
      <PaginationEllipsis />
    </PaginationItem>
    <PaginationItem>
      <PaginationNext href="#" />
    </PaginationItem>
  </PaginationContent>
</Pagination>
```

## API Reference

### Pagination

The root pagination component that wraps all pagination elements.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |

### PaginationContent

A list wrapper for pagination items.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |

### PaginationItem

A list item that wraps individual pagination elements.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |

### PaginationLink

A clickable link for individual page numbers.

| Prop        | Type                                       | Default     |
| ----------- | ------------------------------------------ | ----------- |
| `@isActive` | `boolean`                                  | `false`     |
| `@size`     | `"default" \| "sm" \| "lg" \| "icon"`      | `"icon"`    |
| `@class`    | `string`                                   | `undefined` |

### PaginationPrevious

A link to navigate to the previous page.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |

### PaginationNext

A link to navigate to the next page.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |

### PaginationEllipsis

An ellipsis indicator for skipped pages.

| Prop     | Type     | Default     |
| -------- | -------- | ----------- |
| `@class` | `string` | `undefined` |
