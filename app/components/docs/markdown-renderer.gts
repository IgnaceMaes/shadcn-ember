import Component from '@glimmer/component';
import { eq } from 'ember-truth-helpers';
import { unified } from 'unified';
import remarkParse from 'remark-parse';
import remarkGfm from 'remark-gfm';
import {
  DocParagraph,
  DocStrong,
  DocEmphasis,
  DocList,
  DocListItem,
  DocHeader,
  DocPage,
  DocContent,
  DocLink,
  DocCode,
} from './index';
import Separator from '@/components/ui/separator';
import CodeBlockThemed from './code-block-themed';
import PackageManagerCommand from './package-manager-command';
import * as DocsComponents from './index';
import type { ComponentLike } from '@glint/template';

// Type definitions for markdown AST nodes
interface MdastNode {
  type: string;
  children?: MdastNode[];
  value?: string;
  depth?: number;
}

interface Root extends MdastNode {
  type: 'root';
  children: MdastNode[];
}

interface Paragraph extends MdastNode {
  type: 'paragraph';
  children: MdastNode[];
}

interface Heading extends MdastNode {
  type: 'heading';
  depth: number;
  children: MdastNode[];
}

interface List extends MdastNode {
  type: 'list';
  children: ListItem[];
}

interface ListItem extends MdastNode {
  type: 'listItem';
  children: MdastNode[];
}

interface Strong extends MdastNode {
  type: 'strong';
  children: MdastNode[];
}

interface Emphasis extends MdastNode {
  type: 'emphasis';
  children: MdastNode[];
}

interface Link extends MdastNode {
  type: 'link';
  url: string;
  children: MdastNode[];
}

interface Code extends MdastNode {
  type: 'code';
  lang: string | null;
  value: string;
  meta?: string | null;
}

interface InlineCode extends MdastNode {
  type: 'inlineCode';
  value: string;
}

interface Text extends MdastNode {
  type: 'text';
  value: string;
}

interface Html extends MdastNode {
  type: 'html';
  value: string;
}

interface Frontmatter {
  title?: string;
  description?: string;
  [key: string]: unknown;
}

interface Signature {
  Args: {
    markdown: string;
  };
}

interface ProcessedNode {
  type: string;
  content?: string;
  children?: ProcessedNode[];
  depth?: number;
  url?: string;
  language?: string;
  meta?: string;
  isNpmCommand?: boolean;
  componentName?: string;
  componentInstance?: ComponentLike;
  title?: string;
  showLineNumbers?: boolean;
  highlightLines?: number[];
}

export default class MarkdownRenderer extends Component<Signature> {
  private parseFrontmatter(): { frontmatter: Frontmatter; content: string } {
    const markdown = this.args.markdown.trim();
    const frontmatterRegex = /^---\s*\n([\s\S]*?)\n---\s*\n([\s\S]*)$/;
    const match = markdown.match(frontmatterRegex);

    if (!match) {
      return { frontmatter: {}, content: markdown };
    }

    const [, frontmatterText, content] = match;
    const frontmatter: Frontmatter = {};

    // Parse simple YAML frontmatter (key: value pairs)
    frontmatterText.split('\n').forEach((line) => {
      const colonIndex = line.indexOf(':');
      if (colonIndex > -1) {
        const key = line.slice(0, colonIndex).trim();
        const value = line.slice(colonIndex + 1).trim();
        frontmatter[key] = value;
      }
    });

    return { frontmatter, content };
  }

  get parsed() {
    return this.parseFrontmatter();
  }

  get frontmatter(): Frontmatter {
    return this.parsed.frontmatter;
  }

  get processedContent(): ProcessedNode[] {
    const processor = unified().use(remarkParse).use(remarkGfm);

    const ast = processor.parse(this.parsed.content) as Root;
    return this.processNodes(ast.children);
  }

  private processNodes(nodes: MdastNode[]): ProcessedNode[] {
    return nodes
      .map((node) => this.processNode(node))
      .filter(Boolean) as ProcessedNode[];
  }

  private processNode(node: MdastNode): ProcessedNode | null {
    switch (node.type) {
      case 'paragraph':
        return {
          type: 'paragraph',
          children: this.processInlineNodes((node as Paragraph).children),
        };
      case 'heading':
        return {
          type: 'heading',
          depth: (node as Heading).depth,
          children: this.processInlineNodes((node as Heading).children),
        };
      case 'list':
        return {
          type: 'list',
          children: this.processNodes((node as List).children),
        };
      case 'listItem':
        return {
          type: 'listItem',
          children: this.processNodes((node as ListItem).children),
        };
      case 'code': {
        const codeNode = node as Code;
        const metaInfo = this.parseCodeMeta(codeNode.meta);
        return {
          type: 'code',
          language: codeNode.lang || 'text',
          content: codeNode.value,
          meta: codeNode.meta || undefined,
          isNpmCommand: this.isNpmCommand(codeNode),
          title: metaInfo.title,
          showLineNumbers: metaInfo.showLineNumbers,
          highlightLines: metaInfo.highlightLines,
        };
      }
      case 'html': {
        // Handle custom components embedded in markdown
        const htmlValue = (node as Html).value;
        // Match component tags that start with a capital letter
        const componentMatch = htmlValue.match(/<([A-Z][a-zA-Z0-9]*)/);
        if (componentMatch) {
          const componentName = componentMatch[1];
          // Look up the component from the imported DocsComponents
          const componentInstance = (DocsComponents as Record<string, unknown>)[
            componentName
          ] as unknown;
          if (componentInstance) {
            return {
              type: 'component',
              componentName,
              componentInstance,
            };
          }
        }
        return null;
      }
      case 'thematicBreak':
        return {
          type: 'thematicBreak',
        };
      default:
        return null;
    }
  }

  private processInlineNode(node: MdastNode): ProcessedNode | null {
    switch (node.type) {
      case 'strong':
        return {
          type: 'strong',
          children: this.processInlineNodes((node as Strong).children),
        };
      case 'emphasis':
        return {
          type: 'emphasis',
          children: this.processInlineNodes((node as Emphasis).children),
        };
      case 'link':
        return {
          type: 'link',
          url: (node as Link).url,
          children: this.processInlineNodes((node as Link).children),
        };
      case 'text':
        return {
          type: 'text',
          content: (node as Text).value,
        };
      case 'inlineCode':
        return {
          type: 'inlineCode',
          content: (node as InlineCode).value,
        };
      default:
        return null;
    }
  }

  private processInlineNodes(nodes: MdastNode[]): ProcessedNode[] {
    return nodes
      .map((node) => this.processInlineNode(node))
      .filter(Boolean) as ProcessedNode[];
  }

  // Helper to check if code block is a bash command with npm/npx
  private isNpmCommand(codeNode: Code): boolean {
    if (!codeNode.lang || !['bash', 'sh', 'shell'].includes(codeNode.lang)) {
      return false;
    }

    const trimmedCode = codeNode.value.trim();
    return trimmedCode.startsWith('npm ') || trimmedCode.startsWith('npx ');
  }

  // Parse code block meta string for title, showLineNumbers, and line highlights
  private parseCodeMeta(meta: string | null | undefined): {
    title?: string;
    showLineNumbers: boolean;
    highlightLines?: number[];
  } {
    if (!meta) {
      return { showLineNumbers: false };
    }

    const result: {
      title?: string;
      showLineNumbers: boolean;
      highlightLines?: number[];
    } = { showLineNumbers: false };

    // Check for showLineNumbers flag
    if (meta.includes('showLineNumbers')) {
      result.showLineNumbers = true;
    }

    // Extract title="..." or title='...'
    const titleMatch = meta.match(/title=["']([^"']+)["']/);
    if (titleMatch?.[1]) {
      result.title = titleMatch[1];
    }

    // Extract line highlights like {3-6} or {1,3,5-7}
    const highlightMatch = meta.match(/\{([0-9,-]+)\}/);
    if (highlightMatch?.[1]) {
      const ranges = highlightMatch[1].split(',');
      const lines: number[] = [];

      for (const range of ranges) {
        if (range.includes('-')) {
          const parts = range.split('-');
          const startStr = parts[0];
          const endStr = parts[1];
          if (startStr && endStr) {
            const start = parseInt(startStr, 10);
            const end = parseInt(endStr, 10);
            if (!isNaN(start) && !isNaN(end)) {
              for (let i = start; i <= end; i++) {
                lines.push(i);
              }
            }
          }
        } else {
          const line = parseInt(range, 10);
          if (!isNaN(line)) {
            lines.push(line);
          }
        }
      }

      if (lines.length > 0) {
        result.highlightLines = lines;
      }
    }

    return result;
  }

  // Helper to extract text from nodes recursively
  private getHeadingText = (children: ProcessedNode[] | undefined): string => {
    if (!children) return '';

    return children
      .map((node) => {
        if (node.type === 'text') return node.content || '';
        if (node.type === 'strong' || node.type === 'emphasis') {
          return this.getHeadingText(node.children);
        }
        return '';
      })
      .join('');
  };

  <template>
    <DocPage as |page|>
      <DocHeader
        @title={{this.frontmatter.title}}
        @description={{this.frontmatter.description}}
      />

      <DocContent>
        {{#each this.processedContent as |node|}}
          {{#if (eq node.type "component")}}
            {{#if node.componentInstance}}
              {{component node.componentInstance}}
            {{/if}}
          {{/if}}
          {{#if (eq node.type "thematicBreak")}}
            <Separator @class="my-4 md:my-8" />
          {{/if}}
          {{#if (eq node.type "code")}}
            {{#if node.isNpmCommand}}
              <PackageManagerCommand
                @command={{if node.content node.content ""}}
              />
            {{else}}
              <CodeBlockThemed
                @language={{if node.language node.language "text"}}
                @code={{if node.content node.content ""}}
                @title={{node.title}}
                @showLineNumbers={{node.showLineNumbers}}
                @highlightLines={{node.highlightLines}}
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
                  <DocLink @href={{inline.url}}>
                    {{#each inline.children as |child|}}
                      {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                    {{/each}}
                  </DocLink>
                {{/if}}
              {{/each}}
            </DocParagraph>
          {{/if}}
          {{#if (eq node.type "heading")}}
            {{#if (eq node.depth 2)}}
              <page.Heading>
                {{#each node.children as |inline|}}
                  {{#if (eq inline.type "text")}}{{inline.content}}{{/if}}
                  {{#if (eq inline.type "strong")}}
                    <DocStrong>
                      {{#each inline.children as |child|}}
                        {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                      {{/each}}
                    </DocStrong>
                  {{/if}}
                {{/each}}
              </page.Heading>
            {{/if}}
          {{/if}}
          {{#if (eq node.type "list")}}
            <DocList>
              {{#each node.children as |listItem|}}
                {{#each listItem.children as |para|}}
                  {{#if (eq para.type "paragraph")}}
                    <DocListItem>
                      {{#each para.children as |inline|}}
                        {{#if (eq inline.type "text")}}{{inline.content}}{{/if}}
                        {{#if (eq inline.type "inlineCode")}}<DocCode
                          >{{inline.content}}</DocCode>{{/if}}
                        {{#if (eq inline.type "strong")}}
                          <DocStrong>
                            {{#each inline.children as |child|}}
                              {{#if
                                (eq child.type "text")
                              }}{{child.content}}{{/if}}
                            {{/each}}
                          </DocStrong>
                        {{/if}}
                        {{#if (eq inline.type "emphasis")}}
                          <DocEmphasis>
                            {{#each inline.children as |child|}}
                              {{#if
                                (eq child.type "text")
                              }}{{child.content}}{{/if}}
                            {{/each}}
                          </DocEmphasis>
                        {{/if}}
                        {{#if (eq inline.type "link")}}
                          <DocLink @href={{inline.url}}>
                            {{#each inline.children as |child|}}
                              {{#if
                                (eq child.type "text")
                              }}{{child.content}}{{/if}}
                            {{/each}}
                          </DocLink>
                        {{/if}}
                      {{/each}}
                    </DocListItem>
                  {{/if}}
                {{/each}}
              {{/each}}
            </DocList>
          {{/if}}
        {{/each}}
      </DocContent>
    </DocPage>
  </template>
}
