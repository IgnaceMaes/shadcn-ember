import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';
import {
  Collapsible,
  CollapsibleTrigger,
  CollapsibleContent,
} from '@/components/ui/collapsible';
import { Separator } from '@/components/ui/separator';
import { cn } from '@/lib/utils';

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
      @onOpenChange={{this.onOpenChange}}
      @open={{this.isOpened}}
      class={{cn "group/collapsible relative md:-mx-1" @class}}
      ...attributes
    >
      <CollapsibleTrigger @asChild={{true}} as |triggerProps|>
        <div class="absolute top-5 right-9 z-10 flex items-center">
          <Button
            @class="text-muted-foreground h-7 rounded-md px-2"
            @size="sm"
            @variant="ghost"
            aria-controls={{triggerProps.aria-controls}}
            aria-expanded={{triggerProps.aria-expanded}}
            data-disabled={{triggerProps.data-disabled}}
            data-slot={{triggerProps.data-slot}}
            data-state={{triggerProps.data-state}}
            disabled={{triggerProps.disabled}}
            {{on "click" triggerProps.onClick}}
          >
            {{if this.isOpened "Collapse" "Expand"}}
          </Button>
          <Separator @class="mx-1.5 h-4!" @orientation="vertical" />
        </div>
      </CollapsibleTrigger>
      <CollapsibleContent
        @class="relative mt-6 overflow-hidden data-[state=closed]:max-h-64 data-[state=closed]:after:pointer-events-none data-[state=closed]:after:absolute data-[state=closed]:after:inset-x-0 data-[state=closed]:after:bottom-0 data-[state=closed]:after:h-32 data-[state=closed]:after:bg-linear-to-t data-[state=closed]:after:from-code/80 data-[state=closed]:after:to-transparent [&>figure]:mt-0 [&>figure]:md:mx-0!"
        @forceMount={{true}}
      >
        {{yield}}
      </CollapsibleContent>
      <CollapsibleTrigger
        @class="from-code/70 to-code text-muted-foreground absolute inset-x-0 -bottom-2 flex h-22 items-center justify-center rounded-b-lg bg-gradient-to-b text-sm group-data-[state=open]/collapsible:hidden"
      >
        {{if this.isOpened "Collapse" "Expand"}}
      </CollapsibleTrigger>
    </Collapsible>
  </template>
}
