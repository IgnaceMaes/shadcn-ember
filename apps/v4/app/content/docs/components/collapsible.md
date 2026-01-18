---
title: Collapsible
description: An interactive component which expands/collapses a panel.
---

<ComponentPreview name="collapsible-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add collapsible
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-provide-consume-context
```

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
<Collapsible>
  <CollapsibleTrigger>
    Can I use this in my project?
  </CollapsibleTrigger>
  <CollapsibleContent>
    Yes. Free to use for personal and commercial projects. No attribution
    required.
  </CollapsibleContent>
</Collapsible>
```
