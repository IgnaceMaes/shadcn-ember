import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import type ThemeService from '@/services/theme';

interface CodeBlockThemedSignature {
  Args: {
    language: string;
    code: string;
  };
}

export default class CodeBlockThemed extends Component<CodeBlockThemedSignature> {
  @service declare theme: ThemeService;

  <template>
    <div
      class="relative overflow-hidden rounded-lg [&_pre]:m-0! [&_pre]:rounded-none! mt-4"
      style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
    >
      <CodeBlock
        @language={{@language}}
        @code={{@code}}
        @showLineNumbers={{true}}
        @theme={{this.theme.codeBlockTheme}}
      />
    </div>
  </template>
}
