import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { hash } from '@ember/helper';
import { cn } from '@/lib/utils';
import { toggleVariants } from './toggle.gts';

type Variant = 'default' | 'outline';
type Size = 'default' | 'sm' | 'lg';

// ToggleGroup Root Component
interface ToggleGroupSignature {
  Element: HTMLDivElement;
  Args: {
    type?: 'single' | 'multiple';
    value?: string | string[];
    defaultValue?: string | string[];
    onValueChange?: (value: string | string[]) => void;
    disabled?: boolean;
    variant?: Variant;
    size?: Size;
    class?: string;
  };
  Blocks: {
    default: [
      {
        Item: typeof ToggleGroupItem;
      },
    ];
  };
}

export class ToggleGroup extends Component<ToggleGroupSignature> {
  @tracked internalValue: string | string[];

  constructor(owner: Owner, args: ToggleGroupSignature['Args']) {
    super(owner, args);
    const defaultVal = args.defaultValue ?? (args.type === 'multiple' ? [] : '');
    this.internalValue = args.value ?? defaultVal;
  }

  get value() {
    return this.args.value ?? this.internalValue;
  }

  get type() {
    return this.args.type ?? 'single';
  }

  toggleValue = (itemValue: string) => {
    if (this.args.disabled) return;

    let newValue: string | string[];

    if (this.type === 'multiple') {
      const currentValues = Array.isArray(this.value) ? this.value : [];
      if (currentValues.includes(itemValue)) {
        newValue = currentValues.filter((v) => v !== itemValue);
      } else {
        newValue = [...currentValues, itemValue];
      }
    } else {
      newValue = this.value === itemValue ? '' : itemValue;
    }

    this.internalValue = newValue;
    this.args.onValueChange?.(newValue);
  };

  isPressed = (itemValue: string): boolean => {
    if (this.type === 'multiple') {
      return Array.isArray(this.value) && this.value.includes(itemValue);
    }
    return this.value === itemValue;
  };

  <template>
    <div
      class={{cn "flex items-center justify-center gap-1" @class}}
      role="group"
      ...attributes
    >
      {{yield
        (hash
          Item=(component
            ToggleGroupItem
            toggleValue=this.toggleValue
            isPressed=this.isPressed
            variant=@variant
            size=@size
            disabled=@disabled
          )
        )
      }}
    </div>
  </template>
}

// ToggleGroupItem Component
interface ToggleGroupItemSignature {
  Element: HTMLButtonElement;
  Args: {
    value: string;
    toggleValue?: (value: string) => void;
    isPressed?: (value: string) => boolean;
    variant?: Variant;
    size?: Size;
    disabled?: boolean;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ToggleGroupItem extends Component<ToggleGroupItemSignature> {
  get classes() {
    return toggleVariants(
      this.args.variant ?? 'default',
      this.args.size ?? 'default',
      this.args.class
    );
  }

  get pressed() {
    return this.args.isPressed?.(this.args.value) ?? false;
  }

  handleClick = () => {
    this.args.toggleValue?.(this.args.value);
  };

  <template>
    <button
      type="button"
      class={{this.classes}}
      disabled={{@disabled}}
      data-state={{if this.pressed "on" "off"}}
      aria-pressed={{this.pressed}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

export default ToggleGroup;
