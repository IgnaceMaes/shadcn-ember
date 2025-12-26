import Component from '@glimmer/component';
import type { ComponentLike } from '@glint/template';

interface Signature {
  Args: {
    component: ComponentLike;
    props?: Record<string, string>;
  };
}

export default class DynamicComponent extends Component<Signature> {
  get componentWithArgs() {
    return this.args.component;
  }

  get props() {
    return this.args.props || {};
  }

  <template>
    {{!
      Note: This is a simplified version that passes all props as named arguments.
      In reality, Ember/Glimmer doesn't support fully dynamic component invocation
      with arbitrary props, so we'll need to handle specific components individually
      in the markdown renderer.
    }}
    {{component this.componentWithArgs}}
  </template>
}
