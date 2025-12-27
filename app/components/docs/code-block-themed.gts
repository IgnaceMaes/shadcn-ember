import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import CopyButton from '@/components/docs/copy-button';
import type ThemeService from '@/services/theme';

interface CodeBlockThemedSignature {
  Args: {
    language: string;
    code: string;
    title?: string;
    showLineNumbers?: boolean;
    highlightLines?: number[];
  };
}

export default class CodeBlockThemed extends Component<CodeBlockThemedSignature> {
  @service declare theme: ThemeService;

  get lineHighlights() {
    if (!this.args.highlightLines || this.args.highlightLines.length === 0) {
      return undefined;
    }
    // Convert line numbers to ember-shiki LineHighlight format
    return this.args.highlightLines.map((line) => ({
      start: line,
      type: 'neutral' as const,
    }));
  }

  <template>
    {{! template-lint-disable no-inline-styles }}
    <div
      class="relative overflow-hidden rounded-lg [&_pre]:m-0! [&_pre]:rounded-none! mt-4"
      style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface); --ember-shiki-padding-y: 14px;"
    >
      {{#if @title}}
        <div
          class="flex items-center gap-2 border-b border-border bg-muted px-4 py-2 font-mono text-sm text-muted-foreground"
        >
          {{@title}}
        </div>
      {{/if}}
      <CopyButton @value={{@code}} @class={{if @title "!top-1.5 !right-2"}} />
      <CodeBlock
        @language={{@language}}
        @code={{@code}}
        @showLineNumbers={{if @showLineNumbers @showLineNumbers false}}
        @lineHighlights={{this.lineHighlights}}
        @theme={{this.theme.codeBlockTheme}}
        @showCopyButton={{false}}
      />
    </div>
  </template>
}
