import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { Button } from '@/components/ui/button';
import { Collapsible } from '@/components/ui/collapsible';
import ChevronsUpDown from '~icons/lucide/chevrons-up-down';

export default class CollapsibleDemo extends Component {
  @tracked isOpen = false;

  setIsOpen = (open: boolean) => {
    this.isOpen = open;
  };

  <template>
    <Collapsible
      @open={{this.isOpen}}
      @onOpenChange={{this.setIsOpen}}
      class="flex w-[350px] flex-col gap-2"
      as |C|
    >
      <div class="flex items-center justify-between gap-4 px-4">
        <h4 class="text-sm font-semibold">
          @peduarte starred 3 repositories
        </h4>
        <C.Trigger @asChild={{true}} as |triggerProps|>
          <Button
            @variant="ghost"
            @size="icon"
            class="size-8"
            {{on "click" triggerProps.onClick}}
            aria-controls={{triggerProps.aria-controls}}
            aria-expanded={{triggerProps.aria-expanded}}
            data-state={{triggerProps.data-state}}
            data-disabled={{triggerProps.data-disabled}}
            disabled={{triggerProps.disabled}}
          >
            <ChevronsUpDown />
            <span class="sr-only">Toggle</span>
          </Button>
        </C.Trigger>
      </div>
      <div class="rounded-md border px-4 py-2 font-mono text-sm">
        @radix-ui/primitives
      </div>
      <C.Content class="flex flex-col gap-2">
        <div class="rounded-md border px-4 py-2 font-mono text-sm">
          @radix-ui/colors
        </div>
        <div class="rounded-md border px-4 py-2 font-mono text-sm">
          @stitches/react
        </div>
      </C.Content>
    </Collapsible>
  </template>
}
