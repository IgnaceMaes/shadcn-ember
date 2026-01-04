import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from '@/components/ui/collapsible';
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarProvider,
  SidebarTrigger,
} from '@/components/ui/sidebar';

import ChevronDown from '~icons/lucide/chevron-down';

<template>
  <SidebarProvider class="!min-h-full h-full">
    <Sidebar>
      <SidebarContent>
        <Collapsible @defaultOpen={{true}} class="group/collapsible">
          <SidebarGroup>
            <SidebarGroupLabel>
              <CollapsibleTrigger class="w-full">
                <span>Help</span>
                <ChevronDown
                  class="ml-auto transition-transform group-data-[state=open]/collapsible:rotate-180"
                />
              </CollapsibleTrigger>
            </SidebarGroupLabel>
            <CollapsibleContent>
              <SidebarGroupContent />
            </CollapsibleContent>
          </SidebarGroup>
        </Collapsible>
      </SidebarContent>
    </Sidebar>
    <main class="flex h-full flex-1 flex-col">
      <div class="flex items-center gap-2 border-b p-4">
        <SidebarTrigger />
      </div>
    </main>
  </SidebarProvider>
</template>
