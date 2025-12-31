import { Spinner } from '@/components/ui/spinner';

import type { TOC } from '@ember/component/template-only';

const SpinnerSize: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex items-center gap-6">
    <Spinner @class="size-3" />
    <Spinner @class="size-4" />
    <Spinner @class="size-6" />
    <Spinner @class="size-8" />
  </div>
</template>;

export default SpinnerSize;
