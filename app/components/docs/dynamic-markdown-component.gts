/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { get } from '@ember/helper';
import type { ComponentLike } from '@glint/template';

interface Signature {
  Args: {
    component: ComponentLike;
    props?: Record<string, string>;
  };
}

/**
 * Helper component to dynamically render components with props from markdown.
 * This converts string props to the appropriate component arguments.
 */
export default class DynamicMarkdownComponent extends Component<Signature> {
  <template>
    {{!
      We dynamically invoke the component and pass props based on what's provided.
      Since Glimmer doesn't support fully dynamic argument passing, we handle common
      props here. For more complex scenarios, add additional conditionals.
    }}
    {{#let @props as |p|}}
      {{component
        @component
        name=(if p (get p "name"))
        className=(if p (get p "className"))
        description=(if p (get p "description"))
        align=(if p (get p "align"))
        title=(if p (get p "title"))
        value=(if p (get p "value"))
      }}
    {{/let}}
  </template>
}
