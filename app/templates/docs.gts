import { LinkTo } from '@ember/routing';
import ThemeToggle from '@/components/theme-toggle';

<template>
  <div class="min-h-screen bg-background">
    {{! Header }}
    <header
      class="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
    >
      <div class="container flex h-14 items-center">
        <div class="mr-4 flex">
          <LinkTo @route="docs" class="mr-6 flex items-center space-x-2">
            <span class="font-bold">shadcn-ember</span>
          </LinkTo>
        </div>
        <nav class="flex flex-1 items-center space-x-6 text-sm font-medium">
          <LinkTo
            @route="docs.components.checkbox"
            class="transition-colors hover:text-foreground/80 text-foreground"
          >
            Documentation
          </LinkTo>
          <LinkTo
            @route="kitchensink"
            class="transition-colors hover:text-foreground/80 text-foreground/60"
          >
            Kitchen Sink
          </LinkTo>
        </nav>
        <div class="flex items-center space-x-2">
          <ThemeToggle @size="sm" />
        </div>
      </div>
    </header>

    <div class="container flex-1">
      <div
        class="flex-1 md:grid md:grid-cols-[220px_1fr] md:gap-6 lg:grid-cols-[240px_1fr] lg:gap-10"
      >
        {{! Sidebar }}
        <aside
          class="fixed top-14 z-30 hidden h-[calc(100vh-3.5rem)] w-full shrink-0 overflow-y-auto border-r py-6 pr-2 md:sticky md:block lg:py-8"
        >
          <div class="space-y-4">
            <div>
              <h4
                class="mb-1 rounded-md px-2 py-1 text-sm font-semibold"
              >Getting Started</h4>
              <div class="grid grid-flow-row auto-rows-max text-sm">
                <LinkTo
                  @route="docs"
                  class="group flex w-full items-center rounded-md border border-transparent px-2 py-1 hover:underline text-muted-foreground"
                >
                  Introduction
                </LinkTo>
              </div>
            </div>
            <div>
              <h4
                class="mb-1 rounded-md px-2 py-1 text-sm font-semibold"
              >Components</h4>
              <div class="grid grid-flow-row auto-rows-max text-sm">
                <LinkTo
                  @route="docs.components.checkbox"
                  class="group flex w-full items-center rounded-md border border-transparent px-2 py-1 hover:underline"
                >
                  Checkbox
                </LinkTo>
              </div>
            </div>
          </div>
        </aside>

        {{! Main content }}
        <main class="relative py-6 lg:gap-10 lg:py-8">
          {{outlet}}
        </main>
      </div>
    </div>
  </div>
</template>
