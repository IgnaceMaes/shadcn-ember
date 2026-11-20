import { Bubble, BubbleContent, BubbleReactions } from '@/components/ui/bubble';
import { Button } from '@/components/ui/button';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';

import Info from '~icons/lucide/info';

<template>
  <div class="flex w-full max-w-sm flex-col gap-4 py-12">
    <Bubble @align="end">
      <BubbleContent>Run the build script.</BubbleContent>
    </Bubble>
    <Bubble @variant="destructive">
      <BubbleContent>Failed to run the command.</BubbleContent>
      <BubbleReactions>
        <Popover>
          <PopoverTrigger @asChild={{true}} as |trigger|>
            <Button
              @class="rounded-full aria-expanded:text-destructive"
              @size="icon-sm"
              @variant="ghost"
              aria-label="Show error details"
              {{trigger.modifiers}}
            >
              <Info />
            </Button>
          </PopoverTrigger>
          <PopoverContent>
            <div class="flex flex-col gap-1.5">
              <h4 class="text-sm font-medium leading-none">
                Command failed with exit code 1
              </h4>
              <p class="text-sm text-muted-foreground">
                ENOENT: no such file or directory, open pnpm-lock.yaml
              </p>
            </div>
          </PopoverContent>
        </Popover>
      </BubbleReactions>
    </Bubble>
  </div>
</template>
