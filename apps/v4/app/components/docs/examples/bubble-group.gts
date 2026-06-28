import {
  Bubble,
  BubbleContent,
  BubbleGroup,
  BubbleReactions,
} from '@/components/ui/bubble';

<template>
  <div class="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble @variant="muted">
      <BubbleContent>Can you tell me what's the issue?</BubbleContent>
    </Bubble>
    <BubbleGroup>
      <Bubble @align="end">
        <BubbleContent>You tell me!</BubbleContent>
      </Bubble>
      <Bubble @align="end">
        <BubbleContent>It worked yesterday. You broke it!</BubbleContent>
      </Bubble>
      <Bubble @align="end">
        <BubbleContent>Find the bug and fix it.</BubbleContent>
        <BubbleReactions @align="start" aria-label="Reactions: eyes">
          <span>👀</span>
        </BubbleReactions>
      </Bubble>
    </BubbleGroup>
    <Bubble @variant="muted">
      <BubbleContent>
        Want me to diff yesterday's you against today's you? It's a bit
        embarrassing.
      </BubbleContent>
    </Bubble>
  </div>
</template>
