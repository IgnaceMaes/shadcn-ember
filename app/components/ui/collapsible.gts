import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { guidFor } from '@ember/object/internals';
import type Owner from '@ember/owner';
import { provide, consume } from 'ember-provide-consume-context';

const CollapsibleContext = 'collapsible-context' as const;

interface CollapsibleContextValue {
  open: boolean;
  contentId: string;
  disabled?: boolean;
  onOpenToggle: () => void;
}

interface ContextRegistry {
  [CollapsibleContext]: CollapsibleContextValue;
}

interface CollapsibleSignature {
  Element: HTMLDivElement;
  Args: {
    defaultOpen?: boolean;
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    disabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class Collapsible extends Component<CollapsibleSignature> {
  @tracked currentOpen: boolean;
  contentId = `collapsible-content-${guidFor(this)}`;

  constructor(owner: Owner, args: CollapsibleSignature['Args']) {
    super(owner, args);
    this.currentOpen = args.open ?? args.defaultOpen ?? false;
  }

  get open() {
    return this.args.open ?? this.currentOpen;
  }

  get disabled() {
    return this.args.disabled;
  }

  onOpenToggle = () => {
    if (!this.disabled) {
      const newOpen = !this.open;
      this.currentOpen = newOpen;
      this.args.onOpenChange?.(newOpen);
    }
  };

  get dataState() {
    return this.open ? 'open' : 'closed';
  }

  @provide(CollapsibleContext)
  get context(): CollapsibleContextValue {
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
      {{yield}}
    </div>
  </template>
}

interface CollapsibleTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
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
  @consume(CollapsibleContext)
  context!: ContextRegistry[typeof CollapsibleContext];

  get dataState() {
    return this.context.open ? 'open' : 'closed';
  }

  get triggerProps() {
    return {
      onClick: this.context.onOpenToggle,
      'aria-controls': this.context.contentId,
      'aria-expanded': this.context.open ? 'true' : 'false',
      'data-state': this.dataState,
      'data-slot': 'collapsible-trigger' as const,
      'data-disabled': this.context.disabled ? '' : undefined,
      disabled: this.context.disabled,
    };
  }

  <template>
    {{#if @asChild}}
      {{yield this.triggerProps}}
    {{else}}
      <button
        type="button"
        aria-controls={{this.context.contentId}}
        aria-expanded={{if this.context.open "true" "false"}}
        data-state={{this.dataState}}
        data-slot="collapsible-trigger"
        data-disabled={{if this.context.disabled "" undefined}}
        disabled={{this.context.disabled}}
        class={{@class}}
        {{on "click" this.context.onOpenToggle}}
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
    class?: string;
    forceMount?: boolean;
  };
  Blocks: {
    default: [];
  };
}

class CollapsibleContent extends Component<CollapsibleContentSignature> {
  @consume(CollapsibleContext)
  context!: ContextRegistry[typeof CollapsibleContext];

  get dataState() {
    return this.context.open ? 'open' : 'closed';
  }

  get isOpen() {
    return this.args.forceMount || this.context.open;
  }

  <template>
    <div
      id={{this.context.contentId}}
      data-state={{this.dataState}}
      data-slot="collapsible-content"
      data-disabled={{if this.context.disabled "" undefined}}
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
