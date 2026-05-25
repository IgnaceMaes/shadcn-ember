import { Button } from '@/components/ui/button';
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from '@/components/ui/drawer';

const DRAWER_SIDES = ['top', 'right', 'bottom', 'left'] as const;
const paragraphs = Array.from({ length: 10 });

<template>
  <div class="flex flex-wrap gap-2">
    {{#each DRAWER_SIDES as |side|}}
      <Drawer @direction={{side}}>
        <DrawerTrigger @asChild={{true}}>
          <Button @class="capitalize" @variant="outline">{{side}}</Button>
        </DrawerTrigger>
        <DrawerContent
          @class="data-[vaul-drawer-direction=bottom]:max-h-[50vh] data-[vaul-drawer-direction=top]:max-h-[50vh]"
        >
          <DrawerHeader>
            <DrawerTitle>Move Goal</DrawerTitle>
            <DrawerDescription>
              Set your daily activity goal.
            </DrawerDescription>
          </DrawerHeader>
          <div class="no-scrollbar overflow-y-auto px-4">
            {{#each paragraphs}}
              <p class="mb-4 leading-normal">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do
                eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
                enim ad minim veniam, quis nostrud exercitation ullamco laboris
                nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                in reprehenderit in voluptate velit esse cillum dolore eu fugiat
                nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                sunt in culpa qui officia deserunt mollit anim id est laborum.
              </p>
            {{/each}}
          </div>
          <DrawerFooter>
            <Button>Submit</Button>
            <DrawerClose @asChild={{true}}>
              <Button @variant="outline">Cancel</Button>
            </DrawerClose>
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    {{/each}}
  </div>
</template>
