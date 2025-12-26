/* eslint-disable ember/no-runloop */
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { next } from '@ember/runloop';
import { cn } from '@/lib/utils';
import DocToc, { type TocItem } from './doc-toc';
import DocHeading from './doc-heading';
import { hash } from '@ember/helper';
import type { ComponentLike } from '@glint/template';

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
    tocItems?: TocItem[];
  };
  Blocks: {
    default: [
      {
        Heading: ComponentLike;
      },
    ];
  };
}

class RegisteredHeading extends Component<{
  Args: { id?: string; class?: string; onRegister?: (item: TocItem) => void };
  Blocks: { default: [] };
}> {
  registerHeading = modifier((element: HTMLHeadingElement) => {
    const title = element.textContent?.trim() || '';
    const id = this.args.id || toKebabCase(title);

    if (!this.args.id) {
      element.id = id;
    }

    this.args.onRegister?.({ id, title, depth: 2 });

    return () => {};
  });

  <template>
    <DocHeading @id={{@id}} @class={{@class}} {{this.registerHeading}}>
      {{yield}}
    </DocHeading>
  </template>
}

export default class DocPage extends Component<DocPageSignature> {
  @tracked tocItems: TocItem[] = [];

  get allTocItems(): TocItem[] {
    // Combine items from args (markdown) and tracked items (template headings)
    return [...(this.args.tocItems || []), ...this.tocItems];
  }

  handleRegister = (item: TocItem) => {
    next(() => {
      if (!this.tocItems.find((existing) => existing.id === item.id)) {
        this.tocItems = [...this.tocItems, item];
      }
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
                RegisteredHeading onRegister=this.handleRegister
              )
            )
          }}
        </div>
      </div>
      {{#if this.allTocItems.length}}
        <DocToc @items={{this.allTocItems}} />
      {{/if}}
    </div>
  </template>
}
