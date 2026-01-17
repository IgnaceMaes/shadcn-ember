---
title: Label
description: Renders an accessible label associated with controls.
---

<ComponentPreview name="label-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add label
```

### Manual

**Copy and paste the label component into your project:**

<ComponentSource name="label" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Label } from '@/components/ui/label';
```

```hbs showLineNumbers
<Label @for="email">Your email address</Label>
```
