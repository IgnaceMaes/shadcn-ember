import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Bubble, BubbleContent, BubbleReactions } from '@/components/ui/bubble';
import { Button } from '@/components/ui/button';

import type ToastService from '@/services/toast';

export default class BubbleReactionsDemo extends Component {
  @service declare toast: ToastService;

  runCommand = () => {
    this.toast.success('You clicked yes, running command...');
  };

  <template>
    <div class="flex w-full max-w-sm flex-col gap-12 py-12">
      <Bubble @align="end" @variant="muted">
        <BubbleContent>
          I don't need tests, I know my code works.
        </BubbleContent>
        <BubbleReactions
          @align="start"
          aria-label="Reactions: thumbs up, surprised"
          role="img"
        >
          <span>👍</span>
          <span>😮</span>
        </BubbleReactions>
      </Bubble>
      <Bubble @variant="muted">
        <BubbleContent>
          Bold. Fine I'll add some tests. I'll let you know when they're done.
        </BubbleContent>
        <BubbleReactions
          aria-label="Reactions: eyes, rocket, and 2 more"
          role="img"
        >
          <span>👀</span>
          <span>🚀</span>
          <span>+2</span>
        </BubbleReactions>
      </Bubble>
      <Bubble @align="end" @variant="default">
        <BubbleContent>
          Tests passed on the first try. All 142 of them. Looking good!
        </BubbleContent>
        <BubbleReactions
          @align="start"
          @side="top"
          aria-label="Reactions: party popper, clapping hands"
          role="img"
        >
          <span>🎉</span>
          <span>👏</span>
        </BubbleReactions>
      </Bubble>
      <Bubble @variant="destructive">
        <BubbleContent>Are you sure I can run this command?</BubbleContent>
        <BubbleReactions>
          <Button @size="sm" @variant="ghost" {{on "click" this.runCommand}}>
            Yes, run it
          </Button>
        </BubbleReactions>
      </Bubble>
    </div>
  </template>
}
