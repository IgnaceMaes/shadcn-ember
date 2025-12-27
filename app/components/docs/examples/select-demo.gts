import {
  Select,
  SelectGroup,
  SelectLabel,
} from '@/components/ui/select';

<template>
  <Select as |s|>
    <s.Trigger @class="w-[180px]">
      <s.Value @placeholder="Select a fruit" />
    </s.Trigger>
    <s.Content as |c|>
      <SelectGroup>
        <SelectLabel>Fruits</SelectLabel>
        <c.Item @value="apple">Apple</c.Item>
        <c.Item @value="banana">Banana</c.Item>
        <c.Item @value="blueberry">Blueberry</c.Item>
        <c.Item @value="grapes">Grapes</c.Item>
        <c.Item @value="pineapple">Pineapple</c.Item>
      </SelectGroup>
    </s.Content>
  </Select>
</template>
