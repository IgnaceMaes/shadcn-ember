import type { TOC } from '@ember/component/template-only';

interface ComponentDocPageSignature {
  Blocks: {
    default: [];
  };
}

const ComponentDocPage: TOC<ComponentDocPageSignature> = <template>
  <div class="mx-auto w-full min-w-0 max-w-4xl">
    {{yield}}
  </div>
</template>;

export default ComponentDocPage;
