---
title: Native Select
description: A styled native HTML select element with consistent design system integration.
---

> [!INFO]
> For a styled select component, see the [Select](/docs/components/select) component.

<ComponentPreview name="native-select-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add native-select
```

### Manual

**Copy and paste the native-select component into your project:**

<ComponentSource name="native-select" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  NativeSelect,
  NativeSelectOptGroup,
  NativeSelectOption,
} from '@/components/ui/native-select';
```

```hbs showLineNumbers
<NativeSelect>
  <NativeSelectOption value="">Select a fruit</NativeSelectOption>
  <NativeSelectOption value="apple">Apple</NativeSelectOption>
  <NativeSelectOption value="banana">Banana</NativeSelectOption>
  <NativeSelectOption value="blueberry">Blueberry</NativeSelectOption>
  <NativeSelectOption value="grapes" disabled>Grapes</NativeSelectOption>
  <NativeSelectOption value="pineapple">Pineapple</NativeSelectOption>
</NativeSelect>
```

## Examples

### With Groups

Organize options using `NativeSelectOptGroup` for better categorization.

<ComponentPreview name="native-select-groups" />

```hbs showLineNumbers
<NativeSelect>
  <NativeSelectOption value="">Select a food</NativeSelectOption>
  <NativeSelectOptGroup label="Fruits">
    <NativeSelectOption value="apple">Apple</NativeSelectOption>
    <NativeSelectOption value="banana">Banana</NativeSelectOption>
    <NativeSelectOption value="blueberry">Blueberry</NativeSelectOption>
  </NativeSelectOptGroup>
  <NativeSelectOptGroup label="Vegetables">
    <NativeSelectOption value="carrot">Carrot</NativeSelectOption>
    <NativeSelectOption value="broccoli">Broccoli</NativeSelectOption>
    <NativeSelectOption value="spinach">Spinach</NativeSelectOption>
  </NativeSelectOptGroup>
</NativeSelect>
```

### Disabled State

Disable individual options or the entire select component.

<ComponentPreview name="native-select-disabled" />

### Invalid State

Show validation errors with the `aria-invalid` attribute and error styling.

<ComponentPreview name="native-select-invalid" />

```hbs showLineNumbers
<NativeSelect aria-invalid="true">
  <NativeSelectOption value="">Select a country</NativeSelectOption>
  <NativeSelectOption value="us">United States</NativeSelectOption>
  <NativeSelectOption value="uk">United Kingdom</NativeSelectOption>
  <NativeSelectOption value="ca">Canada</NativeSelectOption>
</NativeSelect>
```

### Form Integration

Use with form libraries like Ember Data or ember-changeset for controlled components.

<ComponentPreview name="native-select-form" />

### Input Group Integration

Combine with `InputGroup` for complex input layouts.

<ComponentPreview name="native-select-input-group" />

## Native Select vs Select

- Use `NativeSelect` when you need native browser behavior, better performance, or mobile-optimized dropdowns.
- Use `Select` when you need custom styling, animations, or complex interactions.

The `NativeSelect` component provides native HTML select functionality with consistent styling that matches your design system.

## Accessibility

- The component maintains all native HTML select accessibility features.
- Screen readers can navigate through options using arrow keys.
- The chevron icon is marked as `aria-hidden="true"` to avoid duplication.
- Use `aria-label` or `aria-labelledby` for additional context when needed.

```hbs showLineNumbers
<NativeSelect aria-label="Choose your preferred language">
  <NativeSelectOption value="en">English</NativeSelectOption>
  <NativeSelectOption value="es">Spanish</NativeSelectOption>
  <NativeSelectOption value="fr">French</NativeSelectOption>
</NativeSelect>
```

## API Reference

### NativeSelect

The main select component that wraps the native HTML select element.

| Prop     | Type                | Default     |
| -------- | ------------------- | ----------- |
| `@class` | `string`            |             |
| `@size`  | `'sm' \| 'default'` | `'default'` |

All other props are passed through to the underlying `<select>` element via `...attributes`.

```hbs
<NativeSelect>
  <NativeSelectOption value="option1">Option 1</NativeSelectOption>
  <NativeSelectOption value="option2">Option 2</NativeSelectOption>
</NativeSelect>
```

### NativeSelectOption

Represents an individual option within the select.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

All other props (including `value` and `disabled`) are passed through to the underlying `<option>` element via `...attributes`.

```hbs
<NativeSelectOption value="apple">Apple</NativeSelectOption>
<NativeSelectOption value="banana" disabled>Banana</NativeSelectOption>
```

### NativeSelectOptGroup

Groups related options together for better organization.

| Prop     | Type     | Default |
| -------- | -------- | ------- |
| `@class` | `string` |         |

All other props (including `label` and `disabled`) are passed through to the underlying `<optgroup>` element via `...attributes`.

```hbs
<NativeSelectOptGroup label="Fruits">
  <NativeSelectOption value="apple">Apple</NativeSelectOption>
  <NativeSelectOption value="banana">Banana</NativeSelectOption>
</NativeSelectOptGroup>
```
