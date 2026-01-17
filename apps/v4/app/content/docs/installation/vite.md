---
title: Vite
description: Install and configure shadcn-ember for Vite using the CLI.
---

## Create project

Start by creating a new Ember project using the official blueprint:

```bash
npx ember-cli@latest new my-app --typescript
```

## Add Tailwind CSS

Install Tailwind CSS v4:

```bash
npm install tailwindcss @tailwindcss/vite
```

Create a `app/app.css` file with the following content:

```css title="app/app.css"
@import 'tailwindcss';
```

Import the CSS file in `app/app.ts`:

```typescript title="app/app.ts" showLineNumbers
import './app.css';
```

## Edit tsconfig.json file

Add the `paths` property to the `compilerOptions` section of the `tsconfig.json` file:

```json title="tsconfig.json" {3-5} showLineNumbers
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./app/*"]
    }
  }
}
```

The `@` alias is a preference. You can use other aliases if you want.

## Update vite.config.mjs

Add the Tailwind CSS plugin and path aliases to your `vite.config.mjs`:

```typescript title="vite.config.mjs"
import path from 'path';
import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    classicEmberSupport(),
    ember(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './app'),
    },
  },
});
```

## Run the CLI

Run the `shadcn-ember` init command to setup your project:

```bash
npx shadcn-ember@latest init
```

You will be asked a few questions to configure `components.json`:

```txt
Which style would you like to use? › New York
Which color would you like to use as base color? › Neutral
Do you want to use CSS variables for colors? › yes
```

## Add Components

You can now start adding components to your project:

```bash
npx shadcn-ember@latest add button
```

The command above will add the `Button` component to your project. You can then import it like this:

```gts title="app/components/example.gts"
import { Button } from '@/components/ui/button';

<template>
  <div class="flex min-h-svh flex-col items-center justify-center">
    <Button>Click me</Button>
  </div>
</template>
```
