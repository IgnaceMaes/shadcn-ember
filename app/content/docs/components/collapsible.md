---
title: Collapsible
description: An interactive component which expands/collapses a panel.
---

<ComponentPreview name="collapsible-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add collapsible
```

### Manual

**Copy and paste the collapsible component into your project:**

<ComponentSource name="collapsible" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from '@/components/ui/collapsible';
```

```hbs showLineNumbers
<Collapsible as |c|>
  <c.Trigger>
    Can I use this in my project?
  </c.Trigger>
  <c.Content>
    Yes. Free to use for personal and commercial projects. No attribution
    required.
  </c.Content>
</Collapsible>
```
