---
title: Aspect Ratio
description: Displays content within a desired ratio.
order: 102
---

<ComponentPreview name="aspect-ratio-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add aspect-ratio
```

### Manual

**Copy and paste the aspect ratio component into your project:**

<ComponentSource name="aspect-ratio" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { AspectRatio } from '@/components/ui/aspect-ratio';
```

```hbs showLineNumbers
<AspectRatio @ratio={{ratio}}>
  <img
    src="..."
    alt="Image"
    class="rounded-md object-cover"
  />
</AspectRatio>
```
