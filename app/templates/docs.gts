import { LinkTo } from '@ember/routing';
import {
  DocLayout,
  DocSidebar,
  DocSidebarGroup,
  DocSidebarLink,
} from '@/components/docs';

<template>
  <div class="min-h-screen bg-background">

    <DocLayout>
      <:sidebar>
        <DocSidebar>
          <DocSidebarGroup @title="Sections">
            <DocSidebarLink @route="docs">
              Get Started
            </DocSidebarLink>
            <DocSidebarLink @route="docs.components">
              Components
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
