import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Copy from '~icons/lucide/copy';
import Check from '~icons/lucide/check';
import { Button } from '@/components/ui/button';
import { Tooltip } from '@/components/ui/tooltip';
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
    <Tooltip as |t|>
      <t.Trigger>
        <Button
          @variant={{if @variant @variant "ghost"}}
          @size={{if @size @size "icon"}}
          @class={{cn "size-7" @class}}
          {{on "click" this.copyToClipboard}}
        >
          <span class="sr-only">Copy theme code</span>
          {{#if this.hasCopied}}
            <Check />
          {{else}}
            <Copy />
          {{/if}}
        </Button>
      </t.Trigger>
      <t.Content>
        {{#if this.hasCopied}}
          Copied!
        {{else}}
          Copy theme code
        {{/if}}
      </t.Content>
    </Tooltip>
  </template>
}

export { CopyCodeButton };
