---
title: Astro
description: Install and configure shadcn-ember for Astro
---

## Create project

Start by creating a new Astro project with Tailwind CSS:

```bash
pnpm create astro@latest astro-app --template with-tailwindcss --install --git
```

## Install Ember integration

Install `ember-astro` and Ember:

```bash
pnpm add ember-astro ember-source
```

## Configure Astro

Add the Ember integration to your `astro.config.*`:

```typescript title="astro.config.mjs" {3,8} showLineNumbers
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";
import { ember } from "ember-astro";

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [ember(), tailwindcss()],
  },
});

```

## Configure icons

shadcn-ember uses `unplugin-icons` for icon support. Install the dependencies:

```bash
pnpm add -D unplugin-icons @iconify-json/lucide
```

Add the plugin to your `astro.config.mjs`:

```typescript title="astro.config.mjs" {4,9} showLineNumbers
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";
import { ember } from "ember-astro";
import Icons from "unplugin-icons/vite";

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [ember(), tailwindcss(), Icons({ compiler: "astro" })],
  },
});

```

Import icons like this:

```typescript
import Check from '~icons/lucide/check';
```

## Edit tsconfig.json file

Add the following code to the `tsconfig.json` file to resolve paths:

```json title="tsconfig.json" {4-9} showLineNumbers
{
  "compilerOptions": {
    // ...
    "baseUrl": ".",
    "paths": {
      "@/*": [
        "./src/*"
      ]
    }
    // ...
  }
}
```

## Add Tailwind CSS theme

Create or update your `src/styles/global.css` file with the shadcn-ember theme variables:

```css title="src/styles/global.css"
@import 'tailwindcss';

@custom-variant dark (&:is(.dark *));

:root {
  --background: oklch(1 0 0);
  --foreground: oklch(0.145 0 0);
  --card: oklch(1 0 0);
  --card-foreground: oklch(0.145 0 0);
  --popover: oklch(1 0 0);
  --popover-foreground: oklch(0.145 0 0);
  --primary: oklch(0.205 0 0);
  --primary-foreground: oklch(0.985 0 0);
  --secondary: oklch(0.97 0 0);
  --secondary-foreground: oklch(0.205 0 0);
  --muted: oklch(0.97 0 0);
  --muted-foreground: oklch(0.556 0 0);
  --accent: oklch(0.97 0 0);
  --accent-foreground: oklch(0.205 0 0);
  --destructive: oklch(0.577 0.245 27.325);
  --destructive-foreground: oklch(0.577 0.245 27.325);
  --border: oklch(0.922 0 0);
  --input: oklch(0.922 0 0);
  --ring: oklch(0.708 0 0);
  --chart-1: oklch(0.646 0.222 41.116);
  --chart-2: oklch(0.6 0.118 184.704);
  --chart-3: oklch(0.398 0.07 227.392);
  --chart-4: oklch(0.828 0.189 84.429);
  --chart-5: oklch(0.769 0.188 70.08);
  --radius: 0.625rem;
}

.dark {
  --background: oklch(0.145 0 0);
  --foreground: oklch(0.985 0 0);
  --card: oklch(0.145 0 0);
  --card-foreground: oklch(0.985 0 0);
  --popover: oklch(0.145 0 0);
  --popover-foreground: oklch(0.985 0 0);
  --primary: oklch(0.985 0 0);
  --primary-foreground: oklch(0.205 0 0);
  --secondary: oklch(0.269 0 0);
  --secondary-foreground: oklch(0.985 0 0);
  --muted: oklch(0.269 0 0);
  --muted-foreground: oklch(0.708 0 0);
  --accent: oklch(0.269 0 0);
  --accent-foreground: oklch(0.985 0 0);
  --destructive: oklch(0.396 0.141 25.723);
  --destructive-foreground: oklch(0.637 0.237 25.331);
  --border: oklch(0.269 0 0);
  --input: oklch(0.269 0 0);
  --ring: oklch(0.439 0 0);
  --chart-1: oklch(0.488 0.243 264.376);
  --chart-2: oklch(0.696 0.17 162.48);
  --chart-3: oklch(0.769 0.188 70.08);
  --chart-4: oklch(0.627 0.265 303.9);
  --chart-5: oklch(0.645 0.246 16.439);
}

@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-card: var(--card);
  --color-card-foreground: var(--card-foreground);
  --color-popover: var(--popover);
  --color-popover-foreground: var(--popover-foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-destructive: var(--destructive);
  --color-destructive-foreground: var(--destructive-foreground);
  --color-border: var(--border);
  --color-input: var(--input);
  --color-ring: var(--ring);
  --color-chart-1: var(--chart-1);
  --color-chart-2: var(--chart-2);
  --color-chart-3: var(--chart-3);
  --color-chart-4: var(--chart-4);
  --color-chart-5: var(--chart-5);
  --radius-sm: calc(var(--radius) - 4px);
  --radius-md: calc(var(--radius) - 2px);
  --radius-lg: var(--radius);
  --radius-xl: calc(var(--radius) + 4px);
}

@layer base {
  * {
    @apply border-border outline-ring/50;
  }
  body {
    @apply bg-background text-foreground;
  }
}
```

Import the CSS in your main layout:

```astro title="src/layouts/Layout.astro" {2} showLineNumbers
---
import '../styles/global.css';
---
```

## Configure Tailwind

Update your `tailwind.config.mjs` to include the component paths:

```typescript title="tailwind.config.mjs" showLineNumbers
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue,gts,gjs}'],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

## Add components

You can now add shadcn-ember components to your project. Create a `src/components/ui` directory and copy the component files you need.

For example, to add the Button component, see the [Button documentation](/docs/components/button) for the full source code and copy it to `src/components/ui/button.gts`.

## Usage

Use the component in your Astro pages with `client:only="ember"`:

```astro title="src/pages/index.astro" {2,7} showLineNumbers
---
import { Button } from '@/components/ui/button.gts';
---

<html lang="en">
  <body>
    <Button client:only="ember">Click me</Button>
  </body>
</html>
```

## Important notes

### Props vs Args

In Astro files, all properties are passed as props (without `@`), but Ember components receive them as arguments (with `@`). When using components from Astro:

```astro
<Button variant="outline" client:only="ember">
  Click me
</Button>
```

The Ember component receives `@props.variant` instead of `@variant`. You may need to adapt components for Astro usage.

### Slots

Astro slots are rendered as HTML strings. In Ember components invoked from Astro, use `{{{@slots.default}}}` (triple braces) instead of `{{yield}}`.

### Limitations

For complex interactive Ember features, consider importing a parent Ember component and building your UI within that component using standard Ember patterns.
