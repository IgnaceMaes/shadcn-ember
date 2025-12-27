import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike, ModifierLike } from '@glint/template';
import { on } from '@ember/modifier';
import { hash, fn } from '@ember/helper';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { Popover } from 'ember-primitives';
import ChevronDown from '~icons/lucide/chevron-down';
import ChevronUp from '~icons/lucide/chevron-up';
import Check from '~icons/lucide/check';
import { cn } from '@/lib/utils';

interface SelectSignature {
  Args: {
    value?: string;
    defaultValue?: string;
    onValueChange?: (value: string) => void;
    disabled?: boolean;
    name?: string;
    required?: boolean;
    placement?:
      | 'top'
      | 'right'
      | 'bottom'
      | 'left'
      | 'top-start'
      | 'top-end'
      | 'right-start'
      | 'right-end'
      | 'bottom-start'
      | 'bottom-end'
      | 'left-start'
      | 'left-end';
    offsetOptions?: number;
  };
  Blocks: {
    default: [
      {
        Trigger: ComponentLike<SelectTriggerSignature>;
        Value: ComponentLike<SelectValueSignature>;
        Content: ComponentLike<SelectContentSignature>;
        value: string;
        selectValue: (value: string) => void;
      },
    ];
  };
}

class Select extends Component<SelectSignature> {
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
    this.args.onValueChange?.(value);
  };

  <template>
    <Popover
      @placement={{if @placement @placement "bottom-start"}}
      @offsetOptions={{if @offsetOptions @offsetOptions 4}}
      as |p|
    >
      {{yield
        (hash
          Trigger=(component
            SelectTrigger
            reference=p.reference
            toggle=this.toggle
            disabled=@disabled
          )
          Value=(component SelectValue value=this.value)
          Content=(component
            SelectContent
            isOpen=this.isOpen
            popoverContent=p.Content
            close=this.close
            selectValue=this.selectValue
            selectedValue=this.value
          )
          value=this.value
          selectValue=this.selectValue
        )
      }}
    </Popover>
  </template>
}

interface SelectTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    size?: 'sm' | 'default';
    disabled?: boolean;
    toggle?: () => void;
    reference?: ModifierLike<{
      Element: HTMLElement | SVGElement;
    }>;
  };
  Blocks: {
    default: [];
  };
}

class SelectTrigger extends Component<SelectTriggerSignature> {
  get sizeClass() {
    return this.args.size === 'sm' ? 'h-8' : 'h-9';
  }

  <template>
    <button
      type="button"
      data-slot="select-trigger"
      data-size={{if @size @size "default"}}
      class={{cn
        "border-input data-placeholder:text-muted-foreground [&_svg:not([class*='text-'])]:text-muted-foreground focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive dark:bg-input/30 dark:hover:bg-input/50 flex w-fit items-center justify-between gap-2 rounded-md border bg-transparent px-3 py-2 text-sm whitespace-nowrap shadow-xs transition-[color,box-shadow] outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50"
        this.sizeClass
        "*:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:flex *:data-[slot=select-value]:items-center *:data-[slot=select-value]:gap-2 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      disabled={{@disabled}}
      {{@reference}}
      {{on "click" (if @toggle @toggle (fn))}}
      ...attributes
    >
      {{yield}}
      <ChevronDown class="size-4 opacity-50" />
    </button>
  </template>
}

interface SelectValueSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
    placeholder?: string;
    value?: string;
  };
  Blocks: {
    default: [];
  };
}

const SelectValue: TOC<SelectValueSignature> = <template>
  <span data-slot="select-value" class={{cn @class}} ...attributes>
    {{#if (has-block)}}
      {{yield}}
    {{else if @value}}
      {{@value}}
    {{else}}
      {{@placeholder}}
    {{/if}}
  </span>
</template>;

interface SelectContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    position?: 'popper' | 'item-aligned';
    align?: 'center' | 'start' | 'end';
    isOpen?: boolean;
    close?: () => void;
    selectValue?: (value: string) => void;
    selectedValue?: string;
    popoverContent?: ComponentLike<{
      Element: HTMLDivElement;
      Args: { as?: string; class?: string };
      Blocks: { default: [] };
    }>;
  };
  Blocks: {
    default: [
      {
        Item: ComponentLike<SelectItemSignature>;
      },
    ];
  };
}

class SelectContent extends Component<SelectContentSignature> {
  get positionClass() {
    return this.args.position === 'popper'
      ? 'data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1'
      : '';
  }

  handleClickOutside = () => {
    this.args.close?.();
  };

  <template>
    {{#if @isOpen}}
      {{#let @popoverContent as |Content|}}
        <Content
          @as="div"
          data-slot="select-content"
          class={{cn
            "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 relative z-50 max-h-96 min-w-32 overflow-x-hidden overflow-y-auto rounded-md border shadow-md"
            this.positionClass
            @class
          }}
          data-state={{if @isOpen "open" "closed"}}
          role="listbox"
          {{onClickOutside this.handleClickOutside}}
          ...attributes
        >
          <SelectScrollUpButton />
          <div class="p-1">
            {{yield
              (hash
                Item=(component
                  SelectItem
                  selectValue=@selectValue
                  selectedValue=@selectedValue
                )
              )
            }}
          </div>
          <SelectScrollDownButton />
        </Content>
      {{/let}}
    {{/if}}
  </template>
}

interface SelectGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const SelectGroup: TOC<SelectGroupSignature> = <template>
  <div data-slot="select-group" class={{cn @class}} ...attributes>
    {{yield}}
  </div>
</template>;

interface SelectLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const SelectLabel: TOC<SelectLabelSignature> = <template>
  <div
    data-slot="select-label"
    class={{cn "text-muted-foreground px-2 py-1.5 text-xs" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface SelectItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    value: string;
    disabled?: boolean;
    selectValue?: (value: string) => void;
    selectedValue?: string;
  };
  Blocks: {
    default: [];
  };
}

class SelectItem extends Component<SelectItemSignature> {
  get isSelected() {
    return this.args.value === this.args.selectedValue;
  }

  handleClick = () => {
    if (!this.args.disabled && this.args.selectValue) {
      this.args.selectValue(this.args.value);
    }
  };

  <template>
    {{! template-lint-disable require-mandatory-role-attributes require-presentational-children }}
    <div
      role="option"
      data-slot="select-item"
      class={{cn
        "focus:bg-accent focus:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground relative flex w-full cursor-default items-center gap-2 rounded-sm py-1.5 pr-8 pl-2 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 *:[span]:last:flex *:[span]:last:items-center *:[span]:last:gap-2"
        @class
      }}
      data-disabled={{if @disabled "true"}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span
        data-slot="select-item-indicator"
        class="absolute right-2 flex size-3.5 items-center justify-center"
      >
        {{#if this.isSelected}}
          <Check class="size-4" />
        {{/if}}
      </span>
      {{yield}}
    </div>
  </template>
}

interface SelectSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

const SelectSeparator: TOC<SelectSeparatorSignature> = <template>
  <div
    data-slot="select-separator"
    class={{cn "bg-border pointer-events-none -mx-1 my-1 h-px" @class}}
    ...attributes
  ></div>
</template>;

interface SelectScrollUpButtonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

const SelectScrollUpButton: TOC<SelectScrollUpButtonSignature> = <template>
  <div
    data-slot="select-scroll-up-button"
    class={{cn "flex cursor-default items-center justify-center py-1" @class}}
    ...attributes
  >
    <ChevronUp class="size-4" />
  </div>
</template>;

interface SelectScrollDownButtonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
}

const SelectScrollDownButton: TOC<SelectScrollDownButtonSignature> = <template>
  <div
    data-slot="select-scroll-down-button"
    class={{cn "flex cursor-default items-center justify-center py-1" @class}}
    ...attributes
  >
    <ChevronDown class="size-4" />
  </div>
</template>;

export {
  Select,
  SelectTrigger,
  SelectValue,
  SelectContent,
  SelectGroup,
  SelectLabel,
  SelectItem,
  SelectSeparator,
  SelectScrollUpButton,
  SelectScrollDownButton,
};
