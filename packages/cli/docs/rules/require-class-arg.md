# shadcn-ember/require-class-arg

Require using `@class` instead of `class` on shadcn-ember component invocations.

## Rule Details

When using shadcn-ember components, passing `class` as a regular HTML attribute will forward it via `...attributes` (splattributes). This bypasses the component's internal class merging logic using `cn()` / `cva()`, leading to unexpected styling behavior where your classes don't get properly merged with the component's variant classes.

This rule enforces using `@class` (a named argument) on known shadcn-ember components so the component can merge your classes correctly. It only flags shadcn-ember components (e.g. `Button`, `Card`, `Input`, `Badge`, etc.) — custom components and HTML elements are not affected.

## Examples

### Incorrect

```gjs
<Button class="w-full" />
```

```gjs
<Card class="my-4">
  content
</Card>
```

```gjs
<Badge class="extra" @variant="destructive">text</Badge>
```

### Correct

```gjs
<Button @class="w-full" />
```

```gjs
<Card @class="my-4">
  content
</Card>
```

```gjs
<Badge @class="extra" @variant="destructive">text</Badge>
```

Using `class` on regular HTML elements or non-shadcn components is fine and will not be flagged:

```gjs
<div class="my-class"></div>
<button class="btn">click</button>
<MyCustomComponent class="custom" />
```

## When Not To Use It

If you are not using shadcn-ember components in your project.

## Fixable

This rule is auto-fixable. Running `eslint --fix` will replace `class` with `@class` on shadcn-ember component invocations.
