import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  CodeBlockThemed,
} from '@/components/docs';
import CheckboxDemo from '@/components/docs/examples/checkbox-demo';

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Checkbox"
      @description="A control that allows the user to toggle between checked and not checked."
    />

    <DocContent>
      <ComponentPreview @component={{CheckboxDemo}} />

      <page.Heading>Installation</page.Heading>
      <CodeBlockThemed @language="bash" @code="pnpm dlx shadcn@latest add checkbox" />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed @language="gts" @code="import Checkbox from '@/components/ui/checkbox';" />
      <CodeBlockThemed @language="gts" @code="<Checkbox />" />
    </DocContent>
  </DocPage>
</template>
