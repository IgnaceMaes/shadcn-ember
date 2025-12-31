import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Copy from '~icons/lucide/copy';
import Check from '~icons/lucide/check';
import { Button } from '@/components/ui/button';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';
import { cn } from '@/lib/utils';

interface CopyCodeButtonSignature {
  Args: {
    class?: string;
    variant?:
      | 'default'
      | 'destructive'
      | 'outline'
      | 'secondary'
      | 'ghost'
      | 'link';
    size?: 'default' | 'sm' | 'lg' | 'icon' | 'icon-sm' | 'icon-lg';
  };
}

class CopyCodeButton extends Component<CopyCodeButtonSignature> {
  @tracked hasCopied = false;

  copyToClipboard = () => {
    const themeCode = `// Add theme configuration code here`;
    void navigator.clipboard.writeText(themeCode);
    this.hasCopied = true;
    setTimeout(() => {
      this.hasCopied = false;
    }, 2000);
  };

  <template>
    <Tooltip>
      <TooltipTrigger>
        <Button
          @class={{cn "size-7" @class}}
          @size={{if @size @size "icon"}}
          @variant={{if @variant @variant "ghost"}}
          {{on "click" this.copyToClipboard}}
        >
          <span class="sr-only">Copy theme code</span>
          {{#if this.hasCopied}}
            <Check />
          {{else}}
            <Copy />
          {{/if}}
        </Button>
      </TooltipTrigger>
      <TooltipContent>
        {{#if this.hasCopied}}
          Copied!
        {{else}}
          Copy theme code
        {{/if}}
      </TooltipContent>
    </Tooltip>
  </template>
}

export { CopyCodeButton };
