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
