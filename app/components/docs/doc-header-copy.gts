import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Copy from '~icons/lucide/copy';
import Check from '~icons/lucide/check';
import ChevronDown from '~icons/lucide/chevron-down';
import MarkdownIcon from '~icons/simple-icons/markdown';
import ChatGptIcon from '~icons/simple-icons/openai';
import ClaudeIcon from '~icons/simple-icons/claude';
import CursorIcon from '~icons/simple-icons/cursor';
import { Button } from '@/components/ui/button';
import {
  ButtonGroup,
  ButtonGroupSeparator,
} from '@/components/ui/button-group';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
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
    const url = this.args.url || '';
    if (url === '/docs' || url === 'docs') {
      return '/docs/index.md';
    }
    return `${url}.md`;
  }

  get chatGptUrl(): string {
    return getPromptUrl('https://chatgpt.com', this.args.url || '');
  }

  get claudeUrl(): string {
    return getPromptUrl('https://claude.ai/new', this.args.url || '');
  }

  get cursorUrl(): string {
    const prompt = `Read ${this.args.url || ''}.md`;
    return `https://cursor.com/link/prompt?text=${encodeURIComponent(prompt)}`;
  }

  <template>
    <ButtonGroup @class={{cn "bg-secondary rounded-lg" @class}} ...attributes>
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

      <ButtonGroupSeparator @class="!bg-foreground/10" />

      <DropdownMenu>
        <DropdownMenuTrigger>
          <Button
            @variant="secondary"
            @size="sm"
            @class="size-8 shadow-none md:size-7 md:text-[0.8rem]"
          >
            <ChevronDown class="rotate-180 md:rotate-0" />
          </Button>
        </DropdownMenuTrigger>

        <DropdownMenuContent @align="end" @class="min-w-48">
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

          <DropdownMenuItem @asChild={{true}} as |itemClass|>
            <a
              href={{this.cursorUrl}}
              target="_blank"
              rel="noopener noreferrer"
              class={{itemClass}}
            >
              <CursorIcon />
              Open in Cursor
            </a>
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </ButtonGroup>
  </template>
}
