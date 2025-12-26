import Button from '@/components/ui/button';
import Spinner from '@/components/ui/spinner';

<template>
  <Button @size="sm" @variant="outline" @disabled={{true}}>
    <Spinner />
    Submit
  </Button>
</template>
