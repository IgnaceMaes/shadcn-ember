import PhNotches from 'ember-phosphor-icons/components/ph-notches';

import CommandMenu from '@/components/command-menu';
import DocLinkTo from '@/components/docs/doc-link-to';
import ThemeToggle from '@/components/theme-toggle';
import { Button } from '@/components/ui/button';
import { Kbd } from '@/components/ui/kbd';
import { Separator } from '@/components/ui/separator';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';

import Github from '~icons/simple-icons/github';

<template>
  <header class="bg-background sticky top-0 z-50 w-full">
    <div class="container-wrapper 3xl:fixed:px-0 px-6">
      <div
        class="3xl:fixed:container flex h-(--header-height) items-center **:data-[slot=separator]:!h-4"
      >
        <DocLinkTo @route="index" class="flex">
          <Button @size="icon" @variant="ghost" class="size-8">
            <PhNotches @weight="bold" class="text-[#E04E39]" />
            <span class="sr-only">shadcn-ember</span>
          </Button>
        </DocLinkTo>
        <nav class="hidden items-center gap-0 lg:flex">
          <DocLinkTo
            @route="docs"
            class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50 h-8 rounded-md gap-1.5 has-[>svg]:px-2.5 px-2.5 relative"
          >
            Docs
          </DocLinkTo>
          <DocLinkTo
            @route="docs.components"
            class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50 h-8 rounded-md gap-1.5 has-[>svg]:px-2.5 px-2.5 relative"
          >
            Components
          </DocLinkTo>
          <DocLinkTo
            @route="blocks"
            class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50 h-8 rounded-md gap-1.5 has-[>svg]:px-2.5 px-2.5 relative"
          >
            Blocks
          </DocLinkTo>
        </nav>
        <div class="ml-auto flex items-center gap-2 md:flex-1 md:justify-end">
          <div class="hidden w-full flex-1 md:flex md:w-auto md:flex-none">
            <CommandMenu />
          </div>
          <Separator @orientation="vertical" class="ml-2 hidden lg:block" />
          <Button
            @asChild={{true}}
            @size="sm"
            @variant="ghost"
            class="h-8 gap-1.5 rounded-md px-3 has-[>svg]:px-2.5 shadow-none"
            as |button|
          >
            <a
              class={{button.classes}}
              href="https://github.com/IgnaceMaes/shadcn-ember"
              rel="noopener noreferrer"
              target="_blank"
            >
              <Github class="h-4 w-4" />
              <span class="text-muted-foreground w-fit text-xs tabular-nums">
                0.02K
              </span>
            </a>
          </Button>
          <Separator @orientation="vertical" />
          <Tooltip>
            <TooltipTrigger>
              <ThemeToggle />
            </TooltipTrigger>
            <TooltipContent
              @class="top-full mt-2 bottom-auto mb-0 whitespace-nowrap"
              @side="bottom"
            >
              Toggle theme
              <Kbd
                @class="bg-background/20 text-background dark:bg-background/10"
              >D</Kbd>
            </TooltipContent>
          </Tooltip>
        </div>
      </div>
    </div>
  </header>
</template>
