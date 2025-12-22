import type { TOC } from '@ember/component/template-only';
// import PhSpinner from 'ember-phosphor-icons/components/ph-spinner';
import Loader2 from '~icons/lucide/loader-2';
import { cn } from '@/lib/utils';
import { concat } from '@ember/helper';

interface SpinnerSignature {
  Element: HTMLOrSVGElement;
  Args: {
    class?: string;
    size?: number;
  };
}

const Spinner: TOC<SpinnerSignature> = <template>
  <Loader2
    role="status"
    aria-label="Loading"
    class={{cn
      "animate-spin"
      (if @size (concat "size-" @size) "size-4")
      @class
    }}
    ...attributes
  />
</template>;

export default Spinner;
export { Spinner };
