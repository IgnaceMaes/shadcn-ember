---
title: ESLint Plugin
description: Lint your Ember project for common shadcn-ember mistakes.
order: 23
---

shadcn-ember ships an ESLint plugin with rules that catch common mistakes when using shadcn-ember components.

## Installation

Install the plugin:

```bash
npm install -D shadcn-ember
```

## Configuration

Add the recommended config to your `eslint.config.mjs`:

```js title="eslint.config.mjs"
import { configs as shadcnEmberConfigs } from 'shadcn-ember/eslint';

export default [
  // ...your other config
  ...shadcnEmberConfigs.recommended,
];
```

If you are using `typescript-eslint`'s `config()` helper, spread it inside the call:

```js title="eslint.config.mjs"
import ts from 'typescript-eslint';
import { configs as shadcnEmberConfigs } from 'shadcn-ember/eslint';

export default ts.config(
  // ...your other config
  ...shadcnEmberConfigs.recommended,
);
```

## Rules

### `shadcn-ember/require-class-arg`

Severity: **error**  
Fixable: auto-fixable with `eslint --fix`

Enforces using `@class` instead of `class` on shadcn-ember component invocations.

When you pass `class` as a regular HTML attribute, it gets forwarded via `...attributes` (splattributes) and bypasses the component's internal class merging logic using `cn()` / `cva()`. This can lead to unexpected styling where your classes don't get properly merged with the component's variant classes.

Using `@class` ensures the component merges your classes correctly.

#### Examples

Incorrect:

```hbs
<Button class="w-full" />
<Card class="my-4">content</Card>
<Badge class="extra" @variant="destructive">text</Badge>
```

Correct:

```hbs
<Button @class="w-full" />
<Card @class="my-4">content</Card>
<Badge @class="extra" @variant="destructive">text</Badge>
```

Using `class` on regular HTML elements or non-shadcn components is fine and will not be flagged:

```hbs
<div class="my-class"></div>
<button class="btn">click</button>
<MyCustomComponent class="custom" />
```
