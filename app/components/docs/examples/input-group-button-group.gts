import Link2 from '~icons/lucide/link-2';
import { ButtonGroup, ButtonGroupText } from '@/components/ui/button-group';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
} from '@/components/ui/input-group';
import { Label } from '@/components/ui/label';

<template>
  <div class="grid w-full max-w-sm gap-6">
    <ButtonGroup>
      <ButtonGroupText>
        <Label for="url">https://</Label>
      </ButtonGroupText>
      <InputGroup>
        <InputGroupInput id="url" />
        <InputGroupAddon @align="inline-end">
          <Link2 />
        </InputGroupAddon>
      </InputGroup>
      <ButtonGroupText>.com</ButtonGroupText>
    </ButtonGroup>
  </div>
</template>
