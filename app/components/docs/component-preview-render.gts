import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import type ThemeService from '@/services/theme';
import type { ComponentLike } from '@glint/template';

// Load all example components and their raw source code
const components = import.meta.glob<{ default: ComponentLike }>(
  './examples/*.gts',
  { eager: true }
);
const rawSources = import.meta.glob('./examples/*.gts', {
  query: '?raw',
  eager: true,
  import: 'default',
});

interface ComponentPreviewSignature {
  Args: {
    component: ComponentLike;
    showLineNumbers?: boolean;
    align?: 'start' | 'center' | 'end';
  };
  Blocks: {
    default?: [];
  };
}

export default class ComponentPreviewRender extends Component<ComponentPreviewSignature> {
  @service declare theme: ThemeService;

  get showLineNumbers() {
    return this.args.showLineNumbers ?? true;
  }

  get align() {
    return this.args.align ?? 'center';
  }

  get code(): string {
    // Find the matching source code for the component
    for (const path in components) {
      const module = components[path];
      if (module?.default === this.args.component) {
        return rawSources[path] ?? '// Component source not found';
      }
    }
    return '// Component source not found';
  }

  <template>
    <div
      class="group relative mt-4 mb-12 flex flex-col rounded-lg border overflow-hidden"
    >
      <div data-slot="preview">
        <div
          data-align={{this.align}}
          class="preview flex w-full justify-center data-[align=center]:items-center data-[align=end]:items-end data-[align=start]:items-start h-[450px] p-10"
        >
          <@component />
        </div>
      </div>
      <div data-slot="code" class="border-t">
        {{! template-lint-disable no-inline-styles }}
        <div
          class="relative [&_pre]:max-h-[400px] [&_pre]:!m-0 [&_pre]:!rounded-none"
          style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
        >
          <CodeBlock
            @language="gts"
            @code={{this.code}}
            @showLineNumbers={{this.showLineNumbers}}
            @theme={{this.theme.codeBlockTheme}}
            style="--ember-shiki-padding-x: 1rem; --ember-shiki-padding-y: 0.875rem; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.6; --ember-shiki-font-size: 0.875rem;"
          />
        </div>
      </div>
    </div>
  </template>
}
