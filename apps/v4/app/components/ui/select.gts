import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { cached } from '@glimmer/tracking';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { modifier } from 'ember-modifier';
import { provide, consume } from 'ember-provide-consume-context';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';
import type Owner from '@ember/owner';

import Check from '~icons/lucide/check';
import ChevronDown from '~icons/lucide/chevron-down';
import ChevronUp from '~icons/lucide/chevron-up';

const SelectContext = 'select-context' as const;
const SelectContentContext = 'select-content-context' as const;

interface SelectContextValue {
  value: string;
  selectedLabel: string;
  isOpen: boolean;
  isRendered: boolean;
  disabled: boolean;
  toggle: () => void;
  close: (instant?: boolean) => void;
  finishClose: () => void;
  selectValue: (value: string, label: string, instant?: boolean) => void;
  triggerElement: HTMLElement | null;
  setTriggerElement: (element: HTMLElement | null) => void;
  selectedItemElement: HTMLElement | null;
  setSelectedItemElement: (element: HTMLElement | null) => void;
}

interface SelectContentContextValue {
  position: 'popper' | 'item-aligned';
}

interface ContextRegistry {
  [SelectContext]: SelectContextValue;
  [SelectContentContext]: SelectContentContextValue;
}

interface SelectSignature {
  Args: {
    value?: string;
    defaultValue?: string;
    onValueChange?: (value: string) => void;
    disabled?: boolean;
    name?: string;
    required?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class Select extends Component<SelectSignature> {
  @tracked isOpen = false;
  @tracked isRendered = false;
  @tracked selectedValue: string;
  @tracked selectedLabel = '';
  triggerElement: HTMLElement | null = null;
  @tracked selectedItemElement: HTMLElement | null = null;

  constructor(owner: Owner, args: SelectSignature['Args']) {
    super(owner, args);
    this.selectedValue = args.value ?? args.defaultValue ?? '';
  }

  get value() {
    return this.args.value ?? this.selectedValue;
  }

  toggle = () => {
    if (!this.args.disabled) {
      if (this.isOpen) {
        this.close();
      } else {
        this.isRendered = true;
        this.isOpen = true;
      }
    }
  };

  close = (instant = false) => {
    this.isOpen = false;
    if (instant) {
      this.finishClose();
    }
  };

  finishClose = () => {
    if (!this.isOpen) {
      this.isRendered = false;
    }
  };

  selectValue = (value: string, label: string, instant = false) => {
    this.selectedValue = value;
    this.selectedLabel = label;
    this.close(instant);
    this.args.onValueChange?.(value);
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  setSelectedItemElement = (element: HTMLElement | null) => {
    this.selectedItemElement = element;
  };

  @cached
  @provide(SelectContext)
  get context(): SelectContextValue {
    return {
      value: this.value,
      selectedLabel: this.selectedLabel,
      isOpen: this.isOpen,
      isRendered: this.isRendered,
      disabled: this.args.disabled ?? false,
      toggle: this.toggle,
      close: this.close,
      finishClose: this.finishClose,
      selectValue: this.selectValue,
      triggerElement: this.triggerElement,
      setTriggerElement: this.setTriggerElement,
      selectedItemElement: this.selectedItemElement,
      setSelectedItemElement: this.setSelectedItemElement,
    };
  }

  <template>
    {{! template-lint-disable no-yield-only }}
    {{yield}}
  </template>
}

interface SelectTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    size?: 'sm' | 'default';
  };
  Blocks: {
    default: [];
  };
}

class SelectTrigger extends Component<SelectTriggerSignature> {
  @consume(SelectContext) context!: ContextRegistry[typeof SelectContext];

  get sizeClass() {
    return this.args.size === 'sm' ? 'h-8' : 'h-9';
  }

  registerElement = modifier((element: HTMLElement) => {
    this.context.setTriggerElement(element);
    return () => {
      this.context.setTriggerElement(null);
    };
  });

  <template>
    <button
      class={{cn
        "border-input data-[placeholder]:text-muted-foreground [&_svg:not([class*='text-'])]:text-muted-foreground focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive dark:bg-input/30 dark:hover:bg-input/50 flex w-fit items-center justify-between gap-2 rounded-md border bg-transparent px-3 py-2 text-sm whitespace-nowrap shadow-xs transition-[color,box-shadow] outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50"
        this.sizeClass
        "*:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:flex *:data-[slot=select-value]:items-center *:data-[slot=select-value]:gap-2 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        @class
      }}
      data-placeholder={{if this.context.value null ""}}
      data-size={{if @size @size "default"}}
      data-slot="select-trigger"
      disabled={{this.context.disabled}}
      type="button"
      {{on "click" this.context.toggle}}
      {{this.registerElement}}
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
  };
  Blocks: {
    default: [];
  };
}

class SelectValue extends Component<SelectValueSignature> {
  @consume(SelectContext) context!: ContextRegistry[typeof SelectContext];

  <template>
    <span class={{cn @class}} data-slot="select-value" ...attributes>
      {{#if (has-block)}}
        {{yield}}
      {{else if this.context.selectedLabel}}
        {{this.context.selectedLabel}}
      {{else if this.context.value}}
        {{this.context.value}}
      {{else}}
        {{@placeholder}}
      {{/if}}
    </span>
  </template>
}

interface SelectContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    position?: 'popper' | 'item-aligned';
    align?: 'start' | 'center' | 'end';
  };
  Blocks: {
    default: [];
  };
}

class SelectContent extends Component<SelectContentSignature> {
  @consume(SelectContext) context!: ContextRegistry[typeof SelectContext];

  @tracked x = 0;
  @tracked y = 0;
  @tracked triggerWidth = 0;
  @tracked maxHeight = 0;
  @tracked canScrollUp = false;
  @tracked canScrollDown = false;
  cleanup?: () => void;
  contentElement: HTMLDivElement | null = null;

  get destinationElement() {
    return document.body;
  }

  get positionClass() {
    return this.args.position === 'popper'
      ? 'data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1'
      : '';
  }

  @cached
  @provide(SelectContentContext)
  get contentContext(): SelectContentContextValue {
    return {
      position: this.args.position ?? 'item-aligned',
    };
  }

  handleClickOutside = () => {
    const instant = this.args.position === 'item-aligned';
    this.context.close(instant);
  };

  handleAnimationEnd = (event: AnimationEvent) => {
    if (event.target === event.currentTarget && !this.context.isOpen) {
      // Only wait for animation on popper mode
      if (this.args.position !== 'item-aligned') {
        this.context.finishClose();
      }
    }
  };

  updateScrollState = (element: HTMLDivElement) => {
    const { scrollTop, scrollHeight, clientHeight } = element;
    this.canScrollUp = scrollTop > 1;
    this.canScrollDown = Math.ceil(scrollTop + clientHeight) < scrollHeight;
  };

  handleScroll = (event: Event) => {
    const element = event.target as HTMLDivElement;
    this.updateScrollState(element);
  };

  scrollUp = () => {
    if (this.contentElement) {
      this.contentElement.scrollBy({ top: -100, behavior: 'smooth' });
    }
  };

  scrollDown = () => {
    if (this.contentElement) {
      this.contentElement.scrollBy({ top: 100, behavior: 'smooth' });
    }
  };

  positionContent = modifier(
    (
      element: HTMLElement,
      [triggerElement, selectedItem]: [
        HTMLElement | null | undefined,
        HTMLElement | null
      ]
    ) => {
      if (!triggerElement) return;

      const position = this.args.position ?? 'item-aligned';
      const align = this.args.align ?? 'start';
      const placementMap: Record<string, Placement> = {
        start: 'bottom-start',
        center: 'bottom',
        end: 'bottom-end',
      };

      const update = () => {
        if (position === 'item-aligned') {
          // Calculate the offset to align the selected item with the trigger
          let itemOffset = 0;

          if (selectedItem) {
            // Get the distance from the content's top to the selected item
            const contentTop = element.getBoundingClientRect().top;
            const itemTop = selectedItem.getBoundingClientRect().top;
            itemOffset = itemTop - contentTop;
          }

          // Position the content so it overlaps the trigger
          const triggerRect = triggerElement.getBoundingClientRect();
          const viewportHeight = window.innerHeight;
          const padding = 8;

          const idealY = triggerRect.top - itemOffset;

          // Calculate available space above and below
          const spaceAbove = idealY - padding;
          const spaceBelow = viewportHeight - idealY - padding;

          // Get content height
          const contentHeight = element.scrollHeight;

          // Adjust position and max-height to fit within viewport
          if (idealY < padding) {
            // Would overflow top - push down
            this.y = padding;
            this.maxHeight = Math.min(contentHeight, triggerRect.bottom - padding);
          } else if (idealY + contentHeight > viewportHeight - padding) {
            // Would overflow bottom - adjust
            if (spaceBelow >= contentHeight) {
              this.y = idealY;
              this.maxHeight = contentHeight;
            } else if (spaceAbove >= contentHeight) {
              // Fit above
              this.y = Math.max(padding, viewportHeight - contentHeight - padding);
              this.maxHeight = contentHeight;
            } else {
              // Constrain to available space
              const availableSpace = viewportHeight - padding * 2;
              this.y = padding;
              this.maxHeight = availableSpace;
            }
          } else {
            // Fits naturally
            this.y = idealY;
            this.maxHeight = contentHeight;
          }

          this.x = triggerRect.left;
          this.triggerWidth = triggerElement.offsetWidth;

          // Set trigger width as CSS variable
          element.style.setProperty(
            '--select-trigger-width',
            `${triggerElement.offsetWidth}px`
          );
        } else {
          // Use floating-ui for popper positioning
          void computePosition(triggerElement, element, {
            placement: placementMap[align] || 'bottom-start',
            strategy: 'fixed',
            middleware: [offset(4), flip(), shift({ padding: 8 })],
          }).then(({ x, y }) => {
            this.x = x;
            this.y = y;
            this.triggerWidth = triggerElement.offsetWidth;
            // Set trigger width as CSS variable
            element.style.setProperty(
              '--select-trigger-width',
              `${triggerElement.offsetWidth}px`
            );
          });
        }
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.cleanup?.();
      };
    }
  );

  registerContent = modifier((element: HTMLDivElement) => {
    this.contentElement = element;

    // Check initial scroll state after layout
    const checkScroll = () => {
      this.updateScrollState(element);
    };

    requestAnimationFrame(() => {
      checkScroll();
      // Double-check after a brief moment to ensure layout is complete
      setTimeout(checkScroll, 50);
    });

    return () => {
      this.contentElement = null;
    };
  });

  get positionStyle() {
    return htmlSafe(
      `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 50; max-height: ${this.maxHeight}px; --select-trigger-width: ${this.triggerWidth}px;`
    );
  }

  <template>
    {{#if this.context.isRendered}}
      {{#in-element this.destinationElement insertBefore=null}}
        <div
          class={{cn
            "min-w-[var(--select-trigger-width)] bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 overflow-hidden rounded-md border shadow-md"
            this.positionClass
            @class
          }}
          data-slot="select-content"
          data-state={{if this.context.isOpen "open" "closed"}}
          role="listbox"
          style={{this.positionStyle}}
          {{on "animationend" this.handleAnimationEnd}}
          {{onClickOutside this.handleClickOutside}}
          {{this.positionContent
            this.context.triggerElement
            this.context.selectedItemElement
          }}
          ...attributes
        >
          {{#if this.canScrollUp}}
            <button
              class="flex cursor-default items-center justify-center py-1 w-full"
              data-slot="select-scroll-up-button"
              type="button"
              {{on "click" this.scrollUp}}
            >
              <ChevronUp class="size-4" />
            </button>
          {{/if}}
          <div
            class="overflow-y-auto overflow-x-hidden p-1 max-h-[inherit]"
            {{on "scroll" this.handleScroll}}
            {{this.registerContent}}
          >
            {{yield}}
          </div>
          {{#if this.canScrollDown}}
            <button
              class="flex cursor-default items-center justify-center py-1 w-full"
              data-slot="select-scroll-down-button"
              type="button"
              {{on "click" this.scrollDown}}
            >
              <ChevronDown class="size-4" />
            </button>
          {{/if}}
        </div>
      {{/in-element}}
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
  <div class={{cn @class}} data-slot="select-group" ...attributes>
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
    class={{cn "text-muted-foreground px-2 py-1.5 text-xs" @class}}
    data-slot="select-label"
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
  };
  Blocks: {
    default: [];
  };
}

class SelectItem extends Component<SelectItemSignature> {
  @consume(SelectContext) context!: ContextRegistry[typeof SelectContext];
  @consume(SelectContentContext)
  contentContext!: ContextRegistry[typeof SelectContentContext];

  itemElement: HTMLDivElement | null = null;

  get isSelected() {
    return this.args.value === this.context.value;
  }

  handleClick = () => {
    if (!this.args.disabled) {
      const label = this.itemElement?.textContent?.trim() || this.args.value;
      const instant = this.contentContext.position === 'item-aligned';
      this.context.selectValue(this.args.value, label, instant);
    }
  };

  registerElement = modifier((element: HTMLDivElement) => {
    this.itemElement = element;

    return () => {
      // Clean up on unmount
      if (this.context.selectedItemElement === element) {
        this.context.setSelectedItemElement(null);
      }
    };
  });

  updateSelectedElement = modifier(
    (element: HTMLDivElement, [isSelected]: [boolean]) => {
      // Defer the update to avoid updating tracked properties during render
      requestAnimationFrame(() => {
        if (isSelected) {
          this.context.setSelectedItemElement(element);
        } else if (this.context.selectedItemElement === element) {
          this.context.setSelectedItemElement(null);
        }
      });
    }
  );

  <template>
    {{! template-lint-disable require-mandatory-role-attributes require-presentational-children }}
    <div
      class={{cn
        "focus:bg-accent focus:text-accent-foreground hover:bg-accent hover:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground relative flex w-full cursor-default items-center gap-2 rounded-sm py-1.5 pr-8 pl-2 text-sm outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 *:[span]:last:flex *:[span]:last:items-center *:[span]:last:gap-2"
        (if
          this.isSelected
          "[@media(hover:none)]:bg-accent [@media(hover:none)]:text-accent-foreground"
        )
        @class
      }}
      data-disabled={{if @disabled "true"}}
      data-slot="select-item"
      role="option"
      {{on "click" this.handleClick}}
      {{this.registerElement}}
      {{this.updateSelectedElement this.isSelected}}
      ...attributes
    >
      <span
        class="absolute right-2 flex size-3.5 items-center justify-center"
        data-slot="select-item-indicator"
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
    class={{cn "bg-border pointer-events-none -mx-1 my-1 h-px" @class}}
    data-slot="select-separator"
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
    class={{cn "flex cursor-default items-center justify-center py-1" @class}}
    data-slot="select-scroll-up-button"
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
    class={{cn "flex cursor-default items-center justify-center py-1" @class}}
    data-slot="select-scroll-down-button"
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
