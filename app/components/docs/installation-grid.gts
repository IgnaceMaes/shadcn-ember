import { LinkTo } from '@ember/routing';
import type { TOC } from '@ember/component/template-only';
import ViteIcon from '~icons/simple-icons/vite';
import AstroIcon from '~icons/simple-icons/astro';

const InstallationGrid: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="mt-8 grid gap-4 sm:grid-cols-2 sm:gap-6" ...attributes>
    <LinkTo
      @route="docs.catch-all"
      @model="installation/vite"
      class="bg-surface text-surface-foreground hover:bg-surface/80 flex w-full flex-col items-center rounded-xl p-6 transition-colors sm:p-10"
    >
      <ViteIcon class="h-10 w-10" />
      <p class="mt-2 font-medium">Vite</p>
    </LinkTo>
    <LinkTo
      @route="docs.catch-all"
      @model="installation/astro"
      class="bg-surface text-surface-foreground hover:bg-surface/80 flex w-full flex-col items-center rounded-xl p-6 transition-colors sm:p-10"
    >
      <AstroIcon class="h-10 w-10" />
      <p class="mt-2 font-medium">Astro</p>
    </LinkTo>
  </div>
</template>;

export default InstallationGrid;
