import Component from '@glimmer/component';
import CodeBlockThemed from './code-block-themed';
import CodeCollapsibleWrapper from './code-collapsible-wrapper';

// Load all UI component source code
const uiSources = import.meta.glob<string>('/app/components/ui/*.gts', {
  query: '?raw',
  eager: true,
  import: 'default',
});

interface Signature {
  Args: {
    name: string;
    title?: string;
  };
}

export default class ComponentSource extends Component<Signature> {
  get sourceCode(): string {
    const path = `/app/components/ui/${this.args.name}.gts`;
    return (
      uiSources[path] || `// Component source for ${this.args.name} not found`
    );
  }

  get defaultTitle() {
    return `components/ui/${this.args.name}.gts`;
  }

  <template>
    <CodeCollapsibleWrapper>
      <CodeBlockThemed
        @code={{this.sourceCode}}
        @language="gts"
        @showLineNumbers={{true}}
        @title={{if @title @title this.defaultTitle}}
      />
    </CodeCollapsibleWrapper>
  </template>
}
