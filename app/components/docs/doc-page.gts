/* eslint-disable ember/no-runloop */
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { scheduleOnce } from '@ember/runloop';
import { cn } from '@/lib/utils';
import DocToc from './doc-toc';
import DocHeading from './doc-heading';
import { hash } from '@ember/helper';

export interface TocItem {
  id: string;
  title: string;
  depth: number;
}

function toKebabCase(text: string): string {
  return text
    .trim()
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-');
}

interface DocPageSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [
      {
        Heading: typeof RegisteredHeading;
      },
    ];
  };
}

class RegisteredHeading extends Component<{
  Args: { id?: string; class?: string; registerHeading?: any; unregisterHeading?: any };
  Blocks: { default: [] };
}> {
  registerHeading = modifier((element: HTMLHeadingElement) => {
    const title = element.textContent?.trim() || '';
    const id = this.args.id || toKebabCase(title);

    // Set the id on the element if it wasn't explicitly provided
    if (!this.args.id) {
      element.id = id;
    }

    if (this.args.registerHeading) {
      this.args.registerHeading(id, title, 2);
    }

    return () => {
      if (this.args.unregisterHeading) {
        this.args.unregisterHeading(id);
      }
    };
  });

  <template>
    <DocHeading @id={{@id}} @class={{@class}} {{this.registerHeading}}>
      {{yield}}
    </DocHeading>
  </template>
}

export default class DocPage extends Component<DocPageSignature> {
  @tracked tocItems: TocItem[] = [];

  registerHeading = (id: string, title: string, depth: number) => {
    scheduleOnce('afterRender', () => {
      const exists = this.tocItems.find((item) => item.id === id);
      if (!exists) {
        this.tocItems = [...this.tocItems, { id, title, depth }];
      }
    });
  };

  unregisterHeading = (id: string) => {
    scheduleOnce('afterRender', () => {
      this.tocItems = this.tocItems.filter((item) => item.id !== id);
    });
  };

  <template>
    <div class="flex items-stretch text-[1.05rem] sm:text-[15px] xl:w-full">
      <div class="flex min-w-0 flex-1 flex-col">
        <div
          class={{cn
            "mx-auto flex w-full max-w-2xl min-w-0 flex-1 flex-col gap-8 px-4 py-6 text-neutral-800 md:px-0 lg:py-8 dark:text-neutral-300"
            @class
          }}
          ...attributes
        >
          {{yield
            (hash
              Heading=(component
                RegisteredHeading
                registerHeading=this.registerHeading
                unregisterHeading=this.unregisterHeading
              )
            )
          }}
        </div>
      </div>
      {{#if this.tocItems}}
        <DocToc @items={{this.tocItems}} />
      {{/if}}
    </div>
  </template>
}
