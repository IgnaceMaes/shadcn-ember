import { Bubble, BubbleContent } from '@/components/ui/bubble';
import { Button } from '@/components/ui/button';
import {
  Message,
  MessageContent,
  MessageFooter,
} from '@/components/ui/message';

import CopyIcon from '~icons/lucide/copy';
import RefreshCcwIcon from '~icons/lucide/refresh-ccw';
import ThumbsDownIcon from '~icons/lucide/thumbs-down';
import ThumbsUpIcon from '~icons/lucide/thumbs-up';

<template>
  <div class="flex w-full max-w-sm flex-col gap-8 py-12">
    <Message>
      <MessageContent>
        <Bubble @variant="muted">
          <BubbleContent>
            The install failure is coming from the workspace package.
          </BubbleContent>
        </Bubble>
        <MessageFooter>
          <Button @size="icon" @variant="ghost" aria-label="Copy" title="Copy">
            <CopyIcon />
          </Button>
          <Button @size="icon" @variant="ghost" aria-label="Like" title="Like">
            <ThumbsUpIcon />
          </Button>
          <Button
            @size="icon"
            @variant="ghost"
            aria-label="Dislike"
            title="Dislike"
          >
            <ThumbsDownIcon />
          </Button>
        </MessageFooter>
      </MessageContent>
    </Message>
    <Message @align="end">
      <MessageContent>
        <Bubble>
          <BubbleContent>Okay drop me a link. Taking a look...</BubbleContent>
        </Bubble>
        <MessageFooter @class="gap-2">
          <span class="font-normal text-destructive">Failed to send</span>
          <Button
            @size="icon-sm"
            @variant="ghost"
            aria-label="Retry"
            title="Retry"
          >
            <RefreshCcwIcon />
          </Button>
        </MessageFooter>
      </MessageContent>
    </Message>
  </div>
</template>
