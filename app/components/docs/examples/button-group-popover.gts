import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import { Popover } from '@/components/ui/popover';
import { Separator } from '@/components/ui/separator';
import { Textarea } from '@/components/ui/textarea';
import BotIcon from '~icons/lucide/bot';
import ChevronDownIcon from '~icons/lucide/chevron-down';

<template>
  <ButtonGroup>
    <Button @variant="outline" @size="sm">
      <BotIcon />
      Copilot
    </Button>
    <Popover as |popover|>
      <popover.Trigger @asChild={{true}}>
        <Button @variant="outline" @size="icon-sm" aria-label="Open Popover">
          <ChevronDownIcon />
        </Button>
      </popover.Trigger>
      <popover.Content @align="end" @class="rounded-xl p-0 text-sm">
        <div class="px-4 py-3">
          <div class="text-sm font-medium">Agent Tasks</div>
        </div>
        <Separator />
        <div class="p-4 text-sm *:[p:not(:last-child)]:mb-2">
          <Textarea
            placeholder="Describe your task in natural language."
            class="mb-4 resize-none"
          />
          <p class="font-medium">Start a new task with Copilot</p>
          <p class="text-muted-foreground">
            Describe your task in natural language. Copilot will work in the
            background and open a pull request for your review.
          </p>
        </div>
      </popover.Content>
    </Popover>
  </ButtonGroup>
</template>
