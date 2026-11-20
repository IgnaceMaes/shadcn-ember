import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Bubble, BubbleContent, BubbleGroup } from '@/components/ui/bubble';

import type ToastService from '@/services/toast';

export default class BubbleLinkButtonDemo extends Component {
  @service declare toast: ToastService;

  forgotPassword = () => {
    this.toast.add({ message: 'You clicked forgot password' });
  };

  helpSubscription = () => {
    this.toast.add({ message: 'You clicked help with subscription' });
  };

  somethingElse = () => {
    this.toast.add({ message: 'You clicked something else. Talk to a human.' });
  };

  <template>
    <div class="flex w-full max-w-sm flex-col gap-8 py-12">
      <Bubble @variant="muted">
        <BubbleContent>How can I help you today?</BubbleContent>
      </Bubble>
      <BubbleGroup>
        <Bubble @align="end" @variant="tinted">
          <BubbleContent @asChild={{true}} as |content|>
            <button
              class={{content.classes}}
              data-slot="bubble-content"
              type="button"
              {{on "click" this.forgotPassword}}
            >
              I forgot my password
            </button>
          </BubbleContent>
        </Bubble>
        <Bubble @align="end" @variant="tinted">
          <BubbleContent @asChild={{true}} as |content|>
            <button
              class={{content.classes}}
              data-slot="bubble-content"
              type="button"
              {{on "click" this.helpSubscription}}
            >
              I need help with my subscription
            </button>
          </BubbleContent>
        </Bubble>
        <Bubble @align="end" @variant="tinted">
          <BubbleContent @asChild={{true}} as |content|>
            <button
              class={{content.classes}}
              data-slot="bubble-content"
              type="button"
              {{on "click" this.somethingElse}}
            >
              Something else. Talk to a human.
            </button>
          </BubbleContent>
        </Bubble>
      </BubbleGroup>
    </div>
  </template>
}
