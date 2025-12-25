import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  ComponentInstallation,
  CodeBlockThemed,
} from '@/components/docs';
import CheckboxDemo from '@/components/docs/examples/checkbox-demo';
import CheckboxComponent from '@/components/ui/checkbox';

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Checkbox"
      @description="A control that allows the user to toggle between checked and not checked."
    />

    <DocContent>
      <ComponentPreview @component={{CheckboxDemo}} />

      <page.Heading>Installation</page.Heading>
      <ComponentInstallation @name="checkbox" @component={{CheckboxComponent}} />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed @language="gts" @code="import Checkbox from '@/components/ui/checkbox';" />
      <CodeBlockThemed @language="gts" @code="<Checkbox />" />
    </DocContent>
  </DocPage>
</template>
