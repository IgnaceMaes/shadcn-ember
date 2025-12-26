import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
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

export const InputOTP: TOC<InputOTPSignature> = <template>
  <div class={{cn "flex items-center gap-2" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

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

export const InputOTPGroup: TOC<InputOTPGroupSignature> = <template>
  <div class={{cn "flex items-center" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

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

export const InputOTPSlot: TOC<InputOTPSlotSignature> = <template>
  <div
    class={{cn
      "relative flex h-9 w-9 items-center justify-center border-y border-r border-input text-sm shadow-sm transition-all first:rounded-l-md first:border-l last:rounded-r-md"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

export const InputOTPSeparator: TOC<InputOTPSeparatorSignature> = <template>
  {{! template-lint-disable require-presentational-children }}
  <div role="separator" ...attributes>
    <Minus class="size-4" />
  </div>
</template>;

export default InputOTP;
