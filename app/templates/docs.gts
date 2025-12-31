import {
  DocLayout,
  DocSidebar,
  DocSidebarGroup,
  DocSidebarLink,
} from '@/components/docs';
import { docsSidebar } from '@/lib/docs-navigation';

<template>
  <div class="min-h-screen bg-background">

    <DocLayout>
      <:sidebar>
        <DocSidebar>
          {{#each docsSidebar as |section|}}
            <DocSidebarGroup @listClass="gap-1" @title={{section.title}}>
              {{#each section.items as |item|}}
                {{#if item.href}}
                  <DocSidebarLink @href={{item.href}}>
                    {{item.title}}
                  </DocSidebarLink>
                {{else}}
                  <DocSidebarLink @route={{item.route}}>
                    {{item.title}}
                  </DocSidebarLink>
                {{/if}}
              {{/each}}
            </DocSidebarGroup>
          {{/each}}
        </DocSidebar>
      </:sidebar>
      <:default>
        {{outlet}}
      </:default>
    </DocLayout>
  </div>
</template>
