import Component from '@glimmer/component';

interface ComponentDocSectionSignature {
  Args: {
    title: string;
  };
  Blocks: {
    default: [];
  };
}

export default class ComponentDocSection extends Component<ComponentDocSectionSignature> {
  <template>
    <section class="space-y-4">
      <div>
        <h2
          class="scroll-m-20 border-b pb-2 text-2xl font-semibold tracking-tight"
        >{{@title}}</h2>
      </div>
      {{yield}}
    </section>
  </template>
}
