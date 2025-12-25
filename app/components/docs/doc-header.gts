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
    <div class={{cn "space-y-2" @class}} ...attributes>
      <h1 class="scroll-m-20 text-4xl font-bold tracking-tight">
        {{@title}}
      </h1>
      {{#if @description}}
        <p class="text-lg text-muted-foreground">
          {{@description}}
        </p>
      {{/if}}
      {{yield}}
    </div>
  </template>
}
