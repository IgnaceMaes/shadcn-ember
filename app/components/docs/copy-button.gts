import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Check from '~icons/lucide/check';
import Copy from '~icons/lucide/copy';
import { Button } from '@/components/ui/button';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';
import { cn } from '@/lib/utils';

interface CopyButtonSignature {
  Args: {
    value: string;
    class?: string;
    variant?:
      | 'default'
      | 'destructive'
      | 'outline'
      | 'secondary'
      | 'ghost'
      | 'link';
    tooltip?: string;
  };
}

export default class CopyButton extends Component<CopyButtonSignature> {
  @tracked hasCopied = false;

  copyToClipboard = () => {
    void navigator.clipboard.writeText(this.args.value);
    this.hasCopied = true;
    setTimeout(() => {
      this.hasCopied = false;
    }, 2000);
  };

  <template>
    <Tooltip>
      <TooltipTrigger @class={{cn "absolute top-3 right-3 z-10" @class}}>
        <Button
          data-slot="copy-button"
          data-copied={{this.hasCopied}}
          @variant={{if @variant @variant "ghost"}}
          @class="size-7 hover:opacity-100 focus-visible:opacity-100 bg-code"
          {{on "click" this.copyToClipboard}}
        >
          <span class="sr-only">Copy</span>
          {{#if this.hasCopied}}
            <Check />
          {{else}}
            <Copy />
          {{/if}}
        </Button>
      </TooltipTrigger>
      <TooltipContent>
        {{#if this.hasCopied}}
          Copied
        {{else}}
          {{if @tooltip @tooltip "Copy to Clipboard"}}
        {{/if}}
      </TooltipContent>
    </Tooltip>
  </template>
}
