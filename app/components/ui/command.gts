import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { consume, provide } from 'ember-provide-consume-context';
import { TrackedArray } from 'tracked-built-ins';

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

import Search from '~icons/lucide/search';

const CommandContext = 'command-context' as const;
const CommandGroupContext = 'command-group-context' as const;

interface CommandContextValue {
  search: string;
  setSearch: (value: string) => void;
  selectedValue: string | null;
  setSelectedValue: (value: string | null) => void;
  allGroups: CommandGroupContextValue[];
}

class CommandItemInstance {
  value: string;
  keywords: string[];
  checkVisibility: () => boolean;

  constructor(
    value: string,
    keywords: string[],
    checkVisibility: () => boolean
  ) {
    this.value = value;
    this.keywords = keywords;
    this.checkVisibility = checkVisibility;
  }
}

interface CommandGroupContextValue {
  items: CommandItemInstance[];
}

interface ContextRegistry {
  [CommandContext]: CommandContextValue;
  [CommandGroupContext]: CommandGroupContextValue;
}

interface CommandSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Command extends Component<CommandSignature> {
  @tracked search = '';
  @tracked selectedValue: string | null = null;
  allGroups = new TrackedArray<CommandGroupContextValue>();

  setSearch = (value: string) => {
    this.search = value;
    // Auto-select first visible item after search updates
    requestAnimationFrame(() => {
      this.selectFirstVisibleItem();
    });
  };

  selectFirstVisibleItem = () => {
    // Find first visible item from tracked data
    for (const group of this.allGroups) {
      for (const item of group.items) {
        if (item.checkVisibility()) {
          this.selectedValue = item.value;
          return;
        }
      }
    }
    // No visible items
    this.selectedValue = null;
  };

  initializeSelection = modifier(() => {
    // Wait for all groups and items to register
    requestAnimationFrame(() => {
      this.selectFirstVisibleItem();
    });
  });

  setSelectedValue = (value: string | null) => {
    this.selectedValue = value;
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'ArrowDown' || event.key === 'ArrowUp') {
      event.preventDefault();
      // Find all visible command items
      const currentTarget = event.currentTarget as HTMLElement;
      const items = Array.from(
        currentTarget.querySelectorAll<HTMLElement>(
          '[data-slot="command-item"]:not([hidden])'
        )
      );

      if (items.length === 0) return;

      const currentIndex = items.findIndex(
        (item) => item.getAttribute('data-selected') === 'true'
      );

      let newIndex: number;
      if (event.key === 'ArrowDown') {
        newIndex =
          currentIndex === -1
            ? 0
            : Math.min(currentIndex + 1, items.length - 1);
      } else {
        newIndex = currentIndex === -1 ? 0 : Math.max(currentIndex - 1, 0);
      }

      const newItem = items[newIndex];
      const value = newItem?.getAttribute('data-value');
      if (value && newItem) {
        this.selectedValue = value;
        // Scroll into view
        newItem.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
      }
    } else if (event.key === 'Enter') {
      event.preventDefault();
      // Find the selected item and trigger its click
      const currentTarget = event.currentTarget as HTMLElement;
      const selectedItem = currentTarget.querySelector<HTMLElement>(
        '[data-slot="command-item"][data-selected="true"]'
      );
      if (selectedItem) {
        selectedItem.click();
      }
    }
  };

  @provide(CommandContext)
  get context(): CommandContextValue {
    return {
      search: this.search,
      setSearch: this.setSearch,
      selectedValue: this.selectedValue,
      setSelectedValue: this.setSelectedValue,
      allGroups: this.allGroups,
    };
  }

  <template>
    <div
      aria-controls="command-list"
      aria-expanded="true"
      class={{cn
        "bg-popover text-popover-foreground flex h-full w-full flex-col overflow-hidden rounded-md"
        @class
      }}
      data-slot="command"
      role="combobox"
      tabindex="0"
      {{on "keydown" this.handleKeyDown}}
      {{this.initializeSelection}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface CommandDialogSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    title?: string;
    description?: string;
    class?: string;
    showCloseButton?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class CommandDialog extends Component<CommandDialogSignature> {
  get title() {
    return this.args.title ?? 'Command Palette';
  }

  get description() {
    return this.args.description ?? 'Search for a command to run...';
  }

  get showCloseButton() {
    return this.args.showCloseButton ?? true;
  }

  <template>
    <Dialog @onOpenChange={{@onOpenChange}} @open={{@open}}>
      <DialogHeader class="sr-only">
        <DialogTitle>{{this.title}}</DialogTitle>
        <DialogDescription>{{this.description}}</DialogDescription>
      </DialogHeader>
      <DialogContent
        @class={{cn "overflow-hidden p-0" @class}}
        @showCloseButton={{this.showCloseButton}}
      >
        <Command
          @class="[&_[data-cmdk-group-heading]]:text-muted-foreground [&_[data-slot=command-input-wrapper]]:h-12 [&_[data-cmdk-group-heading]]:px-2 [&_[data-cmdk-group-heading]]:font-medium [&_[data-cmdk-group]]:px-2 [&_[data-cmdk-group]:not([hidden])_~[data-cmdk-group]]:pt-0 [&_[data-slot=command-input-wrapper]_svg]:h-5 [&_[data-slot=command-input-wrapper]_svg]:w-5 [&_[data-slot=command-input]]:h-12 [&_[data-slot=command-item]]:px-2 [&_[data-slot=command-item]]:py-3 [&_[data-slot=command-item]_svg]:h-5 [&_[data-slot=command-item]_svg]:w-5"
        >
          {{yield}}
        </Command>
      </DialogContent>
    </Dialog>
  </template>
}

interface CommandInputSignature {
  Element: HTMLInputElement;
  Args: {
    class?: string;
    placeholder?: string;
    inputClass?: string;
  };
  Blocks: {
    default: [];
  };
}

class CommandInput extends Component<CommandInputSignature> {
  @consume(CommandContext) context!: ContextRegistry[typeof CommandContext];

  handleInput = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (this.context) {
      this.context.setSearch(target.value);
    }
  };

  focusInput = modifier((element: HTMLInputElement) => {
    // Check if we're inside a dialog by looking for dialog content
    const isInDialog = element.closest('[data-slot="dialog-content"]');
    if (isInDialog) {
      // Use requestAnimationFrame to ensure the dialog is fully rendered
      requestAnimationFrame(() => {
        element.focus();
      });
    }
  });

  <template>
    <div
      class={{cn "flex h-9 items-center gap-2 border-b px-3" @class}}
      data-slot="command-input-wrapper"
    >
      <Search class="size-4 shrink-0 opacity-50" />
      <input
        class={{cn
          "placeholder:text-muted-foreground flex h-10 w-full rounded-md bg-transparent py-3 text-sm outline-hidden disabled:cursor-not-allowed disabled:opacity-50"
          @inputClass
        }}
        data-slot="command-input"
        placeholder={{@placeholder}}
        type="text"
        value={{this.context.search}}
        {{on "input" this.handleInput}}
        {{this.focusInput}}
        ...attributes
      />
    </div>
  </template>
}

interface CommandListSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CommandList: TOC<CommandListSignature> = <template>
  <div
    class={{cn
      "max-h-[300px] scroll-py-1 overflow-x-hidden overflow-y-auto"
      @class
    }}
    data-slot="command-list"
    id="command-list"
    role="listbox"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CommandEmptySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class CommandEmpty extends Component<CommandEmptySignature> {
  @consume(CommandContext) context!: ContextRegistry[typeof CommandContext];

  get hasVisibleItems(): boolean {
    if (!this.context?.allGroups) return false;
    return this.context.allGroups.some(group =>
      group.items.some(item => item.checkVisibility())
    );
  }

  <template>
    {{#unless this.hasVisibleItems}}
      <div
        class={{cn "py-6 text-center text-sm" @class}}
        data-slot="command-empty"
        ...attributes
      >
        {{yield}}
      </div>
    {{/unless}}
  </template>
}

interface CommandGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    heading?: string;
  };
  Blocks: {
    default: [];
  };
}

class CommandGroup extends Component<CommandGroupSignature> {
  @consume(CommandContext) declare commandContext?: ContextRegistry[typeof CommandContext];
  items = new TrackedArray<CommandItemInstance>();

  @provide(CommandGroupContext)
  groupContext: CommandGroupContextValue = { items: this.items };

  get hasVisibleItems(): boolean {
    return this.items.some(item => item.checkVisibility());
  }

  registerWithCommand = modifier(() => {
    if (this.commandContext) {
      this.commandContext.allGroups.push(this.groupContext);

      registerDestructor(this, () => {
        const index = this.commandContext!.allGroups.indexOf(this.groupContext);
        if (index > -1) {
          this.commandContext!.allGroups.splice(index, 1);
        }
      });
    }
  });

  <template>
    <div
      class={{cn
        "text-foreground [&_[data-cmdk-group-heading]]:text-muted-foreground overflow-hidden p-1 [&_[data-cmdk-group-heading]]:px-2 [&_[data-cmdk-group-heading]]:py-1.5 [&_[data-cmdk-group-heading]]:text-xs [&_[data-cmdk-group-heading]]:font-medium"
        @class
      }}
      data-slot="command-group"
      hidden={{unless this.hasVisibleItems true}}
      {{this.registerWithCommand}}
      ...attributes
    >
      {{#if @heading}}
        <div data-cmdk-group-heading>{{@heading}}</div>
      {{/if}}
      {{yield}}
    </div>
  </template>
}

interface CommandSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class CommandSeparator extends Component<CommandSeparatorSignature> {
  @consume(CommandContext) context!: ContextRegistry[typeof CommandContext];

  get hasVisibleItems(): boolean {
    if (!this.context?.allGroups) return false;
    return this.context.allGroups.some(group =>
      group.items.some(item => item.checkVisibility())
    );
  }

  <template>
    {{#if this.hasVisibleItems}}
      <div
        class={{cn "bg-border -mx-1 h-px" @class}}
        data-slot="command-separator"
        ...attributes
      ></div>
    {{/if}}
  </template>
}

interface CommandItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    disabled?: boolean;
    value: string;
    keywords?: string[];
    onSelect?: () => void;
  };
  Blocks: {
    default: [];
  };
}

class CommandItem extends Component<CommandItemSignature> {
  @consume(CommandContext) context!: ContextRegistry[typeof CommandContext];
  @consume(CommandGroupContext) declare groupContext?: ContextRegistry[typeof CommandGroupContext];

  get isVisible(): boolean {
    if (!this.context || !this.context.search?.trim()) {
      return true;
    }

    const searchLower = this.context.search.toLowerCase();
    const value = this.args.value.toLowerCase();
    const keywords = this.args.keywords || [];

    const valueMatch = value.includes(searchLower);
    const keywordsMatch = keywords.some((keyword) =>
      keyword.toLowerCase().includes(searchLower)
    );

    return valueMatch || keywordsMatch;
  }

registerWithGroup = modifier(() => {
    if (this.groupContext) {
      const instance = new CommandItemInstance(
        this.args.value,
        this.args.keywords || [],
        () => this.isVisible
      );

      // Push directly - the array itself is tracked
      this.groupContext.items.push(instance);

      registerDestructor(this, () => {
        const index = this.groupContext!.items.indexOf(instance);
        if (index > -1) {
          this.groupContext!.items.splice(index, 1);
        }
      });
    }
  });

  get isSelected(): boolean {
    return this.context?.selectedValue === this.args.value;
  }

  handleClick = () => {
    if (!this.args.disabled && this.args.onSelect) {
      this.args.onSelect();
    }
  };

  handleMouseEnter = () => {
    if (!this.args.disabled && this.context) {
      this.context.setSelectedValue(this.args.value);
    }
  };

  <template>
    {{#if this.isVisible}}
      <div
        aria-selected={{if this.isSelected "true" "false"}}
        class={{cn
          "data-[selected=true]:bg-accent data-[selected=true]:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
          @class
        }}
        data-disabled={{@disabled}}
        data-selected={{if this.isSelected "true" "false"}}
        data-slot="command-item"
        data-value={{@value}}
        hidden={{unless this.isVisible true}}
        role="option"
        {{on "click" this.handleClick}}
        {{on "mouseenter" this.handleMouseEnter passive=true}}
        {{this.registerWithGroup}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

interface CommandShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CommandShortcut: TOC<CommandShortcutSignature> = <template>
  <span
    class={{cn "text-muted-foreground ml-auto text-xs tracking-widest" @class}}
    data-slot="command-shortcut"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

export {
  Command,
  CommandDialog,
  CommandInput,
  CommandList,
  CommandEmpty,
  CommandGroup,
  CommandItem,
  CommandShortcut,
  CommandSeparator,
};
