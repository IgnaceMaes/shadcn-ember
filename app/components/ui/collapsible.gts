import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { guidFor } from '@ember/object/internals';
import { hash } from '@ember/helper';

interface CollapsibleSignature {
  Element: HTMLDivElement;
  Args: {
    defaultOpen?: boolean;
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    disabled?: boolean;
  };
  Blocks: {
    default: [
      {
        Trigger: unknown;
        Content: unknown;
      },
    ];
  };
}

class Collapsible extends Component<CollapsibleSignature> {
  @tracked internalOpen = this.args.defaultOpen ?? false;

  contentId = `collapsible-content-${guidFor(this)}`;

  get open() {
    return this.args.open ?? this.internalOpen;
  }

  get disabled() {
    return this.args.disabled;
  }

  onOpenToggle = () => {
    if (!this.disabled) {
      const newOpen = !this.open;
      this.internalOpen = newOpen;
      this.args.onOpenChange?.(newOpen);
    }
  };

  get dataState() {
    return this.open ? 'open' : 'closed';
  }

  get context() {
    return {
      open: this.open,
      contentId: this.contentId,
      disabled: this.disabled,
      onOpenToggle: this.onOpenToggle,
    };
  }

  <template>
    <div
      data-slot="collapsible"
      data-state={{this.dataState}}
      data-disabled={{if this.disabled "" undefined}}
      ...attributes
    >
      {{yield
        (hash
          Trigger=(component CollapsibleTrigger context=this.context)
          Content=(component CollapsibleContent context=this.context)
        )
      }}
    </div>
  </template>
}

interface CollapsibleTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    context: {
      open: boolean;
      contentId: string;
      disabled?: boolean;
      onOpenToggle: () => void;
    };
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [
      {
        onClick: () => void;
        'aria-controls': string;
        'aria-expanded': string;
        'data-state': string;
        'data-slot': string;
        'data-disabled'?: string;
        disabled?: boolean;
      },
    ];
  };
}

class CollapsibleTrigger extends Component<CollapsibleTriggerSignature> {
  get dataState() {
    return this.args.context.open ? 'open' : 'closed';
  }

  get triggerProps() {
    return {
      onClick: this.args.context.onOpenToggle,
      'aria-controls': this.args.context.contentId,
      'aria-expanded': this.args.context.open ? 'true' : 'false',
      'data-state': this.dataState,
      'data-slot': 'collapsible-trigger' as const,
      'data-disabled': this.args.context.disabled ? '' : undefined,
      disabled: this.args.context.disabled,
    };
  }

  <template>
    {{#if @asChild}}
      {{yield this.triggerProps}}
    {{else}}
      <button
        type="button"
        aria-controls={{@context.contentId}}
        aria-expanded={{if @context.open "true" "false"}}
        data-state={{this.dataState}}
        data-slot="collapsible-trigger"
        data-disabled={{if @context.disabled "" undefined}}
        disabled={{@context.disabled}}
        class={{@class}}
        {{on "click" @context.onOpenToggle}}
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
    context: {
      open: boolean;
      contentId: string;
      disabled?: boolean;
    };
    class?: string;
    forceMount?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class CollapsibleContent extends Component<CollapsibleContentSignature> {
  get dataState() {
    return this.args.context.open ? 'open' : 'closed';
  }

  get isOpen() {
    return this.args.forceMount || this.args.context.open;
  }

  <template>
    <div
      id={{@context.contentId}}
      data-state={{this.dataState}}
      data-slot="collapsible-content"
      data-disabled={{if @context.disabled "" undefined}}
      hidden={{unless this.isOpen true}}
      class={{@class}}
      ...attributes
    >
      {{#if this.isOpen}}
        {{yield}}
      {{/if}}
    </div>
  </template>
}

export { Collapsible, CollapsibleTrigger, CollapsibleContent };

export { Collapsible as default };
