import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  ComponentInstallation,
  CodeBlockThemed,
} from '@/components/docs';
import AspectRatioDemo from '@/components/docs/examples/aspect-ratio-demo';
import AspectRatioComponent from '@/components/ui/aspect-ratio';

const ratio = 16 / 9;

const usageCode = `<AspectRatio @ratio={{ratio}}>
  <img
    src="..."
    alt="Image"
    class="rounded-md object-cover"
  />
</AspectRatio>`;

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Aspect Ratio"
      @description="Displays content within a desired ratio."
    />

    <DocContent>
      <ComponentPreview @component={{AspectRatioDemo}} />

      <page.Heading>Installation</page.Heading>
      <ComponentInstallation
        @name="aspect-ratio"
        @component={{AspectRatioComponent}}
      />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed
        @language="gts"
        @code="import { AspectRatio } from '@/components/ui/aspect-ratio';"
      />
      <CodeBlockThemed @language="hbs" @code={{usageCode}} />
    </DocContent>
  </DocPage>
</template>
