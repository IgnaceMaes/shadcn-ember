import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentPreview,
  ComponentInstallation,
  CodeBlockThemed,
} from '@/components/docs';
import AlertDemo from '@/components/docs/examples/alert-demo';
import AlertComponent from '@/components/ui/alert';

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
      <ComponentInstallation @name="alert" @component={{AlertComponent}} />

      <page.Heading>Usage</page.Heading>
      <CodeBlockThemed
        @language="gts"
        @code="import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';"
      />
      <CodeBlockThemed @language="hbs" @code={{usageCode}} />
    </DocContent>
  </DocPage>
</template>
