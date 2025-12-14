/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
import PhMagnifyingGlass from 'ember-phosphor-icons/components/ph-magnifying-glass';

// Note: This is a simplified version of the Command component
// Full implementation would require a command palette library

// Command Root Component
interface CommandSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class Command extends Component<CommandSignature> {
  <template>
    <div
      class={{cn
        "flex h-full w-full flex-col overflow-hidden rounded-md bg-popover text-popover-foreground"
        @class
      }}
      role="combobox"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// CommandDialog Component (would integrate with Dialog)
interface CommandDialogSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [];
  };
}

export class CommandDialog extends Component<CommandDialogSignature> {
  <template>
    {{! TODO: Integrate with Dialog component }}
    {{yield}}
  </template>
}

// CommandInput Component
interface CommandInputSignature {
  Element: HTMLInputElement;
  Args: {
    class?: string;
    placeholder?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CommandInput extends Component<CommandInputSignature> {
  <template>
    <div class="flex items-center border-b px-3">
      <PhMagnifyingGlass @size={{16}} class="mr-2 shrink-0 opacity-50" />
      <input
        type="text"
        class={{cn
          "flex h-10 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50"
          @class
        }}
        placeholder={{@placeholder}}
        ...attributes
      />
    </div>
  </template>
}

// CommandList Component
interface CommandListSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CommandList extends Component<CommandListSignature> {
  <template>
    <div
      class={{cn "max-h-[300px] overflow-y-auto overflow-x-hidden" @class}}
      role="listbox"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// CommandEmpty Component
interface CommandEmptySignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CommandEmpty extends Component<CommandEmptySignature> {
  <template>
    <div class={{cn "py-6 text-center text-sm" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// CommandGroup Component
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

export class CommandGroup extends Component<CommandGroupSignature> {
  <template>
    <div
      class={{cn
        "overflow-hidden p-1 text-foreground [&_[cmdk-group-heading]]:px-2 [&_[cmdk-group-heading]]:py-1.5 [&_[cmdk-group-heading]]:text-xs [&_[cmdk-group-heading]]:font-medium [&_[cmdk-group-heading]]:text-muted-foreground"
        @class
      }}
      role="group"
      ...attributes
    >
      {{#if @heading}}
        <div data-cmdk-group-heading>{{@heading}}</div>
      {{/if}}
      {{yield}}
    </div>
  </template>
}

// CommandSeparator Component
interface CommandSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CommandSeparator extends Component<CommandSeparatorSignature> {
  <template>
    <div class={{cn "-mx-1 h-px bg-border" @class}} role="separator" ...attributes></div>
  </template>
}

// CommandItem Component
interface CommandItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export class CommandItem extends Component<CommandItemSignature> {
  <template>
    <div
      class={{cn
        "relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none aria-selected:bg-accent aria-selected:text-accent-foreground data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0"
        @class
      }}
      role="option"
      data-disabled={{@disabled}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// CommandShortcut Component
interface CommandShortcutSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CommandShortcut extends Component<CommandShortcutSignature> {
  <template>
    <span
      class={{cn "ml-auto text-xs tracking-widest text-muted-foreground" @class}}
      ...attributes
    >
      {{yield}}
    </span>
  </template>
}

export default Command;
