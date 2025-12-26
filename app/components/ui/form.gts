import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
import Label from './label.gts';

// Note: This is a placeholder for the Form component
// Full implementation would require react-hook-form or a similar form library
// In Ember, you might use ember-changeset or similar form validation libraries

// Form Root Component (acts as a provider)
interface FormSignature {
  Blocks: {
    default: [];
  };
}

export const Form: TOC<FormSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

// FormField Component
interface FormFieldSignature {
  Args: {
    name: string;
  };
  Blocks: {
    default: [];
  };
}

export const FormField: TOC<FormFieldSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

// FormItem Component
interface FormItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const FormItem: TOC<FormItemSignature> = <template>
  <div class={{cn "space-y-2" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

// FormLabel Component
interface FormLabelSignature {
  Element: HTMLLabelElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const FormLabel: TOC<FormLabelSignature> = <template>
  <Label class={{cn @class}} ...attributes>
    {{yield}}
  </Label>
</template>;

// FormControl Component
interface FormControlSignature {
  Blocks: {
    default: [];
  };
}

export const FormControl: TOC<FormControlSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

// FormDescription Component
interface FormDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const FormDescription: TOC<FormDescriptionSignature> = <template>
  <p class={{cn "text-[0.8rem] text-muted-foreground" @class}} ...attributes>
    {{yield}}
  </p>
</template>;

// FormMessage Component
interface FormMessageSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const FormMessage: TOC<FormMessageSignature> = <template>
  <p
    class={{cn "text-[0.8rem] font-medium text-destructive" @class}}
    ...attributes
  >
    {{yield}}
  </p>
</template>;

export default Form;
