import type { TOC } from '@ember/component/template-only';

interface ComponentDocSectionSignature {
  Args: {
    title: string;
  };
  Blocks: {
    default: [];
  };
}

const ComponentDocSection: TOC<ComponentDocSectionSignature> = <template>
  <section class="space-y-4">
    <div>
      <h2
        class="scroll-m-20 border-b pb-2 text-2xl font-semibold tracking-tight"
      >{{@title}}</h2>
    </div>
    {{yield}}
  </section>
</template>;

export default ComponentDocSection;
