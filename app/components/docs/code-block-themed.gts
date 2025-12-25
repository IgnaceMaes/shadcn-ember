import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import type ThemeService from '@/services/theme';

interface CodeBlockThemedSignature {
  Args: {
    language: string;
    code: string;
    showLineNumbers?: boolean;
  };
}

export default class CodeBlockThemed extends Component<CodeBlockThemedSignature> {
  @service declare theme: ThemeService;

  get showLineNumbers() {
    return this.args.showLineNumbers ?? false;
  }

  <template>
    <CodeBlock
      @language={{@language}}
      @code={{@code}}
      @showLineNumbers={{this.showLineNumbers}}
      @theme={{this.theme.codeBlockTheme}}
    />
  </template>
}
