import type { TOC } from '@ember/component/template-only';

interface Signature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default <template>
  <div class="mb-4 ml-4 mt-6 border-l pl-6 [counter-reset:step]" ...attributes>
    {{yield}}
  </div>
</template> satisfies TOC<Signature>;
