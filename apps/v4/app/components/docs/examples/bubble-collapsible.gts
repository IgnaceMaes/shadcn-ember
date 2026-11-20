import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Bubble, BubbleContent } from '@/components/ui/bubble';
import { Button } from '@/components/ui/button';
import { Collapsible, CollapsibleTrigger } from '@/components/ui/collapsible';

import ChevronDown from '~icons/lucide/chevron-down';

const text = `The accessibility review found two focus states that were visually too subtle in dark mode.
I checked the dialog, menu, and drawer paths because each one renders focusable controls inside a layered surface.
The dialog and drawer are fine. The menu needs the hover and focus tokens split so keyboard focus stays visible when the pointer is not involved.
I also recommend keeping the change in the style file instead of the primitive so the other themes can choose their own focus treatment later.`;
const previewLength = 180;

export default class BubbleCollapsible extends Component {
  @tracked open = false;

  isLong = text.length > previewLength;
  preview = `${text.slice(0, previewLength)}...`;

  setOpen = (open: boolean) => {
    this.open = open;
  };

  get displayText() {
    return this.open || !this.isLong ? text : this.preview;
  }

  <template>
    <div class="flex w-full max-w-sm flex-col gap-8 py-12">
      <Bubble @variant="muted">
        <BubbleContent>How can I help you today?</BubbleContent>
      </Bubble>
      <Bubble @align="end" @variant="muted">
        <BubbleContent>
          <Collapsible @onOpenChange={{this.setOpen}} @open={{this.open}}>
            <div class="whitespace-pre-line">{{this.displayText}}</div>
            {{#if this.isLong}}
              <CollapsibleTrigger @asChild={{true}} as |trigger|>
                <Button
                  @class="gap-1 p-0 text-muted-foreground"
                  @variant="link"
                  aria-controls={{trigger.aria-controls}}
                  aria-expanded={{trigger.aria-expanded}}
                  data-disabled={{trigger.data-disabled}}
                  data-slot={{trigger.data-slot}}
                  data-state={{trigger.data-state}}
                  disabled={{trigger.disabled}}
                  {{on "click" trigger.onClick}}
                >
                  {{if this.open "Show less" "Show more"}}
                  <ChevronDown
                    class={{if this.open "rotate-180" ""}}
                    data-icon="inline-end"
                  />
                </Button>
              </CollapsibleTrigger>
            {{/if}}
          </Collapsible>
        </BubbleContent>
      </Bubble>
    </div>
  </template>
}
