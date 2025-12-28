import { Checkbox } from '@/components/ui/checkbox';
import { Field, FieldLabel } from '@/components/ui/field';

<template>
  <FieldLabel for="checkbox-demo">
    <Field @orientation="horizontal">
      <Checkbox id="checkbox-demo" @checked={{true}} />
      <FieldLabel for="checkbox-demo" @class="line-clamp-1">
        I agree to the terms and conditions
      </FieldLabel>
    </Field>
  </FieldLabel>
</template>
