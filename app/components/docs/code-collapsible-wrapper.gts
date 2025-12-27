import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import { Collapsible } from '@/components/ui/collapsible';
import { Separator } from '@/components/ui/separator';

interface Signature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class CodeCollapsibleWrapper extends Component<Signature> {
  @tracked isOpened = false;

  onOpenChange = (open: boolean) => {
    this.isOpened = open;
  };

  <template>
    <Collapsible
      @open={{this.isOpened}}
      @onOpenChange={{this.onOpenChange}}
      class={{cn "group/collapsible relative md:-mx-1" @class}}
      ...attributes
      as |C|
    >
      <C.Trigger @asChild={{true}} as |triggerProps|>
        <div class="absolute top-5 right-9 z-10 flex items-center">
          <Button
            @variant="ghost"
            @size="sm"
            @class="text-muted-foreground h-7 rounded-md px-2"
            {{on "click" triggerProps.onClick}}
            aria-controls={{triggerProps.aria-controls}}
            aria-expanded={{triggerProps.aria-expanded}}
            data-state={{triggerProps.data-state}}
            data-slot={{triggerProps.data-slot}}
            data-disabled={{triggerProps.data-disabled}}
            disabled={{triggerProps.disabled}}
          >
            {{if this.isOpened "Collapse" "Expand"}}
          </Button>
          <Separator @orientation="vertical" @class="mx-1.5 h-4!" />
        </div>
      </C.Trigger>
      <C.Content
        @forceMount={{true}}
        @class="relative mt-6 overflow-hidden data-[state=closed]:max-h-64 data-[state=closed]:after:pointer-events-none data-[state=closed]:after:absolute data-[state=closed]:after:inset-x-0 data-[state=closed]:after:bottom-0 data-[state=closed]:after:h-32 data-[state=closed]:after:bg-linear-to-t data-[state=closed]:after:from-code/80 data-[state=closed]:after:to-transparent [&>figure]:mt-0 [&>figure]:md:mx-0!"
      >
        {{yield}}
      </C.Content>
      <C.Trigger
        @class="from-code/70 to-code text-muted-foreground absolute inset-x-0 -bottom-2 flex h-22 items-center justify-center rounded-b-lg bg-gradient-to-b text-sm group-data-[state=open]/collapsible:hidden"
      >
        {{if this.isOpened "Collapse" "Expand"}}
      </C.Trigger>
    </Collapsible>
  </template>
}
