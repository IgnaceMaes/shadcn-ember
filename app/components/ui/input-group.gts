import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

// Note: This is a simplified placeholder for the InputGroup component
// Full implementation would handle more complex input grouping scenarios

// InputGroup Root Component
interface InputGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const InputGroup: TOC<InputGroupSignature> = <template>
  <div
    data-slot="input-group"
    role="group"
    class={{cn
      "group/input-group border-input shadow-xs relative flex w-full items-center rounded-md border outline-none transition-[color,box-shadow] h-9 has-focus:ring-ring has-focus:ring-1"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

// InputGroupAddon Component
interface InputGroupAddonSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    align?: 'inline-start' | 'inline-end' | 'block-start' | 'block-end';
  };
  Blocks: {
    default: [];
  };
}

export class InputGroupAddon extends Component<InputGroupAddonSignature> {
  get alignClasses() {
    const align = this.args.align ?? 'inline-start';
    const alignMap = {
      'inline-start': 'order-first pl-3',
      'inline-end': 'order-last pr-3',
      'block-start': 'order-first w-full justify-start px-3 pt-3',
      'block-end': 'order-last w-full justify-start px-3 pb-3',
    };
    return alignMap[align];
  }

  <template>
    <div
      data-align={{@align}}
      class={{cn
        "text-muted-foreground flex h-auto cursor-text select-none items-center justify-center gap-2 py-1.5 text-sm font-medium"
        this.alignClasses
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

export default InputGroup;
