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
- Create template-only components where possible (no backing class if no local state or methods are needed)
- Closely follow the shadcn-ember component signatures. Even when there are splattibutes available for e.g. `class`, make sure to use the explicit `@class` argument when available so the classes are merged correctly.

## General

- Do not write a summary at the end (e.g. in markdown file)
- Lint fix via `pnpm lint:fix`
- Format fix via `pnpm format`

## Template tag strict imports

```gts
// Built-in helpers
import { array } from '@ember/helper';
import { concat } from '@ember/helper';
import { fn } from '@ember/helper';
import { get } from '@ember/helper';
import { hash } from '@ember/helper';
import { uniqueId } from '@ember/helper';

// Built-in modifiers
import { on } from '@ember/modifier';

// Built-in components
import { LinkTo } from '@ember/routing';
```

## When porting shadcn/ui components to Ember

- No unnecessary code comments in ui component source files
- Use only named exports in ui component source files (no default exports) and do a single export at the bottom of the file
- When needing to pass context from a root ui component to a related sub-component: yield the subcomponent to link them together.
- When typing components in a yield, use `ComponentLike<ExampleSignature>` from `import type { ComponentLike } from '@glint/template';`
