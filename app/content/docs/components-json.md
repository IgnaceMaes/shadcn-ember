---
title: components.json
description: Configuration for your project.
order: 21
---

The `components.json` file holds configuration for your project.

We use it to understand how your project is set up and how to generate components customized for your project.

> [!NOTE]
> The `components.json` file is optional and **only required if you're using the CLI** to add components to your project. If you're using the copy and paste method, you don't need this file.
>
> Currently, shadcn-ember does not have a CLI tool. This file is included for future compatibility and reference.

## $schema

You can see the JSON Schema for `components.json` at [/schema.json](https://shadcn-ember.com/schema.json).

```json
{
  "$schema": "https://shadcn-ember.com/schema.json"
}
```

## style

The style for your components. **This cannot be changed after initialization.**

```json
{
  "style": "default"
}
```

Currently, only the `default` style is available for shadcn-ember.

## typescript

Whether to use TypeScript for components.

```json
{
  "typescript": true
}
```

shadcn-ember components are built with TypeScript using `.gts` template tag format.

## tailwind

Configuration to help the CLI understand how Tailwind CSS is set up in your project.

See the [installation section](/docs/installation) for how to set up Tailwind CSS.

### tailwind.config

Path to where your Tailwind CSS config file is located. **For Tailwind CSS v4, leave this blank.**

```json
{
  "tailwind": {
    "config": ""
  }
}
```

shadcn-ember uses Tailwind CSS v4, which doesn't require a separate config file.

### tailwind.css

Path to the CSS file that imports Tailwind CSS into your project.

```json
{
  "tailwind": {
    "css": "app/app.css"
  }
}
```

### tailwind.baseColor

This is used to generate the default color palette for your components. **This cannot be changed after initialization.**

```json
{
  "tailwind": {
    "baseColor": "gray" | "neutral" | "slate" | "stone" | "zinc"
  }
}
```

### tailwind.cssVariables

You can choose between using CSS variables or Tailwind CSS utility classes for theming.

To use utility classes for theming set `tailwind.cssVariables` to `false`. For CSS variables, set `tailwind.cssVariables` to `true`.

```json
{
  "tailwind": {
    "cssVariables": true
  }
}
```

For more information, see the [theming docs](/docs/theming).

**This cannot be changed after initialization.** To switch between CSS variables and utility classes, you'll have to delete and re-install your components.

### tailwind.prefix

The prefix to use for your Tailwind CSS utility classes. Components will be added with this prefix.

```json
{
  "tailwind": {
    "prefix": ""
  }
}
```

## iconLibrary

The icon library used by components.

```json
{
  "iconLibrary": "lucide"
}
```

shadcn-ember uses Lucide icons via the unplugin-icons package. Icons are imported as components:

```gts
import Check from '~icons/lucide/check';
```

## aliases

The CLI uses these values and the `paths` config from your `tsconfig.json` file to place generated components in the correct location.

Path aliases have to be set up in your `tsconfig.json` file.

### aliases.utils

Import alias for your utility functions.

```json
{
  "aliases": {
    "utils": "@/lib/utils"
  }
}
```

### aliases.components

Import alias for your components.

```json
{
  "aliases": {
    "components": "@/components"
  }
}
```

### aliases.ui

Import alias for `ui` components.

The CLI will use the `aliases.ui` value to determine where to place your `ui` components. Use this config if you want to customize the installation directory for your `ui` components.

```json
{
  "aliases": {
    "ui": "@/components/ui"
  }
}
```

### aliases.lib

Import alias for `lib` functions such as `cn`.

```json
{
  "aliases": {
    "lib": "@/lib"
  }
}
```

## registries

Configure multiple resource registries for your project. This allows you to install components from various sources including private registries.

### Basic Configuration

Configure registries with URL templates:

```json
{
  "registries": {
    "@custom": "https://registry.example.com/{name}.json"
  }
}
```

The `{name}` placeholder is replaced with the resource name when installing.
