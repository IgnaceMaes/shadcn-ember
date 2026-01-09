import { LinkTo } from '@ember/routing';

import type { TOC } from '@ember/component/template-only';

import AstroIcon from '~icons/simple-icons/astro';
import EmberIcon from '~icons/simple-icons/emberdotjs';
import ViteIcon from '~icons/simple-icons/vite';

const InstallationGrid: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="mt-8 grid gap-4 sm:grid-cols-2 sm:gap-6" ...attributes>
    <LinkTo
      @model="installation/vite"
      @route="docs.catch-all"
      class="bg-surface text-surface-foreground hover:bg-surface/80 flex w-full flex-col items-center rounded-xl p-6 transition-colors sm:p-10"
    >
      <ViteIcon class="h-10 w-10" />
      <p class="mt-2 font-medium">Vite</p>
    </LinkTo>
    <LinkTo
      @model="installation/astro"
      @route="docs.catch-all"
      class="bg-surface text-surface-foreground hover:bg-surface/80 flex w-full flex-col items-center rounded-xl p-6 transition-colors sm:p-10"
    >
      <AstroIcon class="h-10 w-10" />
      <p class="mt-2 font-medium">Astro</p>
    </LinkTo>
    <LinkTo
      @model="installation/manual"
      @route="docs.catch-all"
      class="bg-surface text-surface-foreground hover:bg-surface/80 flex w-full flex-col items-center rounded-xl p-6 transition-colors sm:p-10"
    >
      <EmberIcon class="h-10 w-10 rounded-full" />
      <p class="mt-2 font-medium">Manual</p>
    </LinkTo>
  </div>
</template>;

export default InstallationGrid;
