import Component from '@glimmer/component';

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

interface CommandSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Command: TOC<CommandSignature> = <template>
  <div
    class={{cn
      "bg-popover text-popover-foreground flex h-full w-full flex-col overflow-hidden rounded-md"
      @class
    }}
    data-slot="command"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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
          @class="[&_[data-cmdk-group-heading]]:text-muted-foreground [&_[data-slot=command-input-wrapper]]:h-12 [&_[data-cmdk-group-heading]]:px-2 [&_[data-cmdk-group-heading]]:font-medium [&_[cmdk-group]]:px-2 [&_[cmdk-group]:not([hidden])_~[cmdk-group]]:pt-0 [&_[cmdk-input-wrapper]_svg]:h-5 [&_[cmdk-input-wrapper]_svg]:w-5 [&_[cmdk-input]]:h-12 [&_[cmdk-item]]:px-2 [&_[cmdk-item]]:py-3 [&_[cmdk-item]_svg]:h-5 [&_[cmdk-item]_svg]:w-5"
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

const CommandInput: TOC<CommandInputSignature> = <template>
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
      ...attributes
    />
  </div>
</template>;

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

const CommandEmpty: TOC<CommandEmptySignature> = <template>
  <div
    class={{cn "py-6 text-center text-sm" @class}}
    data-slot="command-empty"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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

const CommandGroup: TOC<CommandGroupSignature> = <template>
  <div
    class={{cn
      "text-foreground [&_[data-cmdk-group-heading]]:text-muted-foreground overflow-hidden p-1 [&_[data-cmdk-group-heading]]:px-2 [&_[data-cmdk-group-heading]]:py-1.5 [&_[data-cmdk-group-heading]]:text-xs [&_[data-cmdk-group-heading]]:font-medium"
      @class
    }}
    data-slot="command-group"
    ...attributes
  >
    {{#if @heading}}
      <div data-cmdk-group-heading>{{@heading}}</div>
    {{/if}}
    {{yield}}
  </div>
</template>;

interface CommandSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CommandSeparator: TOC<CommandSeparatorSignature> = <template>
  <div
    class={{cn "bg-border -mx-1 h-px" @class}}
    data-slot="command-separator"
    ...attributes
  ></div>
</template>;

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

const CommandItem: TOC<CommandItemSignature> = <template>
  <div
    class={{cn
      "data-[selected=true]:text-accent-foreground [&_svg:not([class*='text-'])]:text-muted-foreground relative flex cursor-default items-center gap-2 px-2 py-1.5 text-sm outline-hidden select-none data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
      @class
    }}
    data-disabled={{@disabled}}
    data-slot="command-item"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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
