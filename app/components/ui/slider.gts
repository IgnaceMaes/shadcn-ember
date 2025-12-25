import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import { get } from '@ember/helper';

// Slider Root Component
interface SliderSignature {
  Element: HTMLDivElement;
  Args: {
    value?: number[];
    defaultValue?: number[];
    onValueChange?: (value: number[]) => void;
    min?: number;
    max?: number;
    step?: number;
    disabled?: boolean;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class Slider extends Component<SliderSignature> {
  @tracked internalValue: number[];

  constructor(owner: Owner, args: SliderSignature['Args']) {
    super(owner, args);
    this.internalValue = args.value ?? args.defaultValue ?? [0];
  }

  get value() {
    return this.args.value ?? this.internalValue;
  }

  get min() {
    return this.args.min ?? 0;
  }

  get max() {
    return this.args.max ?? 100;
  }

  get step() {
    return this.args.step ?? 1;
  }

  get percentage() {
    const val = this.value[0] ?? 0;
    return ((val - this.min) / (this.max - this.min)) * 100;
  }

  handleInput = (event: Event) => {
    const target = event.target as HTMLInputElement;
    const newValue = [parseFloat(target.value)];
    this.internalValue = newValue;
    this.args.onValueChange?.(newValue);
  };

  <template>
    <div
      class={{cn
        "relative flex w-full touch-none select-none items-center"
        @class
      }}
      ...attributes
    >
      <div
        class="relative h-1.5 w-full grow overflow-hidden rounded-full bg-primary/20"
      >
        <div
          class="absolute h-full bg-primary"
          style="width: {{this.percentage}}"
        ></div>
      </div>
      <input
        type="range"
        min={{this.min}}
        max={{this.max}}
        step={{this.step}}
        value={{get this.value "0"}}
        disabled={{@disabled}}
        class="absolute inset-0 w-full h-full opacity-0 cursor-pointer disabled:cursor-not-allowed"
        {{on "input" this.handleInput}}
      />
      <div
        class="block h-4 w-4 rounded-full border border-primary/50 bg-background shadow transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 absolute"
        style="left: {{this.percentage}}%; transform: translateX(-50%)"
      ></div>
    </div>
  </template>
}

export default Slider;
