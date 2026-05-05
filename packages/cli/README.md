# shadcn-ember

A CLI for adding components to your Ember.js project.

## Usage

Use the `init` command to initialize dependencies for a new project.

The `init` command installs dependencies, adds the `cn` util, configures `tailwind.config.js`, and CSS variables for the project.

```bash
npx shadcn-ember init
```

## add

Use the `add` command to add components to your project.

The `add` command adds a component to your project and installs all required dependencies.

```bash
npx shadcn-ember add [component]
```

### Example

```bash
npx shadcn-ember add alert-dialog
```

You can also run the command without any arguments to view a list of all available components:

```bash
npx shadcn-ember add
```

## Documentation

Visit http://shadcn-ember.com to view the documentation.

## ESLint Plugin

This package includes an ESLint plugin with rules specific to shadcn-ember components.

### Setup

Make sure you have `ember-eslint-parser` installed, then add the recommended config to your `eslint.config.mjs`:

```js
import shadcnEmber from 'shadcn-ember/eslint';

export default [
  ...shadcnEmber.configs.recommended,
  // your other config...
];
```

### Rules

| Rule | Description | Fixable |
| --- | --- | --- |
| [require-class-arg](docs/rules/require-class-arg.md) | Require `@class` instead of `class` on component invocations | 🔧 |

## Aknowledgements

This is a fork of `shadcn-vue` CLI, adapted for Ember.

## License

Licensed under the [MIT license](https://github.com/IgnaceMaes/shadcn-ember/blob/main/LICENSE).
