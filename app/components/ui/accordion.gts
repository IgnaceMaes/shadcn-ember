import Component from '@glimmer/component';
import type { ComponentLike } from '@glint/template';
import type { TOC } from '@ember/component/template-only';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import ChevronDown from '~icons/lucide/chevron-down';
import { cn } from '@/lib/utils';

interface AccordionItemSignature {
  Element: HTMLDivElement;
  Args: {
    value: string;
    class?: string;
    disabled?: boolean;
  };
  Blocks: {
    default: [
      ComponentLike<AccordionTriggerSignature>,
      ComponentLike<AccordionContentSignature>,
    ];
  };
}

interface AccordionTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    isOpen?: boolean;
    toggle: () => void;
  };
  Blocks: {
    default: [];
  };
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

interface AccordionSignature {
  Element: HTMLDivElement;
  Args: {
    type?: 'single' | 'multiple';
    value?: string | string[];
    onValueChange?: (value: string | string[]) => void;
    collapsible?: boolean;
    disabled?: boolean;
    class?: string;
  };
  Blocks: {
    default: [ComponentLike<AccordionItemSignature>];
  };
}

const AccordionTrigger: TOC<AccordionTriggerSignature> = <template>
  <h3 class="flex">
    <button
      type="button"
      data-state={{if @isOpen "open" "closed"}}
      class={{cn
        "flex flex-1 items-center justify-between py-4 text-sm font-medium transition-all hover:underline text-left [&[data-state=open]>svg]:rotate-180"
        @class
      }}
      {{on "click" @toggle}}
      ...attributes
    >
      {{yield}}
      <ChevronDown
        class="size-4 shrink-0 text-muted-foreground transition-transform duration-200"
      />
    </button>
  </h3>
</template>;

const AccordionContent: TOC<AccordionContentSignature> = <template>
  <div
    data-state={{if @isOpen "open" "closed"}}
    class="data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down overflow-hidden text-sm"
    hidden={{unless @isOpen true}}
    ...attributes
  >
    <div class={{cn "pb-4 pt-0" @class}}>
      {{yield}}
    </div>
  </div>
</template>;

class Accordion extends Component<AccordionSignature> {
  @tracked internalValue: string | string[] =
    this.args.value ?? (this.args.type === 'multiple' ? [] : '');

  get value() {
    return this.args.value ?? this.internalValue;
  }

  get type() {
    return this.args.type ?? 'single';
  }

  setValue = (newValue: string | string[]) => {
    this.internalValue = newValue;
    this.args.onValueChange?.(newValue);
  };

  isOpen = (itemValue: string) => {
    if (Array.isArray(this.value)) {
      return this.value.includes(itemValue);
    }
    return this.value === itemValue;
  };

  toggle = (itemValue: string, disabled?: boolean) => {
    if (disabled || this.args.disabled) return;

    if (this.type === 'multiple' && Array.isArray(this.value)) {
      const isCurrentlyOpen = this.value.includes(itemValue);
      const newValue = isCurrentlyOpen
        ? this.value.filter((v) => v !== itemValue)
        : [...this.value, itemValue];
      this.setValue(newValue);
    } else {
      const isCurrentlyOpen = this.value === itemValue;
      const newValue =
        isCurrentlyOpen && this.args.collapsible ? '' : itemValue;
      this.setValue(newValue);
    }
  };

  Item = <template>
    {{#let (this.isOpen @value) as |isOpen|}}
      <div
        data-state={{if isOpen "open" "closed"}}
        data-disabled={{if @disabled "true"}}
        class={{cn "border-b last:border-b-0" @class}}
        ...attributes
      >
        {{yield
          (component
            AccordionTrigger
            isOpen=isOpen
            toggle=(fn this.toggle @value @disabled)
          )
          (component AccordionContent isOpen=isOpen)
        }}
      </div>
    {{/let}}
  </template> as ComponentLike<AccordionItemSignature>;

  <template>
    <div data-orientation="vertical" class={{@class}} ...attributes>
      {{yield this.Item}}
    </div>
  </template>
}

export { Accordion, AccordionTrigger, AccordionContent };
