import { Button } from '@/components/ui/button';
import {
  ButtonGroup,
  ButtonGroupSeparator,
} from '@/components/ui/button-group';

<template>
  <ButtonGroup>
    <Button @size="sm" @variant="secondary">
      Copy
    </Button>
    <ButtonGroupSeparator />
    <Button @size="sm" @variant="secondary">
      Paste
    </Button>
  </ButtonGroup>
</template>
