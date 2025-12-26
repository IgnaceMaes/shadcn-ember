import { LinkTo } from '@ember/routing';
import {
  DocPage,
  DocHeader,
  DocContent,
  DocParagraph,
  DocLink,
} from '@/components/docs';
import Separator from '@/components/ui/separator';

// Component list with "new" badges for recent additions and hasPage flag
const components = [
  {
    name: 'Accordion',
    route: 'docs.components.accordion',
    isNew: false,
    hasPage: true,
  },
  {
    name: 'Alert Dialog',
    route: 'docs.components.alert-dialog',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Alert',
    route: 'docs.components.alert',
    isNew: false,
    hasPage: true,
  },
  {
    name: 'Aspect Ratio',
    route: 'docs.components.aspect-ratio',
    isNew: false,
    hasPage: true,
  },
  {
    name: 'Avatar',
    route: 'docs.components.avatar',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Badge',
    route: 'docs.components.badge',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Breadcrumb',
    route: 'docs.components.breadcrumb',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Button Group',
    route: 'docs.components.button-group',
    isNew: true,
    hasPage: false,
  },
  {
    name: 'Button',
    route: 'docs.components.button',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Calendar',
    route: 'docs.components.calendar',
    isNew: false,
    hasPage: false,
  },
  { name: 'Card', route: 'docs.components.card', isNew: false, hasPage: false },
  {
    name: 'Carousel',
    route: 'docs.components.carousel',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Chart',
    route: 'docs.components.chart',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Checkbox',
    route: 'docs.components.checkbox',
    isNew: false,
    hasPage: true,
  },
  {
    name: 'Collapsible',
    route: 'docs.components.collapsible',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Command',
    route: 'docs.components.command',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Context Menu',
    route: 'docs.components.context-menu',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Dialog',
    route: 'docs.components.dialog',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Dropdown Menu',
    route: 'docs.components.dropdown-menu',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Empty',
    route: 'docs.components.empty',
    isNew: true,
    hasPage: false,
  },
  {
    name: 'Field',
    route: 'docs.components.field',
    isNew: true,
    hasPage: false,
  },
  { name: 'Form', route: 'docs.components.form', isNew: false, hasPage: false },
  {
    name: 'Hover Card',
    route: 'docs.components.hover-card',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Input Group',
    route: 'docs.components.input-group',
    isNew: true,
    hasPage: false,
  },
  {
    name: 'Input OTP',
    route: 'docs.components.input-otp',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Input',
    route: 'docs.components.input',
    isNew: false,
    hasPage: false,
  },
  { name: 'Item', route: 'docs.components.item', isNew: true, hasPage: false },
  { name: 'Kbd', route: 'docs.components.kbd', isNew: true, hasPage: false },
  {
    name: 'Label',
    route: 'docs.components.label',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Menubar',
    route: 'docs.components.menubar',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Navigation Menu',
    route: 'docs.components.navigation-menu',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Pagination',
    route: 'docs.components.pagination',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Popover',
    route: 'docs.components.popover',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Progress',
    route: 'docs.components.progress',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Radio Group',
    route: 'docs.components.radio-group',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Resizable',
    route: 'docs.components.resizable',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Scroll Area',
    route: 'docs.components.scroll-area',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Select',
    route: 'docs.components.select',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Separator',
    route: 'docs.components.separator',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Sheet',
    route: 'docs.components.sheet',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Skeleton',
    route: 'docs.components.skeleton',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Slider',
    route: 'docs.components.slider',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Sonner',
    route: 'docs.components.sonner',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Spinner',
    route: 'docs.components.spinner',
    isNew: true,
    hasPage: false,
  },
  {
    name: 'Switch',
    route: 'docs.components.switch',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Table',
    route: 'docs.components.table',
    isNew: false,
    hasPage: false,
  },
  { name: 'Tabs', route: 'docs.components.tabs', isNew: false, hasPage: false },
  {
    name: 'Textarea',
    route: 'docs.components.textarea',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Toast',
    route: 'docs.components.toast',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Toggle Group',
    route: 'docs.components.toggle-group',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Toggle',
    route: 'docs.components.toggle',
    isNew: false,
    hasPage: false,
  },
  {
    name: 'Tooltip',
    route: 'docs.components.tooltip',
    isNew: false,
    hasPage: false,
  },
];

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Components"
      @description="Here you can find all the components available in the library. We are working on adding more components."
    />
    <page.Heading>Available Components</page.Heading>

    <DocContent>
      <div
        class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3 md:gap-x-8 lg:gap-x-16 lg:gap-y-6 xl:gap-x-20"
      >
        {{#each components as |c|}}
          {{#if c.hasPage}}
            <LinkTo
              @route={{c.route}}
              class="inline-flex items-center gap-2 text-lg font-medium underline-offset-4 hover:underline md:text-base"
            >
              {{c.name}}
              {{#if c.isNew}}
                <span
                  class="flex size-2 rounded-full bg-blue-500"
                  title="New"
                ></span>
              {{/if}}
            </LinkTo>
          {{else}}
            <span
              class="inline-flex items-center gap-2 text-lg font-medium text-muted-foreground md:text-base"
            >
              {{c.name}}
              {{#if c.isNew}}
                <span
                  class="flex size-2 rounded-full bg-blue-500"
                  title="New"
                ></span>
              {{/if}}
            </span>
          {{/if}}
        {{/each}}
      </div>

      <Separator @class="my-4 md:my-8" />

      <DocParagraph>
        Can't find what you need? Check back soon as we're actively adding more
        components to match the <DocLink @href="https://ui.shadcn.com/docs/components">shadcn/ui library</DocLink>.
      </DocParagraph>
    </DocContent>
  </DocPage>
</template>
