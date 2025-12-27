import type { TOC } from '@ember/component/template-only';
import { Spinner } from '@/components/ui/spinner';

const SpinnerColor: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex items-center gap-6">
    <Spinner @class="size-6 text-red-500" />
    <Spinner @class="size-6 text-green-500" />
    <Spinner @class="size-6 text-blue-500" />
    <Spinner @class="size-6 text-yellow-500" />
    <Spinner @class="size-6 text-purple-500" />
  </div>
</template>;

export default SpinnerColor;
