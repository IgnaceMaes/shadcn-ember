import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Copy from '~icons/lucide/copy';
import Check from '~icons/lucide/check';
import ChevronDown from '~icons/lucide/chevron-down';
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
} from '@/components/ui/dropdown-menu';
import Separator from '@/components/ui/separator';
import { cn } from '@/lib/utils';

interface DocHeaderCopySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    markdown?: string;
  };
}

export default class DocHeaderCopy extends Component<DocHeaderCopySignature> {
  @tracked dropdownOpen = false;
  @tracked copied = false;

  private getPageContent(): string {
    return this.args.markdown || '';
  }

  private showCopiedFeedback = () => {
    this.copied = true;
    setTimeout(() => {
      this.copied = false;
    }, 1000);
  };

  copyAsMarkdown = () => {
    const content = this.getPageContent();
    void navigator.clipboard.writeText(content);
    this.dropdownOpen = false;
    this.showCopiedFeedback();
  };

  copyForChatGPT = () => {
    const content = this.getPageContent();
    const formatted = `Please help me with the following from the shadcn-ember documentation:\n\n${content}`;
    void navigator.clipboard.writeText(formatted);
    this.dropdownOpen = false;
    this.showCopiedFeedback();
  };

  copyForClaude = () => {
    const content = this.getPageContent();
    const formatted = `Here's documentation from shadcn-ember that I need help with:\n\n${content}`;
    void navigator.clipboard.writeText(formatted);
    this.dropdownOpen = false;
    this.showCopiedFeedback();
  };

  <template>
    <div
      class={{cn
        "bg-secondary group/buttons relative flex rounded-lg *:[[data-slot=button]]:focus-visible:relative *:[[data-slot=button]]:focus-visible:z-10"
        @class
      }}
      ...attributes
    >
      <DropdownMenu @open={{this.dropdownOpen}} as |isOpen setOpen|>
        <button
          type="button"
          class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 rounded-md gap-1.5 px-3 has-[>svg]:px-2.5 h-8 shadow-none md:h-7 md:text-[0.8rem]"
          {{on "click" this.copyAsMarkdown}}
        >
          {{#if this.copied}}
            <Check />
          {{else}}
            <Copy />
          {{/if}}
          Copy Page
        </button>

        <DropdownMenuTrigger
          @isOpen={{isOpen}}
          @setOpen={{setOpen}}
          class="items-center justify-center whitespace-nowrap text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-secondary text-secondary-foreground hover:bg-secondary/80 rounded-md gap-1.5 px-3 has-[>svg]:px-2.5 hidden sm:flex peer -ml-0.5 size-8 shadow-none md:size-7 md:text-[0.8rem]"
        >
          <ChevronDown
            class="tabler-icon tabler-icon-chevron-down rotate-180 sm:rotate-0"
          />
        </DropdownMenuTrigger>

        <Separator
          @orientation="vertical"
          @class="!bg-foreground/10 absolute top-0 right-8 z-0 !h-8 peer-focus-visible:opacity-0 sm:right-7 sm:!h-7"
        />

        <DropdownMenuContent @isOpen={{isOpen}} @setOpen={{setOpen}}>
          <DropdownMenuItem {{on "click" this.copyAsMarkdown}}>
            View as Markdown
          </DropdownMenuItem>
          <DropdownMenuItem {{on "click" this.copyForChatGPT}}>
            ChatGPT
          </DropdownMenuItem>
          <DropdownMenuItem {{on "click" this.copyForClaude}}>
            Claude
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  </template>
}
