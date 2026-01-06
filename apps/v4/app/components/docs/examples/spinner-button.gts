import { Button } from '@/components/ui/button';
import { Spinner } from '@/components/ui/spinner';

<template>
  <div class="flex flex-col items-center gap-4">
    <Button @disabled={{true}} @size="sm">
      <Spinner />
      Loading...
    </Button>
    <Button @disabled={{true}} @size="sm" @variant="outline">
      <Spinner />
      Please wait
    </Button>
    <Button @disabled={{true}} @size="sm" @variant="secondary">
      <Spinner />
      Processing
    </Button>
  </div>
</template>
