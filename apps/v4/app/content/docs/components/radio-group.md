---
title: Radio Group
description: A set of checkable buttons—known as radio buttons—where no more than one of the buttons can be checked at a time.
---

<ComponentPreview name="radio-group-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add radio-group
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-provide-consume-context
```

**Copy and paste the radio-group component into your project:**

<ComponentSource name="radio-group" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Label } from '@/components/ui/label';
import { RadioGroup } from '@/components/ui/radio-group';
```

```hbs showLineNumbers
<RadioGroup @defaultValue="option-one" as |rg|>
  <div class="flex items-center gap-3">
    <rg.Item @value="option-one" id="option-one" />
    <Label @for="option-one">Option One</Label>
  </div>
  <div class="flex items-center gap-3">
    <rg.Item @value="option-two" id="option-two" />
    <Label @for="option-two">Option Two</Label>
  </div>
</RadioGroup>
```
