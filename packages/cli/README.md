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

## Aknowledgements

This is a fork of `shadcn-vue` CLI, adapted for Ember.

## License

Licensed under the [MIT license](https://github.com/IgnaceMaes/shadcn-ember/blob/main/LICENSE).
