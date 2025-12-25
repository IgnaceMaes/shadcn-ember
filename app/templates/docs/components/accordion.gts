import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  ComponentInstallation,
  CodeBlockThemed,
} from '@/components/docs';
import AccordionDemo from '@/components/docs/examples/accordion-demo';
import { Accordion } from '@/components/ui/accordion';

const usageCode = `<Accordion
  @type="single"
  @collapsible={{true}}
  @value="item-1"
  as |value setValue|
>
  <AccordionItem
    @value="item-1"
    @currentValue={{value}}
    @setValue={{setValue}}
    @type="single"
    as |isOpen toggle|
  >
    <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>
      Is it accessible?
    </AccordionTrigger>
    <AccordionContent @isOpen={{isOpen}}>
      Yes. It adheres to the WAI-ARIA design pattern.
    </AccordionContent>
  </AccordionItem>
</Accordion>`;

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Accordion"
      @description="A vertically stacked set of interactive headings that each reveal a section of content."
    />

    <DocContent>
      <ComponentPreview @component={{AccordionDemo}} />

      <page.Heading>Installation</page.Heading>
      <ComponentInstallation @name="accordion" @component={{Accordion}} />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed
        @language="gts"
        @code="import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion';"
      />
      <CodeBlockThemed @language="hbs" @code={{usageCode}} />
    </DocContent>
  </DocPage>
</template>
