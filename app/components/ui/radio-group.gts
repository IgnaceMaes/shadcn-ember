import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { hash } from '@ember/helper';
import { cn } from '@/lib/utils';

// RadioGroup Root Component
interface RadioGroupSignature {
  Element: HTMLDivElement;
  Args: {
    value?: string;
    defaultValue?: string;
    onValueChange?: (value: string) => void;
    disabled?: boolean;
    class?: string;
  };
  Blocks: {
    default: [state: { value: string; setValue: (value: string) => void }];
  };
}

export class RadioGroup extends Component<RadioGroupSignature> {
  @tracked internalValue: string;

  constructor(owner: Owner, args: RadioGroupSignature['Args']) {
    super(owner, args);
    this.internalValue = args.value ?? args.defaultValue ?? '';
  }

  get value() {
    return this.args.value ?? this.internalValue;
  }

  setValue = (value: string) => {
    if (!this.args.disabled) {
      this.internalValue = value;
      this.args.onValueChange?.(value);
    }
  };

  <template>
    <div
      class={{cn "grid gap-2" @class}}
      role="radiogroup"
      ...attributes
    >
      {{yield (hash value=this.value setValue=this.setValue)}}
    </div>
  </template>
}

// RadioGroupItem Component
interface RadioGroupItemSignature {
  Element: HTMLButtonElement;
  Args: {
    value: string;
    currentValue?: string;
    setValue?: (value: string) => void;
    disabled?: boolean;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class RadioGroupItem extends Component<RadioGroupItemSignature> {
  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleClick = () => {
    if (!this.args.disabled) {
      this.args.setValue?.(this.args.value);
    }
  };

  <template>
    <button
      type="button"
      role="radio"
      aria-checked={{this.checked}}
      class={{cn
        "aspect-square h-4 w-4 rounded-full border border-primary text-primary shadow focus:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
        @class
      }}
      disabled={{@disabled}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{#if this.checked}}
        <span class="flex items-center justify-center">
          <span class="h-2.5 w-2.5 rounded-full bg-current"></span>
        </span>
      {{/if}}
    </button>
  </template>
}

export default RadioGroup;
