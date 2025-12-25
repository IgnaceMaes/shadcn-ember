import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  CodeBlockThemed,
} from '@/components/docs';
import CheckboxDemo from '@/components/docs/examples/checkbox-demo';
import checkboxDemoCode from '@/components/docs/examples/checkbox-demo.gts?raw';

<template>
  <DocPage as |page|>
    <div class="flex flex-col gap-2">
      <div class="flex flex-col gap-2">
        <DocHeader
          @title="Checkbox"
          @description="A control that allows the user to toggle between checked and not checked."
        />
      </div>
    </div>

    <DocContent>
      <ComponentPreview
        @component={{CheckboxDemo}}
        @code={{checkboxDemoCode}}
      />

      <page.Heading>Installation</page.Heading>
      <CodeBlockThemed @language="bash" @code="pnpm dlx shadcn@latest add checkbox" />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed @language="gts" @code="import Checkbox from '@/components/ui/checkbox';" />
      <CodeBlockThemed @language="gts" @code="<Checkbox />" />
    </DocContent>
  </DocPage>
</template>
