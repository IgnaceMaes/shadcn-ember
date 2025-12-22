import { pageTitle } from 'ember-page-title';
import ThemeToggle from '@/components/theme-toggle';

<template>
  {{pageTitle "ShadcnEmber"}}

  <div class="fixed top-4 right-4 z-50">
    <ThemeToggle />
  </div>

  {{outlet}}
</template>
