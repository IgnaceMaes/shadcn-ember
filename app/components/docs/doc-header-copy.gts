import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Copy from '~icons/lucide/copy';
import Check from '~icons/lucide/check';
import ChevronDown from '~icons/lucide/chevron-down';
import MarkdownIcon from '~icons/simple-icons/markdown';
import ChatGptIcon from '~icons/simple-icons/openai';
import ClaudeIcon from '~icons/simple-icons/claude';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import {
  Popover,
  PopoverTrigger,
  PopoverContent,
  PopoverAnchor,
} from '@/components/ui/popover';
import { Separator } from '@/components/ui/separator';
import { cn } from '@/lib/utils';

interface DocHeaderCopySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    page?: string;
    url?: string;
  };
}

function getPromptUrl(baseURL: string, url: string): string {
  const prompt = `I'm looking at this shadcn/ui documentation: ${url}.
Help me understand how to use it. Be ready to explain concepts, give examples, or help debug based on it.`;
  return `${baseURL}?q=${encodeURIComponent(prompt)}`;
}

export default class DocHeaderCopy extends Component<DocHeaderCopySignature> {
  @tracked copied = false;

  private showCopiedFeedback = () => {
    this.copied = true;
    setTimeout(() => {
      this.copied = false;
    }, 1000);
  };

  copyPage = () => {
    const content = this.args.page || '';
    void navigator.clipboard.writeText(content);
    this.showCopiedFeedback();
  };

  get markdownUrl(): string {
    return `${this.args.url || ''}.md`;
  }

  get chatGptUrl(): string {
    return getPromptUrl('https://chatgpt.com', this.args.url || '');
  }

  get claudeUrl(): string {
    return getPromptUrl('https://claude.ai/new', this.args.url || '');
  }

  <template>
    <Popover>
      <div
        class={{cn
          "bg-secondary group/buttons relative flex rounded-lg *:data-[slot=button]:focus-visible:relative *:data-[slot=button]:focus-visible:z-10"
          @class
        }}
        ...attributes
      >
        <PopoverAnchor />

        <Button
          @variant="secondary"
          @size="sm"
          @class="h-8 shadow-none md:h-7 md:text-[0.8rem]"
          {{on "click" this.copyPage}}
        >
          {{#if this.copied}}
            <Check />
          {{else}}
            <Copy />
          {{/if}}
          Copy Page
        </Button>

        <DropdownMenu>
          <DropdownMenuTrigger @class="hidden sm:flex">
            <Button
              @variant="secondary"
              @size="sm"
              @class="peer -ml-0.5 size-8 shadow-none md:size-7 md:text-[0.8rem]"
            >
              <ChevronDown class="rotate-180 sm:rotate-0" />
            </Button>
          </DropdownMenuTrigger>

          <DropdownMenuContent @align="end" @class="shadow-none min-w-48">
            <DropdownMenuItem @asChild={{true}} as |itemClass|>
              <a
                href={{this.markdownUrl}}
                target="_blank"
                rel="noopener noreferrer"
                class={{itemClass}}
              >
                <MarkdownIcon />
                View as Markdown
              </a>
            </DropdownMenuItem>

            <DropdownMenuItem @asChild={{true}} as |itemClass|>
              <a
                href={{this.chatGptUrl}}
                target="_blank"
                rel="noopener noreferrer"
                class={{itemClass}}
              >
                <ChatGptIcon />
                Open in ChatGPT
              </a>
            </DropdownMenuItem>

            <DropdownMenuItem @asChild={{true}} as |itemClass|>
              <a
                href={{this.claudeUrl}}
                target="_blank"
                rel="noopener noreferrer"
                class={{itemClass}}
              >
                <ClaudeIcon />
                Open in Claude
              </a>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>

        <Separator
          @orientation="vertical"
          @class="!bg-foreground/10 absolute top-0 right-8 z-0 !h-8 peer-focus-visible:opacity-0 sm:right-7 sm:!h-7"
        />

        <PopoverTrigger @class="flex sm:hidden">
          <Button
            @variant="secondary"
            @size="sm"
            @class="peer -ml-0.5 size-8 shadow-none md:size-7 md:text-[0.8rem]"
          >
            <ChevronDown class="rotate-180 sm:rotate-0" />
          </Button>
        </PopoverTrigger>

        <PopoverContent
          @class="bg-background/70 dark:bg-background/60 w-52 !origin-center rounded-lg p-1 shadow-sm backdrop-blur-sm"
          @align="start"
          @side="top"
        >
          <Button
            @variant="ghost"
            @size="lg"
            @asChild={{true}}
            @class="*:[svg]:text-muted-foreground w-full justify-start text-base font-normal"
            as |buttonClass|
          >
            <a
              href={{this.markdownUrl}}
              target="_blank"
              rel="noopener noreferrer"
              class={{buttonClass}}
            >
              <MarkdownIcon />
              View as Markdown
            </a>
          </Button>

          <Button
            @variant="ghost"
            @size="lg"
            @asChild={{true}}
            @class="*:[svg]:text-muted-foreground w-full justify-start text-base font-normal"
            as |buttonClass|
          >
            <a
              href={{this.chatGptUrl}}
              target="_blank"
              rel="noopener noreferrer"
              class={{buttonClass}}
            >
              <ChatGptIcon />
              Open in ChatGPT
            </a>
          </Button>

          <Button
            @variant="ghost"
            @size="lg"
            @asChild={{true}}
            @class="*:[svg]:text-muted-foreground w-full justify-start text-base font-normal"
            as |buttonClass|
          >
            <a
              href={{this.claudeUrl}}
              target="_blank"
              rel="noopener noreferrer"
              class={{buttonClass}}
            >
              <ClaudeIcon />
              Open in Claude
            </a>
          </Button>
        </PopoverContent>
      </div>
    </Popover>
  </template>
}
