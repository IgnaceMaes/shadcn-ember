import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocSidebarGroupSignature {
  Element: HTMLDivElement;
  Args: {
    title: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocSidebarGroup extends Component<DocSidebarGroupSignature> {
  <template>
    <div class={{cn "" @class}} ...attributes>
      <h4 class="text-muted-foreground font-medium mb-1 rounded-md px-2 py-1 text-sm">
        {{@title}}
      </h4>
      <div class="grid grid-flow-row auto-rows-max text-sm gap-0.5">
        {{yield}}
      </div>
    </div>
  </template>
}
