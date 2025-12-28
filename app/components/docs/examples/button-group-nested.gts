import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import ArrowLeftIcon from '~icons/lucide/arrow-left';
import ArrowRightIcon from '~icons/lucide/arrow-right';

<template>
  <ButtonGroup>
    <ButtonGroup>
      <Button @variant="outline" @size="sm">
        1
      </Button>
      <Button @variant="outline" @size="sm">
        2
      </Button>
      <Button @variant="outline" @size="sm">
        3
      </Button>
    </ButtonGroup>
    <ButtonGroup>
      <Button @variant="outline" @size="icon-sm" aria-label="Previous">
        <ArrowLeftIcon />
      </Button>
      <Button @variant="outline" @size="icon-sm" aria-label="Next">
        <ArrowRightIcon />
      </Button>
    </ButtonGroup>
  </ButtonGroup>
</template>
