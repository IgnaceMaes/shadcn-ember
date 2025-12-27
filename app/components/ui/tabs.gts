import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
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
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        List: any;
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        Trigger: any;
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        Content: any;
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
    <div
      data-slot="tabs"
      class={{cn "flex flex-col gap-2" @class}}
      ...attributes
    >
      {{yield
        (hash
          List=(component TabsList)
          Trigger=(component
            TabsTrigger currentTabValue=this.value setValue=this.setValue
          )
          Content=(component TabsContent currentTabValue=this.value)
        )
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

const TabsList: TOC<TabsListSignature> = <template>
  <div
    data-slot="tabs-list"
    class={{cn
      "bg-muted text-muted-foreground inline-flex h-9 w-fit items-center justify-center rounded-lg p-[3px]"
      @class
    }}
    role="tablist"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

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
      data-slot="tabs-trigger"
      disabled={{@disabled}}
      class={{cn
        "data-[state=active]:bg-background dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-md border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:shadow-sm [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
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
        data-slot="tabs-content"
        class={{cn "flex-1 outline-none" @class}}
        tabindex="0"
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export { Tabs, TabsList, TabsTrigger, TabsContent };
