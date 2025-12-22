/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
import Separator from './separator.gts';

// Note: This is a simplified placeholder for the Item component
// Used for list items with consistent styling

type Variant = 'default' | 'outline' | 'muted';
type Size = 'default' | 'sm';

function itemVariants(
  variant: Variant = 'default',
  size: Size = 'default',
  className?: string
): string {
  const baseClasses =
    'group/item flex flex-wrap items-center rounded-md border border-transparent text-sm outline-none transition-colors duration-100';

  const variantClasses: Record<Variant, string> = {
    default: 'bg-transparent',
    outline: 'border-border',
    muted: 'bg-muted/50',
  };

  const sizeClasses: Record<Size, string> = {
    default: 'gap-4 p-4',
    sm: 'gap-2.5 px-4 py-3',
  };

  return cn(baseClasses, variantClasses[variant], sizeClasses[size], className);
}

// ItemGroup Component
interface ItemGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ItemGroup extends Component<ItemGroupSignature> {
  <template>
    <div
      role="list"
      data-slot="item-group"
      class={{cn "group/item-group flex flex-col" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

// ItemSeparator Component
interface ItemSeparatorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ItemSeparator extends Component<ItemSeparatorSignature> {
  <template>
    <Separator
      data-slot="item-separator"
      @orientation="horizontal"
      class={{cn "my-0" @class}}
      ...attributes
    />
  </template>
}

// Item Component
interface ItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    variant?: Variant;
    size?: Size;
  };
  Blocks: {
    default: [];
  };
}

export class Item extends Component<ItemSignature> {
  get classes() {
    return itemVariants(
      this.args.variant ?? 'default',
      this.args.size ?? 'default',
      this.args.class
    );
  }

  <template>
    <div class={{this.classes}} role="listitem" ...attributes>
      {{yield}}
    </div>
  </template>
}

// ItemLabel Component
interface ItemLabelSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ItemLabel extends Component<ItemLabelSignature> {
  <template>
    <div class={{cn "font-medium" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

// ItemDescription Component
interface ItemDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class ItemDescription extends Component<ItemDescriptionSignature> {
  <template>
    <div class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export default Item;
export { itemVariants };
