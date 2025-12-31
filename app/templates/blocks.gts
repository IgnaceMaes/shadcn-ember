import DocLinkTo from '@/components/docs/doc-link-to';

// Icons
import ArrowRight from '~icons/lucide/arrow-right';

// UI Components
import { Button } from '@/components/ui/button';

<template>
  <div class="min-h-screen bg-background">
    <main>
      {{! Hero Section }}
      <section class="relative">
        <div class="container relative px-4 mx-auto">
          <div
            class="container flex flex-col items-center gap-2 py-8 text-center md:py-16 lg:py-20 xl:gap-4"
          >
            <DocLinkTo @route="docs.changelog">
              <Button
                @class="rounded-full border border-transparent px-2 py-0.5 h-auto text-xs font-medium gap-1 hover:bg-secondary/90 bg-transparent [&>svg]:size-3"
                @variant="ghost"
              >
                <span
                  class="flex size-2 rounded-full bg-[#E04E39]"
                  title="New"
                ></span>
                shadcn/ui for Ember.js
                <ArrowRight />
              </Button>
            </DocLinkTo>
            <h1
              class="text-primary leading-tighter text-4xl font-semibold tracking-tight text-balance lg:leading-[1.1] lg:font-semibold xl:text-5xl xl:tracking-tight max-w-4xl"
            >
              Building Blocks for the Web
            </h1>
            <p
              class="text-foreground max-w-3xl text-base text-balance sm:text-lg"
            >
              Clean, modern building blocks. Copy and paste into your apps.
              Works with all Ember frameworks. Open Source. Free forever.
            </p>
            <div class="flex flex-wrap items-center justify-center gap-4 pt-4">
              <Button disabled={{true}}>
                Browse Blocks
              </Button>
              <Button @variant="ghost" disabled={{true}}>
                Add a block
              </Button>
            </div>
          </div>
        </div>
      </section>

      {{! Placeholder }}
      <section class="container mx-auto px-4 py-12">
        <div class="text-center">
          <p class="text-muted-foreground text-sm">
            Under development. Contributions welcome.
          </p>
        </div>
      </section>
    </main>
  </div>
</template>
