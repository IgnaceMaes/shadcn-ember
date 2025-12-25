import { LinkTo } from '@ember/routing';

<template>
  <div class="mx-auto w-full min-w-0 max-w-4xl">
    <div class="mb-4 flex items-center space-x-1 text-sm text-muted-foreground">
      <div class="overflow-hidden text-ellipsis whitespace-nowrap">Docs</div>
    </div>
    <div class="space-y-2">
      <h1
        class="scroll-m-20 text-4xl font-bold tracking-tight"
      >Introduction</h1>
      <p class="text-lg text-muted-foreground">
        Re-usable components built with Ember.js and Tailwind CSS.
      </p>
    </div>
    <div class="pb-12 pt-8">
      <div class="prose prose-slate dark:prose-invert max-w-none">
        <p>
          This is a collection of re-usable components that you can use in your
          Ember.js applications. All components are built with modern Ember
          patterns (Glimmer components, template tag format) and styled with
          Tailwind CSS.
        </p>

        <h2>Components</h2>
        <p>
          Browse through the available components in the sidebar. Each component
          page includes:
        </p>
        <ul>
          <li>Live, interactive examples</li>
          <li>Complete code snippets</li>
          <li>API documentation</li>
          <li>Accessibility information</li>
        </ul>

        <h2>Getting Started</h2>
        <p>
          All components are located in
          <code>app/components/ui/</code>
          and can be imported directly:
        </p>
        <pre><code>import Checkbox from '@/components/ui/checkbox';</code></pre>

        <h2>Start Exploring</h2>
        <p>
          Check out the
          <LinkTo
            @route="docs.components.checkbox"
            class="font-medium underline underline-offset-4"
          >Checkbox</LinkTo>
          component to see a complete example.
        </p>
      </div>
    </div>
  </div>
</template>
