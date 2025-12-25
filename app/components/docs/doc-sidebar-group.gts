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
      <h4 class="mb-1 rounded-md px-2 py-1 text-sm font-semibold">
        {{@title}}
      </h4>
      <div class="grid grid-flow-row auto-rows-max text-sm">
        {{yield}}
      </div>
    </div>
  </template>
}
