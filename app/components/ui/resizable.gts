/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
// import PhDotsThreeVertical from 'ember-phosphor-icons/components/ph-dots-three-vertical';
import GripVertical from '~icons/lucide/grip-vertical';

// Note: This is a simplified version of the Resizable component
// Full implementation would require react-resizable-panels or similar

// ResizablePanelGroup Component
interface ResizablePanelGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    direction?: 'horizontal' | 'vertical';
  };
  Blocks: {
    default: [];
  };
}

export class ResizablePanelGroup extends Component<ResizablePanelGroupSignature> {
  get directionClass() {
    return this.args.direction === 'vertical' ? 'flex-col' : '';
  }

  <template>
    <div
      class={{cn "flex h-full w-full" this.directionClass @class}}
      data-panel-group-direction={{@direction}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// ResizablePanel Component
interface ResizablePanelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    defaultSize?: number;
    minSize?: number;
    maxSize?: number;
  };
  Blocks: {
    default: [];
  };
}

export class ResizablePanel extends Component<ResizablePanelSignature> {
  <template>
    <div class={{cn "flex-1" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// ResizableHandle Component
interface ResizableHandleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    withHandle?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class ResizableHandle extends Component<ResizableHandleSignature> {
  <template>
    {{! template-lint-disable require-presentational-children }}
    <div
      class={{cn
        "relative flex w-px items-center justify-center bg-border after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring focus-visible:ring-offset-1 data-[panel-group-direction=vertical]:h-px data-[panel-group-direction=vertical]:w-full data-[panel-group-direction=vertical]:after:left-0 data-[panel-group-direction=vertical]:after:h-1 data-[panel-group-direction=vertical]:after:w-full data-[panel-group-direction=vertical]:after:-translate-y-1/2 data-[panel-group-direction=vertical]:after:translate-x-0 [&[data-panel-group-direction=vertical]>div]:rotate-90"
        @class
      }}
      tabindex="0"
      role="separator"
      ...attributes
    >
      {{#if @withHandle}}
        <div
          class="z-10 flex h-4 w-3 items-center justify-center rounded-sm border bg-border"
        >
          <GripVertical class="size-2.5" />
        </div>
      {{/if}}
    </div>
  </template>
}

export default ResizablePanelGroup;
