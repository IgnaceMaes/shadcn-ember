import { pageTitle } from 'ember-page-title';

import SiteFooter from '@/components/site-footer';
import SiteHeader from '@/components/site-header';

<template>
  {{pageTitle "The Foundation for your Design System - shadcn-ember"}}

  <SiteHeader />
  {{outlet}}
  <SiteFooter />
</template>
