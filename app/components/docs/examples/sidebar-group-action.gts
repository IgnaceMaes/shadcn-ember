import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupAction,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarProvider,
  SidebarTrigger,
} from '@/components/ui/sidebar';

import Plus from '~icons/lucide/plus';

<template>
  <SidebarProvider class="!min-h-full h-full">
    <Sidebar>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Projects</SidebarGroupLabel>
          <SidebarGroupAction title="Add Project">
            <Plus />
            <span class="sr-only">Add Project</span>
          </SidebarGroupAction>
          <SidebarGroupContent />
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
    <main class="flex h-full flex-1 flex-col">
      <div class="flex items-center gap-2 border-b p-4">
        <SidebarTrigger />
      </div>
    </main>
  </SidebarProvider>
</template>
