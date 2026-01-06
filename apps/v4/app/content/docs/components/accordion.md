---
title: Accordion
description: A vertically stacked set of interactive headings that each reveal a section of content.
---

<ComponentPreview name="accordion-demo" align="start" class="[&>div]:sm:max-w-[80%]" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add accordion
```

### Manual

**Copy and paste the accordion component into your project:**

<ComponentSource name="accordion" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Accordion,
  AccordionItem,
  AccordionTrigger,
  AccordionContent,
} from '@/components/ui/accordion';
```

```hbs showLineNumbers
<Accordion @type='single' @collapsible={{true}}>
  <AccordionItem @value='item-1'>
    <AccordionTrigger>Is it accessible?</AccordionTrigger>
    <AccordionContent>Yes. It adheres to the WAI-ARIA design pattern.</AccordionContent>
  </AccordionItem>

  <AccordionItem @value='item-2'>
    <AccordionTrigger>Is it styled?</AccordionTrigger>
    <AccordionContent>
      Yes. It comes with default styles that matches the other components'
      aesthetic.
    </AccordionContent>
  </AccordionItem>

  <AccordionItem @value='item-3'>
    <AccordionTrigger>Is it animated?</AccordionTrigger>
    <AccordionContent>
      Yes. It's animated by default, but you can disable it if you prefer.
    </AccordionContent>
  </AccordionItem>
</Accordion>
```
