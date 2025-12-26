import { pageTitle } from 'ember-page-title';
import SiteHeader from '@/components/site-header';
import SiteFooter from '@/components/site-footer';

<template>
  {{pageTitle "The Foundation for your Design System - shadcn-ember"}}

  <SiteHeader />
  {{outlet}}
  <SiteFooter />
</template>
