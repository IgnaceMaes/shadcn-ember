import { LinkTo } from '@ember/routing';
import Button from '@/components/ui/button';

<template>
  <Button @asChild={{true}} as |classes|>
    <LinkTo @route="index" class={{classes}}>Login</LinkTo>
  </Button>
</template>
