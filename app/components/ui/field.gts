import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
import Label from '@/components/ui/label';
import Separator from '@/components/ui/separator';

// FieldSet Component
interface FieldSetSignature {
  Element: HTMLFieldSetElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldSet extends Component<FieldSetSignature> {
  get classes() {
    return cn(
      'flex flex-col gap-6',
      'has-[>[data-slot=checkbox-group]]:gap-3 has-[>[data-slot=radio-group]]:gap-3',
      this.args.class
    );
  }

  <template>
    <fieldset data-slot="field-set" class={{this.classes}} ...attributes>
      {{yield}}
    </fieldset>
  </template>
}

// FieldLegend Component
interface FieldLegendSignature {
  Element: HTMLLegendElement;
  Args: {
    class?: string;
    variant?: 'legend' | 'label';
  };
  Blocks: {
    default: [];
  };
}

export class FieldLegend extends Component<FieldLegendSignature> {
  get variant() {
    return this.args.variant ?? 'legend';
  }

  get classes() {
    return cn(
      'mb-3 font-medium',
      'data-[variant=legend]:text-base',
      'data-[variant=label]:text-sm',
      this.args.class
    );
  }

  <template>
    <legend
      data-slot="field-legend"
      data-variant={{this.variant}}
      class={{this.classes}}
      ...attributes
    >
      {{yield}}
    </legend>
  </template>
}

// FieldGroup Component
interface FieldGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldGroup extends Component<FieldGroupSignature> {
  get classes() {
    return cn(
      'group/field-group @container/field-group flex w-full flex-col gap-7 data-[slot=checkbox-group]:gap-3 [&>[data-slot=field-group]]:gap-4',
      this.args.class
    );
  }

  <template>
    <div data-slot="field-group" class={{this.classes}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// Field Component
type Orientation = 'vertical' | 'horizontal' | 'responsive';

interface FieldSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    orientation?: Orientation;
  };
  Blocks: {
    default: [];
  };
}

function fieldVariants(orientation: Orientation = 'vertical', className?: string): string {
  const baseClasses = 'group/field data-[invalid=true]:text-destructive flex w-full gap-3';

  const orientationClasses: Record<Orientation, string> = {
    vertical: 'flex-col [&>*]:w-full [&>.sr-only]:w-auto',
    horizontal: [
      'flex-row items-center',
      '[&>[data-slot=field-label]]:flex-auto',
      'has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px has-[>[data-slot=field-content]]:items-start',
    ].join(' '),
    responsive: [
      '@md/field-group:flex-row @md/field-group:items-center @md/field-group:[&>*]:w-auto flex-col [&>*]:w-full [&>.sr-only]:w-auto',
      '@md/field-group:[&>[data-slot=field-label]]:flex-auto',
      '@md/field-group:has-[>[data-slot=field-content]]:items-start @md/field-group:has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px',
    ].join(' '),
  };

  return cn(baseClasses, orientationClasses[orientation], className);
}

export class Field extends Component<FieldSignature> {
  get orientation() {
    return this.args.orientation ?? 'vertical';
  }

  get classes() {
    return fieldVariants(this.orientation, this.args.class);
  }

  <template>
    <div
      role="group"
      data-slot="field"
      data-orientation={{this.orientation}}
      class={{this.classes}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// FieldContent Component
interface FieldContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldContent extends Component<FieldContentSignature> {
  get classes() {
    return cn(
      'group/field-content flex flex-1 flex-col gap-1.5 leading-snug',
      this.args.class
    );
  }

  <template>
    <div data-slot="field-content" class={{this.classes}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// FieldLabel Component
interface FieldLabelSignature {
  Element: HTMLLabelElement;
  Args: {
    class?: string;
    for?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldLabel extends Component<FieldLabelSignature> {
  get classes() {
    return cn(
      'group/field-label peer/field-label flex w-fit gap-2 leading-snug group-data-[disabled=true]/field:opacity-50',
      'has-[>[data-slot=field]]:w-full has-[>[data-slot=field]]:flex-col has-[>[data-slot=field]]:rounded-md has-[>[data-slot=field]]:border [&>[data-slot=field]]:p-4',
      'has-data-[state=checked]:bg-primary/5 has-data-[state=checked]:border-primary dark:has-data-[state=checked]:bg-primary/10',
      this.args.class
    );
  }

  <template>
    <Label data-slot="field-label" @class={{this.classes}} @for={{@for}} ...attributes>
      {{yield}}
    </Label>
  </template>
}

// FieldTitle Component
interface FieldTitleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldTitle extends Component<FieldTitleSignature> {
  get classes() {
    return cn(
      'flex w-fit items-center gap-2 text-sm font-medium leading-snug group-data-[disabled=true]/field:opacity-50',
      this.args.class
    );
  }

  <template>
    <div data-slot="field-label" class={{this.classes}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// FieldDescription Component
interface FieldDescriptionSignature {
  Element: HTMLParagraphElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldDescription extends Component<FieldDescriptionSignature> {
  get classes() {
    return cn(
      'text-muted-foreground text-sm font-normal leading-normal group-has-[[data-orientation=horizontal]]/field:text-balance',
      'nth-last-2:-mt-1 last:mt-0 [[data-variant=legend]+&]:-mt-1.5',
      '[&>a:hover]:text-primary [&>a]:underline [&>a]:underline-offset-4',
      this.args.class
    );
  }

  <template>
    <p data-slot="field-description" class={{this.classes}} ...attributes>
      {{yield}}
    </p>
  </template>
}

// FieldSeparator Component
interface FieldSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class FieldSeparator extends Component<FieldSeparatorSignature> {
  get hasContent() {
    return true; // Will be true if block content exists
  }

  get classes() {
    return cn(
      'relative -my-2 h-5 text-sm group-data-[variant=outline]/field-group:-mb-2',
      this.args.class
    );
  }

  <template>
    <div
      data-slot="field-separator"
      data-content={{this.hasContent}}
      class={{this.classes}}
      ...attributes
    >
      <Separator @class="absolute inset-0 top-1/2" />
      {{#if (has-block)}}
        <span
          class="bg-background text-muted-foreground relative mx-auto block w-fit px-2"
          data-slot="field-separator-content"
        >
          {{yield}}
        </span>
      {{/if}}
    </div>
  </template>
}

// FieldError Component
interface FieldErrorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    errors?: Array<{ message?: string } | undefined>;
  };
  Blocks: {
    default: [];
  };
}

export class FieldError extends Component<FieldErrorSignature> {
  get hasContent() {
    return this.content !== null;
  }

  get content() {
    // If block content exists, use it (checked in template)
    // Otherwise, process errors
    const errors = this.args.errors;

    if (!errors) {
      return null;
    }

    return errors;
  }

  get singleError() {
    const errors = this.args.errors;
    return errors?.length === 1 && errors[0]?.message ? errors[0].message : null;
  }

  get multipleErrors() {
    const errors = this.args.errors;
    return errors && errors.length > 1 ? errors.filter(e => e?.message) : null;
  }

  get classes() {
    return cn('text-destructive text-sm font-normal', this.args.class);
  }

  <template>
    {{#if (has-block)}}
      <div role="alert" data-slot="field-error" class={{this.classes}} ...attributes>
        {{yield}}
      </div>
    {{else if this.singleError}}
      <div role="alert" data-slot="field-error" class={{this.classes}} ...attributes>
        {{this.singleError}}
      </div>
    {{else if this.multipleErrors}}
      <div role="alert" data-slot="field-error" class={{this.classes}} ...attributes>
        <ul class="ml-4 flex list-disc flex-col gap-1">
          {{#each this.multipleErrors as |error|}}
            <li>{{error.message}}</li>
          {{/each}}
        </ul>
      </div>
    {{/if}}
  </template>
}
