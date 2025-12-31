import Component from '@glimmer/component';
import { eq } from 'ember-truth-helpers';
import { DocCode, DocStrong, DocLink } from './index';

interface ProcessedNode {
  type: string;
  content?: string;
  children?: ProcessedNode[];
  url?: string;
}

interface TableNode {
  type: 'table';
  children: ProcessedNode[];
  align?: ('left' | 'right' | 'center' | null)[];
}

interface Signature {
  Args: {
    node: TableNode;
  };
}

export default class DocTable extends Component<Signature> {
  get headerRow() {
    return this.args.node.children[0];
  }

  get bodyRows() {
    return this.args.node.children.slice(1);
  }

  getAlignment = (index: number): string => {
    const align = this.args.node.align;
    if (!align || !align[index]) return 'left';
    return align[index] as string;
  };

  <template>
    <div class="no-scrollbar my-6 w-full overflow-y-auto rounded-lg border">
      <table
        class="relative w-full overflow-hidden border-none text-sm [&_tbody_tr:last-child]:border-b-0"
      >
        {{#if this.headerRow}}
          <thead>
            <tr class="m-0 border-b">
              {{#each this.headerRow.children as |cell index|}}
                <th
                  align={{this.getAlignment index}}
                  class="px-4 py-2 text-left font-bold [[align=center]]:text-center [[align=right]]:text-right"
                >
                  {{#each cell.children as |inline|}}
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
                  {{/each}}
                </th>
              {{/each}}
            </tr>
          </thead>
        {{/if}}
        <tbody>
          {{#each this.bodyRows as |row|}}
            <tr class="m-0 border-b">
              {{#each row.children as |cell index|}}
                <td
                  align={{this.getAlignment index}}
                  class="px-4 py-2 text-left whitespace-nowrap [[align=center]]:text-center [[align=right]]:text-right"
                >
                  {{#each cell.children as |inline|}}
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
                    {{#if (eq inline.type "link")}}
                      <DocLink @href={{if inline.url inline.url ""}}>
                        {{#each inline.children as |child|}}
                          {{#if (eq child.type "text")}}{{child.content}}{{/if}}
                        {{/each}}
                      </DocLink>
                    {{/if}}
                  {{/each}}
                </td>
              {{/each}}
            </tr>
          {{/each}}
        </tbody>
      </table>
    </div>
  </template>
}
