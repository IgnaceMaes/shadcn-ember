/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
// import PhMinus from 'ember-phosphor-icons/components/ph-minus';
import Minus from '~icons/lucide/minus';

// Note: This is a placeholder for the InputOTP component
// Full implementation would require the input-otp library or custom implementation

// InputOTP Root Component
interface InputOTPSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    maxLength?: number;
    value?: string;
    onChange?: (value: string) => void;
  };
  Blocks: {
    default: [];
  };
}

export class InputOTP extends Component<InputOTPSignature> {
  <template>
    <div
      class={{cn "flex items-center gap-2" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// InputOTPGroup Component
interface InputOTPGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class InputOTPGroup extends Component<InputOTPGroupSignature> {
  <template>
    <div class={{cn "flex items-center" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// InputOTPSlot Component
interface InputOTPSlotSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    index: number;
  };
  Blocks: {
    default: [];
  };
}

export class InputOTPSlot extends Component<InputOTPSlotSignature> {
  <template>
    <div
      class={{cn
        "relative flex h-9 w-9 items-center justify-center border-y border-r border-input text-sm shadow-sm transition-all first:rounded-l-md first:border-l last:rounded-r-md"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// InputOTPSeparator Component
interface InputOTPSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class InputOTPSeparator extends Component<InputOTPSeparatorSignature> {
  <template>
    <div role="separator" ...attributes>
      <Minus class="size-4" />
    </div>
  </template>
}

export default InputOTP;
