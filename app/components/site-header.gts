import { LinkTo } from '@ember/routing';
import PhNotches from 'ember-phosphor-icons/components/ph-notches';
import Github from '~icons/lucide/github';
import Button from '@/components/ui/button';
import ThemeToggle from '@/components/theme-toggle';

<template>
  <header
    class="sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
  >
    <div
      class="container flex h-14 max-w-screen-2xl items-center px-4 mx-auto"
    >
      <div class="mr-4 flex">
        <a href="/" class="mr-4 flex items-center gap-2 lg:mr-6">
          <PhNotches class="size-5" @weight="bold" />
        </a>
        <nav class="flex items-center gap-4 text-sm xl:gap-6">
          <LinkTo
            @route="docs"
            class="transition-colors hover:text-foreground/80 text-foreground/60"
          >
            Docs
          </LinkTo>
          <LinkTo
            @route="docs.components"
            class="transition-colors hover:text-foreground/80 text-foreground/60"
          >
            Components
          </LinkTo>
        </nav>
      </div>
      <div class="flex flex-1 items-center justify-end gap-2">
        <div class="flex items-center gap-2">
          <a
            href="https://github.com/IgnaceMaes/shadcn-ember"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Button @variant="ghost" @size="icon">
              <Github class="h-4 w-4" />
              <span class="sr-only">GitHub</span>
            </Button>
          </a>
          <ThemeToggle @variant="outline" />
        </div>
      </div>
    </div>
  </header>
</template>
