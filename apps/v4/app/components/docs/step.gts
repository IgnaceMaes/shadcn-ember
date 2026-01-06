import type { TOC } from '@ember/component/template-only';

interface Signature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default <template>
  <div
    class="[counter-increment:step] before:absolute before:-left-[calc(1.5rem+1px)] before:top-0 before:flex before:h-6 before:w-6 before:items-center before:justify-center before:rounded-full before:border before:bg-background before:text-xs before:font-semibold before:content-[counter(step)] mb-4 relative"
    ...attributes
  >
    {{yield}}
  </div>
</template> satisfies TOC<Signature>;
