import { Button } from '@/components/ui/button';
import { Spinner } from '@/components/ui/spinner';

<template>
  <Button @disabled={{true}} @size="sm" @variant="outline">
    <Spinner />
    Submit
  </Button>
</template>
