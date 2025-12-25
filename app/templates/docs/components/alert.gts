import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  CodeBlockThemed,
} from '@/components/docs';
import AlertDemo from '@/components/docs/examples/alert-demo';

const usageCode = `<Alert @variant="default">
  <Terminal />
  <AlertTitle>Heads up!</AlertTitle>
  <AlertDescription>
    You can add components and dependencies to your app using the cli.
  </AlertDescription>
</Alert>`;

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Alert"
      @description="Displays a callout for user attention."
    />

    <DocContent>
      <ComponentPreview @component={{AlertDemo}} />

      <page.Heading>Installation</page.Heading>
      <CodeBlockThemed @language="bash" @code="pnpm dlx shadcn@latest add alert" />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed
        @language="gts"
        @code="import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';"
      />
      <CodeBlockThemed @language="gts" @code={{usageCode}} />
    </DocContent>
  </DocPage>
</template>
