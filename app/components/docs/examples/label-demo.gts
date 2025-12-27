import { Checkbox } from '@/components/ui/checkbox';
import { Label } from '@/components/ui/label';

<template>
  <div class="flex items-center gap-3">
    <Checkbox id="terms" />
    <Label @for="terms">Accept terms and conditions</Label>
  </div>
</template>
