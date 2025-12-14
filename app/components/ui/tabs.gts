/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { hash } from '@ember/helper';
import type Owner from '@ember/owner';
import { cn } from '@/lib/utils';

interface TabsSignature {
  Args: {
    defaultValue?: string;
    value?: string;
    onValueChange?: (value: string) => void;
    class?: string;
  };
  Blocks: {
    default: [
      {
        List: typeof TabsList;
        Trigger: typeof TabsTrigger;
        Content: typeof TabsContent;
      },
    ];
  };
  Element: HTMLDivElement;
}

class Tabs extends Component<TabsSignature> {
  @tracked currentValue: string;

  constructor(owner: Owner, args: TabsSignature['Args']) {
    super(owner, args);
    this.currentValue = args.value ?? args.defaultValue ?? '';
  }

  get value() {
    return this.args.value ?? this.currentValue;
  }

  setValue = (value: string) => {
    this.currentValue = value;
    this.args.onValueChange?.(value);
  };

  <template>
    <div class={{cn "w-full" @class}} ...attributes>
      {{yield
        (hash List=(component TabsList) Trigger=(component TabsTrigger currentTabValue=this.value setValue=this.setValue) Content=(component TabsContent currentTabValue=this.value))
      }}
    </div>
  </template>
}

interface TabsListSignature {
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

class TabsList extends Component<TabsListSignature> {
  <template>
    <div
      class={{cn
        "inline-flex h-9 items-center justify-center rounded-lg bg-muted p-1 text-muted-foreground"
        @class
      }}
      role="tablist"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface TabsTriggerSignature {
  Args: {
    value: string;
    class?: string;
    disabled?: boolean;
    currentTabValue?: string;
    setValue?: (value: string) => void;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLButtonElement;
}

class TabsTrigger extends Component<TabsTriggerSignature> {
  get isActive() {
    return this.args.value === this.args.currentTabValue;
  }

  handleClick = () => {
    if (!this.args.disabled && this.args.setValue) {
      this.args.setValue(this.args.value);
    }
  };

  <template>
    <button
      type="button"
      role="tab"
      aria-selected={{if this.isActive "true" "false"}}
      data-state={{if this.isActive "active" "inactive"}}
      disabled={{@disabled}}
      class={{cn
        "inline-flex items-center justify-center whitespace-nowrap rounded-md px-3 py-1 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow"
        @class
      }}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

interface TabsContentSignature {
  Args: {
    value: string;
    class?: string;
    currentTabValue?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

class TabsContent extends Component<TabsContentSignature> {
  get isActive() {
    return this.args.value === this.args.currentTabValue;
  }

  <template>
    {{#if this.isActive}}
      <div
        role="tabpanel"
        data-state={{if this.isActive "active" "inactive"}}
        class={{cn
          "mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
          @class
        }}
        tabindex="0"
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export { Tabs, TabsList, TabsTrigger, TabsContent };
export default Tabs;
