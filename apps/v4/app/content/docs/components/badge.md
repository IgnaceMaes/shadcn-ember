---
title: Badge
description: Displays a badge or a component that looks like a badge.
---

<ComponentPreview name="badge-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add badge
```

### Manual

**Copy and paste the badge component into your project:**

<ComponentSource name="badge" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Badge } from '@/components/ui/badge';
```

```hbs showLineNumbers
<Badge @variant="default">Badge</Badge>
<Badge @variant="outline">Outline</Badge>
<Badge @variant="secondary">Secondary</Badge>
<Badge @variant="destructive">Destructive</Badge>
```

### Link

You can use the `@asChild` argument to make another component look like a badge. Here's an example of a link that looks like a badge:

```gts showLineNumbers
import { LinkTo } from '@ember/routing';
import { Badge } from '@/components/ui/badge';

<template>
  <Badge @asChild={{true}} as |badge|>
    <LinkTo @route="index" class={{badge.classes}}>
      Badge
    </LinkTo>
  </Badge>
</template>
```
