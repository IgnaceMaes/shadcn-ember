---
title: Hover Card
description: For sighted users to preview content available behind a link.
---

<ComponentPreview name="hover-card-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add hover-card
```

### Manual

**Copy and paste the hover-card component into your project:**

<ComponentSource name="hover-card" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from '@/components/ui/hover-card';
```

```hbs showLineNumbers
<HoverCard>
  <HoverCardTrigger>Hover</HoverCardTrigger>
  <HoverCardContent>
    The React Framework – created and maintained by @vercel.
  </HoverCardContent>
</HoverCard>
```
