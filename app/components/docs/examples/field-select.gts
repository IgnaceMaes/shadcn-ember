import { Field, FieldDescription, FieldLabel } from '@/components/ui/field';
import { Select } from '@/components/ui/select';

<template>
  <div class="w-full max-w-md">
    <Field>
      <FieldLabel>Department</FieldLabel>
      <Select as |s|>
        <s.Trigger>
          <s.Value @placeholder="Choose department" />
        </s.Trigger>
        <s.Content as |c|>
          <c.Item @value="engineering">Engineering</c.Item>
          <c.Item @value="design">Design</c.Item>
          <c.Item @value="marketing">Marketing</c.Item>
          <c.Item @value="sales">Sales</c.Item>
          <c.Item @value="support">Customer Support</c.Item>
          <c.Item @value="hr">Human Resources</c.Item>
          <c.Item @value="finance">Finance</c.Item>
          <c.Item @value="operations">Operations</c.Item>
        </s.Content>
      </Select>
      <FieldDescription>
        Select your department or area of work.
      </FieldDescription>
    </Field>
  </div>
</template>
