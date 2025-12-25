# shadcn-ember

An Ember port of shadcn/ui. The goal is to provide an identical set of components and patterns as shadcn/ui, but translated for Ember applications.

## Conventions

Use modern Ember (Polaris edition) conventions:

- Vite as build system
- TypeScript as language
- Template tag components (gts files)
  - Both as components, as well for route templates, as in tests
- Tailwind CSS for styling
- Use `@tracked` and getters for reactivity (no classic Ember objects, @computed, etc)
- Use arrow functions over @action within components
- Use Lucide icons via imports e.g. `import Check from '~icons/lucide/check';` (all icons are available)
- Make sure all helpers/modifiers/components are imported via `import X from '...'` at the top of the gts file (no global usage)
- Do not install new Ember dependencies without approval. Keep it vanilla Ember as much as possible.

## General

- Do not write a summary at the end (e.g. in markdown file)
- Lint fix via `pnpm lint:fix`
- Format fix via `pnpm format`
