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
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';
```

```hbs showLineNumbers
<Accordion
  @type='single'
  @collapsible={{true}}
  @value='item-1'
  as |value setValue|
>
  <AccordionItem
    @value='item-1'
    @currentValue={{value}}
    @setValue={{setValue}}
    @type='single'
    as |isOpen toggle|
  >
    <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>
      Is it accessible?
    </AccordionTrigger>
    <AccordionContent @isOpen={{isOpen}}>
      Yes. It adheres to the WAI-ARIA design pattern.
    </AccordionContent>
  </AccordionItem>
</Accordion>
```
