import { service } from '@ember/service';
import Component from '@glimmer/component';
import { eq, or } from 'ember-truth-helpers';

import glimmerTsDark from '@/assets/images/glimmer-ts-dark.svg';
import glimmerTsLight from '@/assets/images/glimmer-ts-light.svg';
import CodeHighlight from '@/components/docs/code-highlight';
import CopyButton from '@/components/docs/copy-button';

import type ThemeService from '@/services/theme';
import type { ComponentLike } from '@glint/template';

import AstroIcon from '~icons/vscode-icons/file-type-astro';
import CssIcon from '~icons/vscode-icons/file-type-css';
import JavaScriptIcon from '~icons/vscode-icons/file-type-js';
import JsonIcon from '~icons/vscode-icons/file-type-json';
import TypeScriptIcon from '~icons/vscode-icons/file-type-typescript';

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

  get iconSrc(): string | undefined {
    const lang = this.args.language;
    if (lang === 'gts' || lang === 'glimmer-ts') {
      return this.theme.resolvedTheme === 'dark'
        ? glimmerTsDark
        : glimmerTsLight;
    }
    return undefined;
  }

  get iconComponent(): ComponentLike | undefined {
    const lang = this.args.language;
    if (lang === 'json') return JsonIcon as ComponentLike;
    if (lang === 'typescript' || lang === 'ts')
      return TypeScriptIcon as ComponentLike;
    if (lang === 'javascript' || lang === 'js')
      return JavaScriptIcon as ComponentLike;
    if (lang === 'css') return CssIcon as ComponentLike;
    if (lang === 'astro') return AstroIcon as ComponentLike;
    return undefined;
  }

  get hasIcon(): boolean {
    return this.iconSrc !== undefined || this.iconComponent !== undefined;
  }

  <template>
    {{! template-lint-disable no-inline-styles }}
    <div
      class="relative overflow-hidden rounded-lg [&_pre]:m-0! [&_pre]:rounded-none! mt-4"
      style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface); --code-block-padding-y: 14px;"
    >
      {{#if @title}}
        <div
          class="flex items-center gap-2 border-b border-border bg-code px-4 py-2 font-mono text-sm text-code-foreground"
        >
          {{#if this.hasIcon}}
            <div
              class="bg-foreground flex size-4 items-center justify-center rounded-[1px] opacity-70"
            >
              {{#if this.iconSrc}}
                <img
                  alt={{@language}}
                  class="size-3.5 text-white dark:text-black"
                  src={{this.iconSrc}}
                />
              {{else if this.iconComponent}}
                {{#let this.iconComponent as |Icon|}}
                  {{#if
                    (or
                      (eq @language "typescript")
                      (eq @language "ts")
                      (eq @language "javascript")
                      (eq @language "js")
                    )
                  }}
                    <span
                      class="size-3 text-white dark:text-black [&_path]:fill-current! [&_circle]:fill-current! [&_rect]:fill-current!"
                    >
                      <Icon />
                    </span>
                  {{else}}
                    <span
                      class="flex size-3.5 items-center justify-center text-white dark:text-black [&_path]:fill-current! [&_circle]:fill-current! [&_rect]:fill-current!"
                    >
                      <Icon />
                    </span>
                  {{/if}}
                {{/let}}
              {{/if}}
            </div>
          {{/if}}
          {{@title}}
        </div>
      {{/if}}
      <CopyButton @class={{if @title "!top-1.5 !right-2"}} @value={{@code}} />
      <CodeHighlight
        @code={{@code}}
        @highlightLines={{@highlightLines}}
        @language={{@language}}
        @showLineNumbers={{@showLineNumbers}}
      />
    </div>
  </template>
}
