import { LinkTo } from '@ember/routing';
import ThemeToggle from '@/components/theme-toggle';
import {
  DocLayout,
  DocHeaderNav,
  DocSidebar,
  DocSidebarGroup,
  DocSidebarLink,
} from '@/components/docs';

<template>
  <div class="min-h-screen bg-background">
    <DocHeaderNav>
      <:logo>
        <LinkTo @route="docs" class="mr-6 flex items-center space-x-2">
          <span class="font-bold">shadcn-ember</span>
        </LinkTo>
      </:logo>
      <:nav>
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
      </:nav>
      <:actions>
        <ThemeToggle @size="sm" />
      </:actions>
    </DocHeaderNav>

    <DocLayout>
      <:sidebar>
        <DocSidebar>
          <DocSidebarGroup @title="Getting Started">
            <DocSidebarLink @route="docs">
              Introduction
            </DocSidebarLink>
          </DocSidebarGroup>
          <DocSidebarGroup @title="Components">
            <DocSidebarLink @route="docs.components.checkbox">
              Checkbox
            </DocSidebarLink>
          </DocSidebarGroup>
        </DocSidebar>
      </:sidebar>
      <:default>
        {{outlet}}
      </:default>
    </DocLayout>
  </div>
</template>
