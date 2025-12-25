import Component from '@glimmer/component';

interface ComponentDocPageSignature {
  Blocks: {
    default: [];
  };
}

export default class ComponentDocPage extends Component<ComponentDocPageSignature> {
  <template>
    <div class="mx-auto w-full min-w-0 max-w-4xl">
      {{yield}}
    </div>
  </template>
}
