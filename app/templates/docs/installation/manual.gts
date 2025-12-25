import {
  DocPage,
  DocHeader,
  DocContent,
  DocParagraph,
  DocStrong,
} from '@/components/docs';
import CodeBlockThemed from '@/components/docs/code-block-themed';

<template>
  <DocPage as |page|>
    <DocHeader
      @title="Manual Installation"
      @description="Add dependencies to your project manually."
    />

    <DocContent>
      <page.Heading>Add Tailwind CSS</page.Heading>

      <DocParagraph>
        Components are styled using Tailwind CSS. You need to install Tailwind
        CSS in your project.
      </DocParagraph>

      <DocParagraph>
        Follow the <a class="font-medium underline underline-offset-4" href="https://tailwindcss.com/docs/installation" target="_blank" rel="noopener noreferrer">Tailwind CSS installation instructions</a> to get started.
      </DocParagraph>

      <page.Heading>Add dependencies</page.Heading>

      <DocParagraph>
        Add the following dependencies to your project:
      </DocParagraph>

      <CodeBlockThemed
        @language="bash"
        @code="npm install class-variance-authority clsx tailwind-merge"
      />

      <page.Heading>Configure path aliases</page.Heading>

      <DocParagraph>
        Configure the path aliases in your
        <DocStrong>tsconfig.json</DocStrong>
        file.
      </DocParagraph>

      <CodeBlockThemed
        @language="json"
        @code='{
  "compilerOptions": {
    "paths": {
      "@/*": ["./app/*"]
    }
  }
}'
      />

      <DocParagraph>
        The
        <DocStrong>@</DocStrong>
        alias is a preference. You can use other aliases if you want.
      </DocParagraph>

      <page.Heading>Configure styles</page.Heading>

      <DocParagraph>
        Add the following to your
        <DocStrong>app/app.css</DocStrong>
        file. You can learn more about using CSS variables for theming in the
        theming section.
      </DocParagraph>

      <CodeBlockThemed
        @language="css"
        @code='@import "tailwindcss";

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
}'
      />

      <page.Heading>Add a cn helper</page.Heading>

      <CodeBlockThemed
        @language="typescript"
        @code="import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}"
      />

      <page.Heading>Configure icons</page.Heading>

      <DocParagraph>
        Ember uses
        <DocStrong>unplugin-icons</DocStrong>
        for icon support. Install the dependencies:
      </DocParagraph>

      <CodeBlockThemed
        @language="bash"
        @code="npm install --save-dev unplugin-icons @iconify-json/lucide"
      />

      <DocParagraph>
        Add the plugin to your
        <DocStrong>vite.config.mjs</DocStrong>:
      </DocParagraph>

      <CodeBlockThemed
        @language="javascript"
        @code="import Icons from 'unplugin-icons/vite';

export default defineConfig({
  plugins: [
    // ... other plugins
    Icons({
      compiler: 'glimmer',
    }),
  ],
});"
      />

      <DocParagraph>
        Import icons like this:
      </DocParagraph>

      <CodeBlockThemed
        @language="typescript"
        @code="import Check from '~icons/lucide/check';"
      />

      <page.Heading>Create a components.json file</page.Heading>

      <DocParagraph>
        Create a
        <DocStrong>components.json</DocStrong>
        file in the root of your project.
      </DocParagraph>

      <CodeBlockThemed
        @language="json"
        @code='{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york",
  "typescript": true,
  "tailwind": {
    "config": "",
    "css": "app/app.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib"
  },
  "iconLibrary": "lucide"
}'
      />

      <page.Heading>That's it</page.Heading>

      <DocParagraph>
        You can now start adding components to your project.
      </DocParagraph>
    </DocContent>
  </DocPage>
</template>
