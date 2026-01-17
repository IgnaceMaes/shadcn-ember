import { eq } from 'ember-truth-helpers';

import { Separator } from '@/components/ui/separator';

import CodeBlockThemed from './code-block-themed';
import DynamicMarkdownComponent from './dynamic-markdown-component';
import {
  DocParagraph,
  DocStrong,
  DocEmphasis,
  DocCode,
  DocLink,
} from './index';
import PackageManagerCommand from './package-manager-command';

import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';

interface ProcessedNode {
  type: string;
  content?: string;
  children?: ProcessedNode[];
  depth?: number;
  url?: string;
  language?: string;
  meta?: string;
  isNpmCommand?: boolean;
  componentInstance?: ComponentLike;
  componentProps?: Record<string, string>;
  title?: string;
  showLineNumbers?: boolean;
  highlightLines?: number[];
}

interface MarkdownNodesSignature {
  Args: {
    nodes: ProcessedNode[];
  };
  Element: HTMLDivElement;
}

/**
 * Renders a subset of markdown nodes for use in nested contexts like installation tabs.
 * This handles common node types: paragraphs, code blocks, thematic breaks, components.
 */
const MarkdownNodes: TOC<MarkdownNodesSignature> = <template>
  <div ...attributes>
    {{#each @nodes as |node|}}
      {{#if (eq node.type "component")}}
        {{#if node.componentInstance}}
          <DynamicMarkdownComponent
            @component={{node.componentInstance}}
            @props={{node.componentProps}}
          />
        {{/if}}
      {{/if}}
      {{#if (eq node.type "thematicBreak")}}
        <Separator @class="my-4 md:my-8" />
      {{/if}}
      {{#if (eq node.type "code")}}
        {{#if node.isNpmCommand}}
          <PackageManagerCommand @command={{if node.content node.content ""}} />
        {{else}}
          <CodeBlockThemed
            @code={{if node.content node.content ""}}
            @highlightLines={{node.highlightLines}}
            @language={{if node.language node.language "text"}}
            @showLineNumbers={{node.showLineNumbers}}
            @title={{node.title}}
          />
        {{/if}}
      {{/if}}
      {{#if (eq node.type "paragraph")}}
        <DocParagraph>
          {{#each node.children as |inline|}}
            {{#if (eq inline.type "text")}}{{inline.content}}{{/if}}
            {{#if (eq inline.type "inlineCode")}}<DocCode
              >{{inline.content}}</DocCode>{{/if}}
            {{#if (eq inline.type "strong")}}
              <DocStrong>
                {{#each inline.children as |child|}}
                  {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                {{/each}}
              </DocStrong>
            {{/if}}
            {{#if (eq inline.type "emphasis")}}
              <DocEmphasis>
                {{#each inline.children as |child|}}
                  {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                {{/each}}
              </DocEmphasis>
            {{/if}}
            {{#if (eq inline.type "link")}}
              <DocLink @href={{if inline.url inline.url ""}}>
                {{#each inline.children as |child|}}
                  {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                {{/each}}
              </DocLink>
            {{/if}}
          {{/each}}
        </DocParagraph>
      {{/if}}
    {{/each}}
  </div>
</template>;

export default MarkdownNodes;
