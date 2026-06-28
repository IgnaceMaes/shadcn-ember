import { Bubble, BubbleContent, BubbleReactions } from '@/components/ui/bubble';
import { Button } from '@/components/ui/button';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';

import Check from '~icons/lucide/check';

<template>
  <div class="flex w-full max-w-sm flex-col gap-4 py-12">
    <Bubble @variant="secondary">
      <BubbleContent>Did you remove the stale route?</BubbleContent>
    </Bubble>
    <Bubble @align="end">
      <BubbleContent>Yes, removed it from the registry.</BubbleContent>
      <BubbleReactions @class="p-0">
        <Tooltip>
          <TooltipTrigger @asChild={{true}}>
            <Button @class="rounded-full" @size="icon-sm" @variant="ghost">
              <Check />
            </Button>
          </TooltipTrigger>
          <TooltipContent>Read on Jan 5, 2026 at 4:32 PM</TooltipContent>
        </Tooltip>
      </BubbleReactions>
    </Bubble>
  </div>
</template>
