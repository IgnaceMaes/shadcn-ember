# require-as-child-props

Requires applying yielded properties when using `@asChild` on shadcn-ember components.

Some components yield the properties needed to make the custom child behave like the original component. For example, triggers yield modifiers and polymorphic visual components yield class names. When those yielded values are not applied to the child, styling or behavior can silently break.

## Incorrect

```hbs
<Button @asChild={{true}} as |button|>
  <LinkTo @route="index">Login</LinkTo>
</Button>

<DropdownMenuTrigger @asChild={{true}} as |trigger|>
  <Button>Open</Button>
</DropdownMenuTrigger>
```

## Correct

```hbs
<Button @asChild={{true}} as |button|>
  <LinkTo @route="index" class={{button.classes}}>Login</LinkTo>
</Button>

<DropdownMenuTrigger @asChild={{true}} as |trigger|>
  <Button>
    Open
    {{trigger.modifiers}}
  </Button>
</DropdownMenuTrigger>
```
