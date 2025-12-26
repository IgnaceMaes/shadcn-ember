import Button from '@/components/ui/button';
import ArrowUpRightIcon from '~icons/lucide/arrow-up-right';

<template>
  <div class="flex flex-col gap-8">
    <Button @variant="outline" @size="icon" @class="rounded-full">
      <ArrowUpRightIcon />
    </Button>
  </div>
</template>
