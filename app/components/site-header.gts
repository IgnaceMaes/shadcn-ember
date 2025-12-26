import DocLinkTo from '@/components/docs/doc-link-to';
import PhNotches from 'ember-phosphor-icons/components/ph-notches';
import Github from '~icons/lucide/github';
import Button from '@/components/ui/button';
import Separator from '@/components/ui/separator';
import ThemeToggle from '@/components/theme-toggle';

<template>
  <header class="bg-background sticky top-0 z-50 w-full">
    <div class="container-wrapper px-6">
      <div class="flex h-14 items-center">
        <Button @variant="ghost" @size="icon" class="size-8">
          <DocLinkTo @route="index">
            <PhNotches class="size-5" @weight="bold" />
            <span class="sr-only">shadcn-ember</span>
          </DocLinkTo>
        </Button>
        <nav class="hidden lg:flex items-center gap-4 text-sm ml-4">
          <DocLinkTo
            @route="docs"
            class="transition-colors hover:text-foreground/80 text-foreground/60"
          >
            Docs
          </DocLinkTo>
          <DocLinkTo
            @route="docs.components"
            class="transition-colors hover:text-foreground/80 text-foreground/60"
          >
            Components
          </DocLinkTo>
        </nav>
        <div class="ml-auto flex items-center gap-2 md:flex-1 md:justify-end">
          <Separator @orientation="vertical" class="ml-2 hidden lg:block" />
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
          <Separator @orientation="vertical" />
          <ThemeToggle />
        </div>
      </div>
    </div>
  </header>
</template>
