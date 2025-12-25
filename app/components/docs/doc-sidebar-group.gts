import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface DocSidebarGroupSignature {
  Element: HTMLDivElement;
  Args: {
    title: string;
    class?: string;
    listClass?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocSidebarGroup extends Component<DocSidebarGroupSignature> {
  <template>
    <div
      class={{cn "relative flex w-full min-w-0 flex-col p-2" @class}}
      ...attributes
    >
      <div
        class="ring-sidebar-ring flex h-8 shrink-0 items-center rounded-md px-2 text-xs outline-hidden transition-[margin,opacity] duration-200 ease-linear focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0 group-data-[collapsible=icon]:-mt-8 group-data-[collapsible=icon]:opacity-0 text-muted-foreground font-medium"
      >
        {{@title}}
      </div>
      <div class="w-full text-sm">
        <ul class={{cn "flex w-full min-w-0 flex-col gap-0.5" @listClass}}>
          {{yield}}
        </ul>
      </div>
    </div>
  </template>
}
