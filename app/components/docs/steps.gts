/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';

interface Signature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class Steps extends Component<Signature> {
  <template>
    <div
      class="mb-4 ml-4 mt-6 border-l pl-6 [counter-reset:step]"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}
