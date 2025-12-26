import Component from '@glimmer/component';
import { concat } from '@ember/helper';
import CodeBlockThemed from './code-block-themed';

interface Signature {
  Args: {
    name: string;
    title?: string;
  };
}

export default class ComponentSource extends Component<Signature> {
  get sourceCode() {
    // For now, we'll need to import the actual source file
    // In the future, this could be done at build time
    return `// Component source for ${this.args.name}
// TODO: Implement component source loading`;
  }

  get defaultTitle() {
    return `components/ui/${this.args.name}.gts`;
  }

  <template>
    <CodeBlockThemed
      @language="gts"
      @code={{this.sourceCode}}
      @title={{if @title @title this.defaultTitle}}
      @showLineNumbers={{true}}
    />
  </template>
}
