import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

interface CollapsibleSignature {
  Args: {
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    disabled?: boolean;
  };
  Blocks: {
    default: [open: boolean, setOpen: (open: boolean) => void];
  };
}

class Collapsible extends Component<CollapsibleSignature> {
  @tracked isOpen = this.args.open ?? false;

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    if (!this.args.disabled) {
      this.isOpen = open;
      this.args.onOpenChange?.(open);
    }
  };

  <template>
    <div data-slot="collapsible" ...attributes>
      {{yield this.open this.setOpen}}
    </div>
  </template>
}

interface CollapsibleTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    open?: boolean;
    setOpen?: (open: boolean) => void;
    class?: string;
    disabled?: boolean;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class CollapsibleTrigger extends Component<CollapsibleTriggerSignature> {
  handleClick = () => {
    this.args.setOpen?.(!this.args.open);
  };

  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <button
        type="button"
        aria-expanded={{if @open "true" "false"}}
        data-state={{if @open "open" "closed"}}
        data-slot="collapsible-trigger"
        disabled={{@disabled}}
        class={{@class}}
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface CollapsibleContentSignature {
  Element: HTMLDivElement;
  Args: {
    open?: boolean;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CollapsibleContent: TOC<CollapsibleContentSignature> = <template>
  {{#if @open}}
    <div
      data-state={{if @open "open" "closed"}}
      data-slot="collapsible-content"
      class={{@class}}
      ...attributes
    >
      {{yield}}
    </div>
  {{/if}}
</template>;

export { Collapsible, CollapsibleTrigger, CollapsibleContent };

export { Collapsible as default };
