import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    title: string;
    description?: string;
    class?: string;
  };
  Blocks: {
    default?: [];
  };
}

export default class DocHeader extends Component<DocHeaderSignature> {
  <template>
    <div class={{cn "flex items-start justify-between" @class}} ...attributes>
      <div class="space-y-2">
        <h1
          class="scroll-m-20 text-4xl font-semibold tracking-tight sm:text-3xl xl:text-4xl"
        >
          {{@title}}
        </h1>
        {{#if @description}}
          <p
            class="text-muted-foreground text-[1.05rem] text-balance sm:text-base"
          >
            {{@description}}
          </p>
        {{/if}}
      </div>
      {{yield}}
    </div>
  </template>
}
