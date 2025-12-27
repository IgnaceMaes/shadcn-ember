import { pageTitle } from 'ember-page-title';
import SiteHeader from '@/components/site-header';
import SiteFooter from '@/components/site-footer';
import { Portal } from '@/components/ui/portal';

<template>
  {{pageTitle "The Foundation for your Design System - shadcn-ember"}}

  <SiteHeader />
  {{outlet}}
  <SiteFooter />
  <Portal />
</template>
