import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { Button } from '@/components/ui/button';
import {
  Collapsible,
  CollapsibleTrigger,
  CollapsibleContent,
} from '@/components/ui/collapsible';
import ChevronsUpDown from '~icons/lucide/chevrons-up-down';

export default class CollapsibleDemo extends Component {
  @tracked isOpen = false;

  setIsOpen = (open: boolean) => {
    this.isOpen = open;
  };

  <template>
    <Collapsible
      @onOpenChange={{this.setIsOpen}}
      @open={{this.isOpen}}
      class="flex w-[350px] flex-col gap-2"
    >
      <div class="flex items-center justify-between gap-4 px-4">
        <h4 class="text-sm font-semibold">
          @peduarte starred 3 repositories
        </h4>
        <CollapsibleTrigger @asChild={{true}} as |triggerProps|>
          <Button
            @size="icon"
            @variant="ghost"
            aria-controls={{triggerProps.aria-controls}}
            aria-expanded={{triggerProps.aria-expanded}}
            class="size-8"
            data-disabled={{triggerProps.data-disabled}}
            data-state={{triggerProps.data-state}}
            disabled={{triggerProps.disabled}}
            {{on "click" triggerProps.onClick}}
          >
            <ChevronsUpDown />
            <span class="sr-only">Toggle</span>
          </Button>
        </CollapsibleTrigger>
      </div>
      <div class="rounded-md border px-4 py-2 font-mono text-sm">
        @radix-ui/primitives
      </div>
      <CollapsibleContent class="flex flex-col gap-2">
        <div class="rounded-md border px-4 py-2 font-mono text-sm">
          @radix-ui/colors
        </div>
        <div class="rounded-md border px-4 py-2 font-mono text-sm">
          @stitches/react
        </div>
      </CollapsibleContent>
    </Collapsible>
  </template>
}
