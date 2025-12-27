import type { TOC } from '@ember/component/template-only';
import Loader from '~icons/lucide/loader';
import { cn } from '@/lib/utils';

interface CustomSpinnerSignature {
  Element: HTMLOrSVGElement;
  Args: {
    class?: string;
  };
}

const CustomSpinner: TOC<CustomSpinnerSignature> = <template>
  <Loader
    role="status"
    aria-label="Loading"
    class={{cn "size-4 animate-spin" @class}}
    ...attributes
  />
</template>;

const SpinnerCustom: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex items-center gap-4">
    <CustomSpinner />
  </div>
</template>;

export default SpinnerCustom;
