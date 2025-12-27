import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { hash } from '@ember/helper';
import { cn } from '@/lib/utils';
import Circle from '~icons/lucide/circle';

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

class RadioGroup extends Component<RadioGroupSignature> {
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
      class={{cn "grid gap-3" @class}}
      role="radiogroup"
      data-slot="radio-group"
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

class RadioGroupItem extends Component<RadioGroupItemSignature> {
  get checked() {
    return this.args.currentValue === this.args.value;
  }

  handleClick = () => {
    if (!this.args.disabled) {
      this.args.setValue?.(this.args.value);
    }
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
    <button
      type="button"
      role="radio"
      aria-checked={{this.checked}}
      data-slot="radio-group-item"
      class={{cn
        "border-input text-primary focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive dark:bg-input/30 aspect-square size-4 shrink-0 rounded-full border shadow-xs transition-[color,box-shadow] outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50"
        @class
      }}
      disabled={{@disabled}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{#if this.checked}}
        <span
          class="relative flex items-center justify-center"
          data-slot="radio-group-indicator"
        >
          <Circle
            class="fill-primary absolute top-1/2 left-1/2 size-2 -translate-x-1/2 -translate-y-1/2"
          />
        </span>
      {{/if}}
    </button>
  </template>
}

export { RadioGroup, RadioGroupItem };
