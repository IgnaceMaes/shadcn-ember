/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

// Note: This is a placeholder/simplified version of the NavigationMenu component
// Full implementation would require more complex state management and positioning

// NavigationMenu Root Component
interface NavigationMenuSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenu extends Component<NavigationMenuSignature> {
  <template>
    <nav
      class={{cn
        "relative z-10 flex max-w-max flex-1 items-center justify-center"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </nav>
  </template>
}

// NavigationMenuList Component
interface NavigationMenuListSignature {
  Element: HTMLUListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuList extends Component<NavigationMenuListSignature> {
  <template>
    <ul
      class={{cn
        "group flex flex-1 list-none items-center justify-center space-x-1"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </ul>
  </template>
}

// NavigationMenuItem Component
interface NavigationMenuItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuItem extends Component<NavigationMenuItemSignature> {
  <template>
    <li class={{cn @class}} ...attributes>
      {{yield}}
    </li>
  </template>
}

// NavigationMenuTrigger Component
interface NavigationMenuTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuTrigger extends Component<NavigationMenuTriggerSignature> {
  <template>
    <button
      type="button"
      class={{cn
        "group inline-flex h-9 w-max items-center justify-center rounded-md bg-background px-4 py-2 text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground focus:outline-none disabled:pointer-events-none disabled:opacity-50"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </button>
  </template>
}

// NavigationMenuContent Component
interface NavigationMenuContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuContent extends Component<NavigationMenuContentSignature> {
  <template>
    <div
      class={{cn "left-0 top-0 w-full md:absolute md:w-auto" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// NavigationMenuLink Component
interface NavigationMenuLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuLink extends Component<NavigationMenuLinkSignature> {
  <template>
    {{! template-lint-disable link-href-attributes }}
    <a class={{cn @class}} ...attributes>
      {{yield}}
    </a>
  </template>
}

// NavigationMenuViewport Component
interface NavigationMenuViewportSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuViewport extends Component<NavigationMenuViewportSignature> {
  <template>
    <div class="absolute left-0 top-full flex justify-center">
      <div
        class={{cn
          "relative mt-1.5 h-auto w-full overflow-hidden rounded-md border bg-popover text-popover-foreground shadow"
          @class
        }}
        ...attributes
      >
        {{yield}}
      </div>
    </div>
  </template>
}

// NavigationMenuIndicator Component
interface NavigationMenuIndicatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class NavigationMenuIndicator extends Component<NavigationMenuIndicatorSignature> {
  <template>
    <div class={{cn @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export default NavigationMenu;
