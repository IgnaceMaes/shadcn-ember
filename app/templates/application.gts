import { pageTitle } from 'ember-page-title';
import SiteHeader from '@/components/site-header';

<template>
  {{pageTitle "The Foundation for your Design System - shadcn-ember"}}

  <SiteHeader />
  {{outlet}}
</template>
