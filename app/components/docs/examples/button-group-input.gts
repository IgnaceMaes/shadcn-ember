import Button from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import Input from '@/components/ui/input';
import SearchIcon from '~icons/lucide/search';

<template>
  <ButtonGroup>
    <Input placeholder="Search..." />
    <Button @variant="outline" aria-label="Search">
      <SearchIcon />
    </Button>
  </ButtonGroup>
</template>
