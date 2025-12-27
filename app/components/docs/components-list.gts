import DocLinkTo from './doc-link-to';
import { Tooltip } from '@/components/ui/tooltip';

// Import all markdown files to see which components have pages
const markdownFiles = import.meta.glob<string>(
  '/app/content/docs/components/*.md',
  {
    query: '?raw',
    eager: true,
    import: 'default',
  }
);

interface ComponentItem {
  name: string;
  route: string;
  isNew: boolean;
  hasPage: boolean;
}

// Check if a component has a markdown page
function hasMarkdownPage(componentFileName: string): boolean {
  const markdownPath = `/app/content/docs/components/${componentFileName}.md`;
  return markdownPath in markdownFiles;
}

// Component list from shadcn/ui - this is the complete list of components to work towards
// hasPage is dynamically determined based on the presence of a markdown file
const components: ComponentItem[] = [
  {
    name: 'Accordion',
    route: 'docs.components.accordion',
    isNew: false,
    hasPage: hasMarkdownPage('accordion'),
  },
  {
    name: 'Alert Dialog',
    route: 'docs.components.alert-dialog',
    isNew: false,
    hasPage: hasMarkdownPage('alert-dialog'),
  },
  {
    name: 'Alert',
    route: 'docs.components.alert',
    isNew: false,
    hasPage: hasMarkdownPage('alert'),
  },
  {
    name: 'Aspect Ratio',
    route: 'docs.components.aspect-ratio',
    isNew: false,
    hasPage: hasMarkdownPage('aspect-ratio'),
  },
  {
    name: 'Avatar',
    route: 'docs.components.avatar',
    isNew: false,
    hasPage: hasMarkdownPage('avatar'),
  },
  {
    name: 'Badge',
    route: 'docs.components.badge',
    isNew: false,
    hasPage: hasMarkdownPage('badge'),
  },
  {
    name: 'Breadcrumb',
    route: 'docs.components.breadcrumb',
    isNew: false,
    hasPage: hasMarkdownPage('breadcrumb'),
  },
  {
    name: 'Button Group',
    route: 'docs.components.button-group',
    isNew: true,
    hasPage: hasMarkdownPage('button-group'),
  },
  {
    name: 'Button',
    route: 'docs.components.button',
    isNew: false,
    hasPage: hasMarkdownPage('button'),
  },
  {
    name: 'Calendar',
    route: 'docs.components.calendar',
    isNew: false,
    hasPage: hasMarkdownPage('calendar'),
  },
  {
    name: 'Card',
    route: 'docs.components.card',
    isNew: false,
    hasPage: hasMarkdownPage('card'),
  },
  {
    name: 'Carousel',
    route: 'docs.components.carousel',
    isNew: false,
    hasPage: hasMarkdownPage('carousel'),
  },
  {
    name: 'Chart',
    route: 'docs.components.chart',
    isNew: false,
    hasPage: hasMarkdownPage('chart'),
  },
  {
    name: 'Checkbox',
    route: 'docs.components.checkbox',
    isNew: false,
    hasPage: hasMarkdownPage('checkbox'),
  },
  {
    name: 'Collapsible',
    route: 'docs.components.collapsible',
    isNew: false,
    hasPage: hasMarkdownPage('collapsible'),
  },
  {
    name: 'Combobox',
    route: 'docs.components.combobox',
    isNew: false,
    hasPage: hasMarkdownPage('combobox'),
  },
  {
    name: 'Command',
    route: 'docs.components.command',
    isNew: false,
    hasPage: hasMarkdownPage('command'),
  },
  {
    name: 'Context Menu',
    route: 'docs.components.context-menu',
    isNew: false,
    hasPage: hasMarkdownPage('context-menu'),
  },
  {
    name: 'Data Table',
    route: 'docs.components.data-table',
    isNew: false,
    hasPage: hasMarkdownPage('data-table'),
  },
  {
    name: 'Date Picker',
    route: 'docs.components.date-picker',
    isNew: false,
    hasPage: hasMarkdownPage('date-picker'),
  },
  {
    name: 'Dialog',
    route: 'docs.components.dialog',
    isNew: false,
    hasPage: hasMarkdownPage('dialog'),
  },
  {
    name: 'Drawer',
    route: 'docs.components.drawer',
    isNew: false,
    hasPage: hasMarkdownPage('drawer'),
  },
  {
    name: 'Dropdown Menu',
    route: 'docs.components.dropdown-menu',
    isNew: false,
    hasPage: hasMarkdownPage('dropdown-menu'),
  },
  {
    name: 'Empty',
    route: 'docs.components.empty',
    isNew: true,
    hasPage: hasMarkdownPage('empty'),
  },
  {
    name: 'Field',
    route: 'docs.components.field',
    isNew: true,
    hasPage: hasMarkdownPage('field'),
  },
  {
    name: 'Form',
    route: 'docs.components.form',
    isNew: false,
    hasPage: hasMarkdownPage('form'),
  },
  {
    name: 'Hover Card',
    route: 'docs.components.hover-card',
    isNew: false,
    hasPage: hasMarkdownPage('hover-card'),
  },
  {
    name: 'Input Group',
    route: 'docs.components.input-group',
    isNew: true,
    hasPage: hasMarkdownPage('input-group'),
  },
  {
    name: 'Input OTP',
    route: 'docs.components.input-otp',
    isNew: false,
    hasPage: hasMarkdownPage('input-otp'),
  },
  {
    name: 'Input',
    route: 'docs.components.input',
    isNew: false,
    hasPage: hasMarkdownPage('input'),
  },
  {
    name: 'Item',
    route: 'docs.components.item',
    isNew: true,
    hasPage: hasMarkdownPage('item'),
  },
  {
    name: 'Kbd',
    route: 'docs.components.kbd',
    isNew: true,
    hasPage: hasMarkdownPage('kbd'),
  },
  {
    name: 'Label',
    route: 'docs.components.label',
    isNew: false,
    hasPage: hasMarkdownPage('label'),
  },
  {
    name: 'Menubar',
    route: 'docs.components.menubar',
    isNew: false,
    hasPage: hasMarkdownPage('menubar'),
  },
  {
    name: 'Native Select',
    route: 'docs.components.native-select',
    isNew: false,
    hasPage: hasMarkdownPage('native-select'),
  },
  {
    name: 'Navigation Menu',
    route: 'docs.components.navigation-menu',
    isNew: false,
    hasPage: hasMarkdownPage('navigation-menu'),
  },
  {
    name: 'Pagination',
    route: 'docs.components.pagination',
    isNew: false,
    hasPage: hasMarkdownPage('pagination'),
  },
  {
    name: 'Popover',
    route: 'docs.components.popover',
    isNew: false,
    hasPage: hasMarkdownPage('popover'),
  },
  {
    name: 'Progress',
    route: 'docs.components.progress',
    isNew: false,
    hasPage: hasMarkdownPage('progress'),
  },
  {
    name: 'Radio Group',
    route: 'docs.components.radio-group',
    isNew: false,
    hasPage: hasMarkdownPage('radio-group'),
  },
  {
    name: 'Resizable',
    route: 'docs.components.resizable',
    isNew: false,
    hasPage: hasMarkdownPage('resizable'),
  },
  {
    name: 'Scroll Area',
    route: 'docs.components.scroll-area',
    isNew: false,
    hasPage: hasMarkdownPage('scroll-area'),
  },
  {
    name: 'Select',
    route: 'docs.components.select',
    isNew: false,
    hasPage: hasMarkdownPage('select'),
  },
  {
    name: 'Separator',
    route: 'docs.components.separator',
    isNew: false,
    hasPage: hasMarkdownPage('separator'),
  },
  {
    name: 'Sheet',
    route: 'docs.components.sheet',
    isNew: false,
    hasPage: hasMarkdownPage('sheet'),
  },
  {
    name: 'Sidebar',
    route: 'docs.components.sidebar',
    isNew: false,
    hasPage: hasMarkdownPage('sidebar'),
  },
  {
    name: 'Skeleton',
    route: 'docs.components.skeleton',
    isNew: false,
    hasPage: hasMarkdownPage('skeleton'),
  },
  {
    name: 'Slider',
    route: 'docs.components.slider',
    isNew: false,
    hasPage: hasMarkdownPage('slider'),
  },
  {
    name: 'Sonner',
    route: 'docs.components.sonner',
    isNew: false,
    hasPage: hasMarkdownPage('sonner'),
  },
  {
    name: 'Spinner',
    route: 'docs.components.spinner',
    isNew: true,
    hasPage: hasMarkdownPage('spinner'),
  },
  {
    name: 'Switch',
    route: 'docs.components.switch',
    isNew: false,
    hasPage: hasMarkdownPage('switch'),
  },
  {
    name: 'Table',
    route: 'docs.components.table',
    isNew: false,
    hasPage: hasMarkdownPage('table'),
  },
  {
    name: 'Tabs',
    route: 'docs.components.tabs',
    isNew: false,
    hasPage: hasMarkdownPage('tabs'),
  },
  {
    name: 'Textarea',
    route: 'docs.components.textarea',
    isNew: false,
    hasPage: hasMarkdownPage('textarea'),
  },
  {
    name: 'Toast',
    route: 'docs.components.toast',
    isNew: false,
    hasPage: hasMarkdownPage('toast'),
  },
  {
    name: 'Toggle Group',
    route: 'docs.components.toggle-group',
    isNew: false,
    hasPage: hasMarkdownPage('toggle-group'),
  },
  {
    name: 'Toggle',
    route: 'docs.components.toggle',
    isNew: false,
    hasPage: hasMarkdownPage('toggle'),
  },
  {
    name: 'Tooltip',
    route: 'docs.components.tooltip',
    isNew: false,
    hasPage: hasMarkdownPage('tooltip'),
  },
  {
    name: 'Typography',
    route: 'docs.components.typography',
    isNew: false,
    hasPage: hasMarkdownPage('typography'),
  },
];

<template>
  <div
    class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3 md:gap-x-8 lg:gap-x-16 lg:gap-y-6 xl:gap-x-20"
  >
    {{#each components as |c|}}
      {{#if c.hasPage}}
        <DocLinkTo
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
        </DocLinkTo>
      {{else}}
        <Tooltip as |t|>
          <t.Trigger>
            <span
              class="inline-flex items-center gap-2 text-lg font-medium text-muted-foreground md:text-base cursor-help"
            >
              {{c.name}}
              {{#if c.isNew}}
                <span
                  class="flex size-2 rounded-full bg-blue-500"
                  title="New"
                ></span>
              {{/if}}
            </span>
          </t.Trigger>
          <t.Content>
            <p>This component is not yet implemented or documented.</p>
            <p class="text-xs mt-1">Contributions are welcome!</p>
          </t.Content>
        </Tooltip>
      {{/if}}
    {{/each}}
  </div>
</template>
