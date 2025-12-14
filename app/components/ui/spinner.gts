import Component from '@glimmer/component';
import PhSpinner from 'ember-phosphor-icons/components/ph-spinner';
import { cn } from '@/lib/utils';

interface SpinnerSignature {
  Element: HTMLOrSVGElement;
  Args: {
    class?: string;
    size?: number;
  };
}

export class Spinner extends Component<SpinnerSignature> {
  <template>
    <PhSpinner
      @size={{if @size @size 16}}
      role="status"
      aria-label="Loading"
      class={{cn "animate-spin" @class}}
      ...attributes
    />
  </template>
}

export default Spinner;
