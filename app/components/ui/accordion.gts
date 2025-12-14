/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
// import PhCaretDown from 'ember-phosphor-icons/components/ph-caret-down';
import ChevronDown from '~icons/lucide/chevron-down';
import { cn } from '@/lib/utils';

interface AccordionSignature {
  Args: {
    type?: 'single' | 'multiple';
    value?: string | string[];
    onValueChange?: (value: string | string[]) => void;
    collapsible?: boolean;
    disabled?: boolean;
  };
  Blocks: {
    default: [value: string | string[], setValue: (value: string | string[]) => void];
  };
}

export class Accordion extends Component<AccordionSignature> {
  @tracked internalValue: string | string[] = this.args.value ?? (this.args.type === 'multiple' ? [] : '');

  get value() {
    return this.args.value ?? this.internalValue;
  }

  setValue = (newValue: string | string[]) => {
    this.internalValue = newValue;
    this.args.onValueChange?.(newValue);
  };

  <template>
    <div data-orientation="vertical" ...attributes>
      {{yield this.value this.setValue}}
    </div>
  </template>
}

interface AccordionItemSignature {
  Element: HTMLDivElement;
  Args: {
    value: string;
    class?: string;
    disabled?: boolean;
    currentValue?: string | string[];
    setValue?: (value: string | string[]) => void;
    type?: 'single' | 'multiple';
  };
  Blocks: {
    default: [isOpen: boolean, toggle: () => void];
  };
}

export class AccordionItem extends Component<AccordionItemSignature> {
  get isOpen() {
    const currentValue = this.args.currentValue;
    if (Array.isArray(currentValue)) {
      return currentValue.includes(this.args.value);
    }
    return currentValue === this.args.value;
  }

  toggle = () => {
    if (this.args.disabled) return;

    const type = this.args.type ?? 'single';
    const currentValue = this.args.currentValue;

    if (type === 'multiple' && Array.isArray(currentValue)) {
      const newValue = this.isOpen
        ? currentValue.filter((v) => v !== this.args.value)
        : [...currentValue, this.args.value];
      this.args.setValue?.(newValue);
    } else {
      const newValue = this.isOpen ? '' : this.args.value;
      this.args.setValue?.(newValue);
    }
  };

  <template>
    <div
      data-state={{if this.isOpen "open" "closed"}}
      data-disabled={{if @disabled "true"}}
      class={{cn "border-b" @class}}
      ...attributes
    >
      {{yield this.isOpen this.toggle}}
    </div>
  </template>
}

interface AccordionTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    isOpen?: boolean;
    toggle?: () => void;
  };
  Blocks: {
    default: [];
  };
}

export class AccordionTrigger extends Component<AccordionTriggerSignature> {
  handleClick = () => {
    this.args.toggle?.();
  };

  <template>
    <h3 class="flex">
      <button
        type="button"
        data-state={{if @isOpen "open" "closed"}}
        class={{cn
          "flex flex-1 items-center justify-between py-4 text-sm font-medium transition-all hover:underline text-left [&[data-state=open]>svg]:rotate-180"
          @class
        }}
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
        <ChevronDown
          class="size-4 shrink-0 text-muted-foreground transition-transform duration-200"
        />
      </button>
    </h3>
  </template>
}

interface AccordionContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class AccordionContent extends Component<AccordionContentSignature> {
  <template>
    {{#if @isOpen}}
      <div
        class="overflow-hidden text-sm data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down"
        data-state={{if @isOpen "open" "closed"}}
        ...attributes
      >
        <div class={{cn "pb-4 pt-0" @class}}>
          {{yield}}
        </div>
      </div>
    {{/if}}
  </template>
}
