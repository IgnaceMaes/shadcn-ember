import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import MinusIcon from '~icons/lucide/minus';
import PlusIcon from '~icons/lucide/plus';

<template>
  <ButtonGroup
    @orientation="vertical"
    aria-label="Media controls"
    class="h-fit"
  >
    <Button @variant="outline" @size="icon">
      <PlusIcon />
    </Button>
    <Button @variant="outline" @size="icon">
      <MinusIcon />
    </Button>
  </ButtonGroup>
</template>
