import { LinkTo } from '@ember/routing';
import Button from '@/components/ui/button';

<template>
  <Button @asChild={{true}}>
    <LinkTo @route="index">Login</LinkTo>
  </Button>
</template>
