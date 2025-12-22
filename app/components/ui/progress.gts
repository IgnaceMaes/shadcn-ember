import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface ProgressSignature {
  Element: HTMLDivElement;
  Args: {
    value?: number;
    max?: number;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class Progress extends Component<ProgressSignature> {
  get progressValue() {
    const value = this.args.value ?? 0;
    const max = this.args.max ?? 100;
    return Math.min(100, (value / max) * 100);
  }

  get indicatorStyle() {
    return `transform: translateX(-${100 - this.progressValue}%)`;
  }

  <template>
    <div
      role="progressbar"
      aria-valuemin="0"
      aria-valuemax={{if @max @max 100}}
      aria-valuenow={{@value}}
      class={{cn
        "relative h-2 w-full overflow-hidden rounded-full bg-primary/20"
        @class
      }}
      ...attributes
    >
      <div
        class="h-full w-full flex-1 bg-primary transition-all"
        style={{this.indicatorStyle}}
      ></div>
    </div>
  </template>
}

export default Progress;
