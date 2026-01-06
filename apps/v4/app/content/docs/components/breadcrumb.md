---
title: Breadcrumb
description: Displays the path to the current resource using a hierarchy of links.
---

<ComponentPreview name="breadcrumb-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add breadcrumb
```

### Manual

**Copy and paste the breadcrumb component into your project:**

<ComponentSource name="breadcrumb" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from '@/components/ui/breadcrumb';
```

```gts showLineNumbers
<template>
  <Breadcrumb>
    <BreadcrumbList>
      <BreadcrumbItem>
        <BreadcrumbLink @href="/">Home</BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem>
        <BreadcrumbLink @href="/components">Components</BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator />
      <BreadcrumbItem>
        <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
      </BreadcrumbItem>
    </BreadcrumbList>
  </Breadcrumb>
</template>
```

## Examples

### Custom separator

Use a custom component as children for `<BreadcrumbSeparator />` to create a custom separator.

<ComponentPreview name="breadcrumb-separator" />

---

### Dropdown

You can compose `<BreadcrumbItem />` with a `<DropdownMenu />` to create a dropdown in the breadcrumb.

<ComponentPreview name="breadcrumb-dropdown" />

---

### Collapsed

We provide a `<BreadcrumbEllipsis />` component to show a collapsed state when the breadcrumb is too long.

<ComponentPreview name="breadcrumb-ellipsis" />

---

### Link component

To use a custom link component from your routing library, you can use the `@asChild` prop on `<BreadcrumbLink />`.

<ComponentPreview name="breadcrumb-link" />

---

### Responsive

Here's an example of a responsive breadcrumb that composes `<BreadcrumbItem />` with `<BreadcrumbEllipsis />`, `<DropdownMenu />`, and `<Drawer />`.

It displays a dropdown on desktop and a drawer on mobile.

<ComponentPreview name="breadcrumb-responsive" />
