import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '@/components/ui/accordion';

<template>
  <div class="w-full">
    <Accordion
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
          Product Information
        </AccordionTrigger>
        <AccordionContent @isOpen={{isOpen}}>
          <div class="flex flex-col gap-4 text-balance">
            <p>
              Our flagship product combines cutting-edge technology with sleek
              design. Built with premium materials, it offers unparalleled
              performance and reliability.
            </p>
            <p>
              Key features include advanced processing capabilities, and an
              intuitive user interface designed for both beginners and experts.
            </p>
          </div>
        </AccordionContent>
      </AccordionItem>
      <AccordionItem
        @value="item-2"
        @currentValue={{value}}
        @setValue={{setValue}}
        @type="single"
        as |isOpen toggle|
      >
        <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>
          Shipping Details
        </AccordionTrigger>
        <AccordionContent @isOpen={{isOpen}}>
          <div class="flex flex-col gap-4 text-balance">
            <p>
              We offer worldwide shipping through trusted courier partners.
              Standard delivery takes 3-5 business days, while express shipping
              ensures delivery within 1-2 business days.
            </p>
            <p>
              All orders are carefully packaged and fully insured. Track your
              shipment in real-time through our dedicated tracking portal.
            </p>
          </div>
        </AccordionContent>
      </AccordionItem>
      <AccordionItem
        @value="item-3"
        @currentValue={{value}}
        @setValue={{setValue}}
        @type="single"
        as |isOpen toggle|
      >
        <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>
          Return Policy
        </AccordionTrigger>
        <AccordionContent @isOpen={{isOpen}}>
          <div class="flex flex-col gap-4 text-balance">
            <p>
              We stand behind our products with a comprehensive 30-day return
              policy. If you're not completely satisfied, simply return the item
              in its original condition.
            </p>
            <p>
              Our hassle-free return process includes free return shipping and
              full refunds processed within 48 hours of receiving the returned
              item.
            </p>
          </div>
        </AccordionContent>
      </AccordionItem>
    </Accordion>
  </div>
</template>
