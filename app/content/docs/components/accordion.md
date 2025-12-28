---
title: Accordion
description: A vertically stacked set of interactive headings that each reveal a section of content.
---

<ComponentPreview name="accordion-demo" align="start" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add accordion
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-velcro
```

**Copy and paste the accordion component into your project:**

<ComponentSource name="accordion" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Accordion } from '@/components/ui/accordion';
```

```hbs showLineNumbers
<Accordion @type='single' @collapsible={{true}} as |Item|>
  <Item @value='item-1' as |Trigger Content|>
    <Trigger>Is it accessible?</Trigger>
    <Content>Yes. It adheres to the WAI-ARIA design pattern.</Content>
  </Item>

  <Item @value='item-2' as |Trigger Content|>
    <Trigger>Is it styled?</Trigger>
    <Content>
      Yes. It comes with default styles that matches the other components'
      aesthetic.
    </Content>
  </Item>

  <Item @value='item-3' as |Trigger Content|>
    <Trigger>Is it animated?</Trigger>
    <Content>
      Yes. It's animated by default, but you can disable it if you prefer.
    </Content>
  </Item>
</Accordion>
```
