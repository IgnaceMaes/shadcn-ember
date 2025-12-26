import {
  DocPage,
  DocHeader,
  DocContent,
  DocParagraph,
} from '@/components/docs';

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Changelog"
      @description="Latest updates and announcements."
    />

    <DocContent>
      <page.Heading>December 2025 - Initial release</page.Heading>
      <DocParagraph>
        We are excited to announce the initial release of shadcn-ember! This
        marks the beginning of our journey to provide a comprehensive component
        library for Ember.js developers.
      </DocParagraph>
    </DocContent>
  </DocPage>
</template>
