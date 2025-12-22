/* eslint-disable ember/no-empty-glimmer-component-classes */
import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { hash, fn } from '@ember/helper';
// import PhCaretDown from 'ember-phosphor-icons/components/ph-caret-down';
// import PhCaretUp from 'ember-phosphor-icons/components/ph-caret-up';
// import PhCheck from 'ember-phosphor-icons/components/ph-check';
import ChevronDown from '~icons/lucide/chevron-down';
import ChevronUp from '~icons/lucide/chevron-up';
import Check from '~icons/lucide/check';
import { cn } from '@/lib/utils';

// Select Root Component
interface SelectSignature {
  Element: HTMLDivElement;
  Args: {
    value?: string;
    defaultValue?: string;
    onValueChange?: (value: string) => void;
    disabled?: boolean;
    name?: string;
    required?: boolean;
  };
  Blocks: {
    default: [
      {
        isOpen: boolean;
        value: string;
        toggle: () => void;
        close: () => void;
        selectValue: (value: string) => void;
      },
    ];
  };
}

export class Select extends Component<SelectSignature> {
  @tracked isOpen = false;
  @tracked selectedValue = this.args.value ?? this.args.defaultValue ?? '';

  get value() {
    return this.args.value ?? this.selectedValue;
  }

  toggle = () => {
    if (!this.args.disabled) {
      this.isOpen = !this.isOpen;
    }
  };

  close = () => {
    this.isOpen = false;
  };

  selectValue = (value: string) => {
    this.selectedValue = value;
    this.isOpen = false;

    if (this.args.onValueChange) {
      this.args.onValueChange(value);
    }
  };

  <template>
    <div class="relative inline-block w-full" ...attributes>
      {{yield
        (hash
          isOpen=this.isOpen
          value=this.value
          toggle=this.toggle
          close=this.close
          selectValue=this.selectValue
        )
      }}
    </div>
  </template>
}

// SelectTrigger Component
interface SelectTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    disabled?: boolean;
    toggle?: () => void;
  };
  Blocks: {
    default: [];
  };
}

export class SelectTrigger extends Component<SelectTriggerSignature> {
  <template>
    <button
      type="button"
      class={{cn
        "flex h-9 w-full items-center justify-between whitespace-nowrap rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50 [&>span]:line-clamp-1"
        @class
      }}
      disabled={{@disabled}}
      {{on "click" (if @toggle @toggle (fn))}}
      ...attributes
    >
      {{yield}}
      <ChevronDown class="size-4 opacity-50" />
    </button>
  </template>
}

// SelectValue Component
interface SelectValueSignature {
  Element: HTMLSpanElement;
  Args: {
    placeholder?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SelectValue extends Component<SelectValueSignature> {
  <template>
    <span class="block truncate" ...attributes>
      {{#if (has-block)}}
        {{yield}}
      {{else}}
        {{@placeholder}}
      {{/if}}
    </span>
  </template>
}

// SelectContent Component
interface SelectContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    position?: 'popper' | 'item-aligned';
    isOpen?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class SelectContent extends Component<SelectContentSignature> {
  get positionClass() {
    return this.args.position === 'popper'
      ? 'data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1'
      : '';
  }

  <template>
    {{#if @isOpen}}
      <div
        class={{cn
          "absolute top-full left-0 z-50 mt-1 max-h-96 w-full min-w-[8rem] overflow-auto rounded-md border bg-popover text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95"
          this.positionClass
          @class
        }}
        ...attributes
      >
        <div class="p-1">
          {{yield}}
        </div>
      </div>
    {{/if}}
  </template>
}

// SelectGroup Component
interface SelectGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SelectGroup extends Component<SelectGroupSignature> {
  <template>
    <div class={{cn "py-1" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// SelectLabel Component
interface SelectLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SelectLabel extends Component<SelectLabelSignature> {
  <template>
    <div
      class={{cn "px-2 py-1.5 text-sm font-semibold" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// SelectItem Component
interface SelectItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    value: string;
    disabled?: boolean;
    onSelect?: (value: string) => void;
    selectedValue?: string;
  };
  Blocks: {
    default: [];
  };
}

export class SelectItem extends Component<SelectItemSignature> {
  get isSelected() {
    return this.args.value === this.args.selectedValue;
  }

  handleClick = () => {
    if (!this.args.disabled && this.args.onSelect) {
      this.args.onSelect(this.args.value);
    }
  };

  <template>
    <div
      role="option"
      class={{cn
        "relative flex w-full cursor-pointer select-none items-center rounded-sm py-1.5 pl-2 pr-8 text-sm outline-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
        @class
      }}
      data-disabled={{if @disabled "true"}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{#if this.isSelected}}
        <span class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
          <Check class="size-4" />
        </span>
      {{/if}}
      {{yield}}
    </div>
  </template>
}

// SelectSeparator Component
interface SelectSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

export class SelectSeparator extends Component<SelectSeparatorSignature> {
  <template>
    <div class={{cn "-mx-1 my-1 h-px bg-muted" @class}} ...attributes></div>
  </template>
}

// SelectScrollUpButton Component
interface SelectScrollUpButtonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

export class SelectScrollUpButton extends Component<SelectScrollUpButtonSignature> {
  <template>
    <div
      class={{cn "flex cursor-default items-center justify-center py-1" @class}}
      ...attributes
    >
      <ChevronUp class="size-4" />
    </div>
  </template>
}

// SelectScrollDownButton Component
interface SelectScrollDownButtonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

export class SelectScrollDownButton extends Component<SelectScrollDownButtonSignature> {
  <template>
    <div
      class={{cn "flex cursor-default items-center justify-center py-1" @class}}
      ...attributes
    >
      <ChevronDown class="size-4" />
    </div>
  </template>
}
