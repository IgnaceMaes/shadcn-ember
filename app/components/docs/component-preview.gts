import Component from '@glimmer/component';
import type { ComponentLike } from '@glint/template';
import ComponentPreviewRender from './component-preview-render.gts';

// Load all example components
const components = import.meta.glob<{ default: ComponentLike }>(
  './examples/*.gts',
  { eager: true }
);

interface Signature {
  Args: {
    name: string;
    class?: string;
    description?: string;
    align?: 'start' | 'center' | 'end';
  };
}

export default class ComponentPreview extends Component<Signature> {
  get componentInstance(): ComponentLike | undefined {
    // Convert kebab-case to filename format
    // e.g., "accordion-demo" -> "./examples/accordion-demo.gts"
    const filename = `./examples/${this.args.name}.gts`;
    const module = components[filename];
    return module?.default;
  }

  <template>
    {{#if this.componentInstance}}
      <ComponentPreviewRender
        @component={{this.componentInstance}}
        @align={{@align}}
        @class={{@class}}
      />
    {{else}}
      <div class="text-destructive">
        Component example "{{@name}}" not found
      </div>
    {{/if}}
  </template>
}
