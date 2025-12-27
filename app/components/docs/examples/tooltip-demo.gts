import { Button } from '@/components/ui/button';
import { Tooltip } from '@/components/ui/tooltip';

<template>
  <Tooltip as |t|>
    <t.Trigger>
      <Button @variant="outline">Hover</Button>
    </t.Trigger>
    <t.Content>
      <p>Add to library</p>
    </t.Content>
  </Tooltip>
</template>
