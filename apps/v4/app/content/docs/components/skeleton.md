---
title: Skeleton
description: Use to show a placeholder while content is loading.
---

<ComponentPreview name="skeleton-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add skeleton
```

### Manual

**Copy and paste the skeleton component into your project:**

<ComponentSource name="skeleton" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Skeleton } from '@/components/ui/skeleton';
```

```hbs showLineNumbers
<Skeleton @class="h-[20px] w-[100px] rounded-full" />
```

## Examples

### Card

<ComponentPreview name="skeleton-card" />
