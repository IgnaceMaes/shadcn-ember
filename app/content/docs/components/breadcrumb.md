---
title: Breadcrumb
description: Displays the path to the current resource using a hierarchy of links.
---

<ComponentPreview name="breadcrumb-demo" align="start" />

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

<ComponentPreview name="breadcrumb-separator" align="start" />

```gts showLineNumbers {1,12}
import SlashIcon from '~icons/lucide/slash';

...

<template>
  <Breadcrumb>
    <BreadcrumbList>
      <BreadcrumbItem>
        <BreadcrumbLink @href="/">Home</BreadcrumbLink>
      </BreadcrumbItem>
      <BreadcrumbSeparator>
        <SlashIcon />
      </BreadcrumbSeparator>
      <BreadcrumbItem>
        <BreadcrumbLink @href="/components">Components</BreadcrumbLink>
      </BreadcrumbItem>
    </BreadcrumbList>
  </Breadcrumb>
</template>
```

---

### Dropdown

You can compose `<BreadcrumbItem />` with a `<DropdownMenu />` to create a dropdown in the breadcrumb.

<ComponentPreview name="breadcrumb-dropdown" align="start" />

```gts showLineNumbers {1-6,11-22}
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

...

<template>
  <BreadcrumbItem>
    <DropdownMenu>
      <DropdownMenuTrigger>
        Components
      </DropdownMenuTrigger>
      <DropdownMenuContent>
        <DropdownMenuItem>Documentation</DropdownMenuItem>
        <DropdownMenuItem>Themes</DropdownMenuItem>
        <DropdownMenuItem>GitHub</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  </BreadcrumbItem>
</template>
```

---

### Collapsed

We provide a `<BreadcrumbEllipsis />` component to show a collapsed state when the breadcrumb is too long.

<ComponentPreview name="breadcrumb-ellipsis" align="start" />

```gts showLineNumbers {1,10}
import { BreadcrumbEllipsis } from '@/components/ui/breadcrumb';

...

<template>
  <Breadcrumb>
    <BreadcrumbList>
      {{! ... }}
      <BreadcrumbItem>
        <BreadcrumbEllipsis />
      </BreadcrumbItem>
      {{! ... }}
    </BreadcrumbList>
  </Breadcrumb>
</template>
```

---

### Link component

To use a custom link component from your routing library, you can use the `@asChild` prop on `<BreadcrumbLink />`.

<ComponentPreview name="breadcrumb-link" align="start" />

```gts showLineNumbers {1,9-11}
import { LinkTo } from '@ember/routing';

...

<template>
  <Breadcrumb>
    <BreadcrumbList>
      <BreadcrumbItem>
        <BreadcrumbLink @asChild={{true}}>
          <LinkTo @route="index">Home</LinkTo>
        </BreadcrumbLink>
      </BreadcrumbItem>
      {{! ... }}
    </BreadcrumbList>
  </Breadcrumb>
</template>
```

---

### Responsive

Here's an example of a responsive breadcrumb that composes `<BreadcrumbItem />` with `<BreadcrumbEllipsis />`, `<DropdownMenu />`, and `<Drawer />`.

It displays a dropdown on desktop and a drawer on mobile.

<ComponentPreview name="breadcrumb-responsive" align="start" />
