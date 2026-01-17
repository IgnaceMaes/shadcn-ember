---
title: Button Group
description: A container that groups related buttons together with consistent styling.
---

<ComponentPreview name="button-group-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add button-group
```

### Manual

**Copy and paste the button-group component into your project:**

<ComponentSource name="button-group" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  ButtonGroup,
  ButtonGroupSeparator,
  ButtonGroupText,
} from '@/components/ui/button-group';
```

```hbs showLineNumbers
<ButtonGroup>
  <Button>Button 1</Button>
  <Button>Button 2</Button>
</ButtonGroup>
```

## Accessibility

- The `ButtonGroup` component has the `role` attribute set to `group`.
- Use <kbd>Tab</kbd> to navigate between the buttons in the group.
- Use `aria-label` or `aria-labelledby` to label the button group.

```hbs showLineNumbers
<ButtonGroup aria-label="Button group">
  <Button>Button 1</Button>
  <Button>Button 2</Button>
</ButtonGroup>
```

## ButtonGroup vs ToggleGroup

- Use the `ButtonGroup` component when you want to group buttons that perform an action.
- Use the `ToggleGroup` component when you want to group buttons that toggle a state.

## Examples

### Orientation

Set the `@orientation` argument to change the button group layout.

<ComponentPreview name="button-group-orientation" />

### Size

Control the size of buttons using the `@size` argument on individual buttons.

<ComponentPreview name="button-group-size" />

### Nested

Nest `<ButtonGroup>` components to create button groups with spacing.

<ComponentPreview name="button-group-nested" />

### Separator

The `ButtonGroupSeparator` component visually divides buttons within a group.

Buttons with variant `outline` do not need a separator since they have a border. For other variants, a separator is recommended to improve the visual hierarchy.

<ComponentPreview name="button-group-separator" />

### Split

Create a split button group by adding two buttons separated by a `ButtonGroupSeparator`.

<ComponentPreview name="button-group-split" />

### Input

Wrap an `Input` component with buttons.

<ComponentPreview name="button-group-input" />

### Input Group

Wrap an `InputGroup` component to create complex input layouts.

<ComponentPreview name="button-group-input-group" />

### Dropdown Menu

Create a split button group with a `DropdownMenu` component.

<ComponentPreview name="button-group-dropdown" />

### Select

Pair with a `Select` component.

<ComponentPreview name="button-group-select" />

### Popover

Use with a `Popover` component.

<ComponentPreview name="button-group-popover" />

## API Reference

### ButtonGroup

The `ButtonGroup` component is a container that groups related buttons together with consistent styling.

| Prop           | Type                         | Default        |
| -------------- | ---------------------------- | -------------- |
| `@orientation` | `"horizontal" \| "vertical"` | `"horizontal"` |

```hbs showLineNumbers
<ButtonGroup>
  <Button>Button 1</Button>
  <Button>Button 2</Button>
</ButtonGroup>
```

Nest multiple button groups to create complex layouts with spacing. See the [nested](#nested) example for more details.

```hbs showLineNumbers
<ButtonGroup>
  <ButtonGroup />
  <ButtonGroup />
</ButtonGroup>
```

### ButtonGroupSeparator

The `ButtonGroupSeparator` component visually divides buttons within a group.

| Prop           | Type                         | Default      |
| -------------- | ---------------------------- | ------------ |
| `@orientation` | `"horizontal" \| "vertical"` | `"vertical"` |

```hbs showLineNumbers
<ButtonGroup>
  <Button>Button 1</Button>
  <ButtonGroupSeparator />
  <Button>Button 2</Button>
</ButtonGroup>
```

### ButtonGroupText

Use this component to display text within a button group.

| Prop       | Type      | Default |
| ---------- | --------- | ------- |
| `@asChild` | `boolean` | `false` |

```hbs showLineNumbers
<ButtonGroup>
  <ButtonGroupText>Text</ButtonGroupText>
  <Button>Button</Button>
</ButtonGroup>
```

Use the `@asChild` argument to render a custom component as the text, for example a label.

```gts showLineNumbers
import { ButtonGroupText } from '@/components/ui/button-group';
import { Label } from '@/components/ui/label';

export default class ButtonGroupTextDemo extends Component {
  <template>
    <ButtonGroup>
      <ButtonGroupText @asChild={{true}}>
        <Label @for="name">Text</Label>
      </ButtonGroupText>
      <Input placeholder="Type something here..." id="name" />
    </ButtonGroup>
  </template>
}
```
