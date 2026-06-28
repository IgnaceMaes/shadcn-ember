import { array } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';

export default class ShimmerOnce extends Component {
  @tracked playCount = 0;

  replay = () => {
    this.playCount = this.playCount + 1;
  };

  <template>
    <div class="flex flex-col items-center gap-4">
      {{! Each item's identity is the play count, so bumping it tears down and }}
      {{! recreates the paragraph, replaying the single sweep from the start. }}
      {{#each (array this.playCount) as |key|}}
        <p
          class="shimmer text-sm text-muted-foreground shimmer-duration-1100 shimmer-once"
          data-play={{key}}
        >
          Generating response…
        </p>
      {{/each}}
      <Button @size="sm" @variant="outline" {{on "click" this.replay}}>
        Replay
      </Button>
    </div>
  </template>
}
