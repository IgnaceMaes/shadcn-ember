import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike, ModifierLike } from '@glint/template';
import { tracked } from '@glimmer/tracking';
import { hash, fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { Popover as EmberPrimitivesPopover } from 'ember-primitives';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { cn } from '@/lib/utils';

interface PopoverSignature {
  Args: {
    placement?:
      | 'top'
      | 'right'
      | 'bottom'
      | 'left'
      | 'top-start'
      | 'top-end'
      | 'right-start'
      | 'right-end'
      | 'bottom-start'
      | 'bottom-end'
      | 'left-start'
      | 'left-end';
    offsetOptions?: number;
  };
  Blocks: {
    default: [
      {
        Trigger: ComponentLike<PopoverTriggerSignature>;
        Content: ComponentLike<PopoverContentSignature>;
        Anchor: ComponentLike<PopoverAnchorSignature>;
      },
    ];
  };
}

class Popover extends Component<PopoverSignature> {
  @tracked isOpen = false;

  handleClick = () => {
    this.isOpen = !this.isOpen;
  };

  close = () => {
    this.isOpen = false;
  };

  <template>
    <EmberPrimitivesPopover
      data-slot="popover"
      @placement={{if @placement @placement "bottom"}}
      @offsetOptions={{if @offsetOptions @offsetOptions 4}}
      as |p|
    >
      {{yield
        (hash
          Trigger=(component
            PopoverTrigger reference=p.reference onClick=this.handleClick
          )
          Content=(component
            PopoverContent
            isOpen=this.isOpen
            close=this.close
            popoverContent=p.Content
          )
          Anchor=(component PopoverAnchor)
        )
      }}
    </EmberPrimitivesPopover>
  </template>
}

interface PopoverTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
    reference?: ModifierLike<{
      Element: HTMLElement | SVGElement;
    }>;
    onClick?: () => void;
  };
  Blocks: {
    default: [];
  };
}

const PopoverTrigger: TOC<PopoverTriggerSignature> = <template>
  {{#if @asChild}}
    <span
      role="button"
      tabindex="0"
      {{@reference}}
      {{on "click" (if @onClick @onClick (fn))}}
      ...attributes
    >
      {{yield}}
    </span>
  {{else}}
    <button
      data-slot="popover-trigger"
      type="button"
      class={{cn @class}}
      {{@reference}}
      {{on "click" (if @onClick @onClick (fn))}}
      ...attributes
    >
      {{yield}}
    </button>
  {{/if}}
</template>;

interface PopoverAnchorSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const PopoverAnchor: TOC<PopoverAnchorSignature> = <template>
  <div data-slot="popover-anchor" class={{cn @class}} ...attributes>
    {{yield}}
  </div>
</template>;

interface PopoverContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    align?: 'center' | 'start' | 'end';
    sideOffset?: number;
    popoverContent?: ComponentLike<{
      Element: HTMLDivElement;
      Args: { as?: string; class?: string };
      Blocks: { default: [] };
    }>;
    isOpen?: boolean;
    close?: () => void;
  };
  Blocks: {
    default: [];
  };
}

const PopoverContent: TOC<PopoverContentSignature> = <template>
  {{#if @isOpen}}
    {{#let @popoverContent as |Content|}}
      {{#if @close}}
        <Content
          @as="div"
          data-slot="popover-content"
          class={{cn
            "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 w-72 origin-(--radix-popover-content-transform-origin) rounded-md border p-4 shadow-md outline-hidden"
            @class
          }}
          data-state={{if @isOpen "open" "closed"}}
          {{onClickOutside @close}}
          ...attributes
        >
          {{yield}}
        </Content>
      {{else}}
        <Content
          @as="div"
          data-slot="popover-content"
          class={{cn
            "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 w-72 origin-(--radix-popover-content-transform-origin) rounded-md border p-4 shadow-md outline-hidden"
            @class
          }}
          data-state={{if @isOpen "open" "closed"}}
          ...attributes
        >
          {{yield}}
        </Content>
      {{/if}}
    {{/let}}
  {{/if}}
</template>;

export { Popover, PopoverTrigger, PopoverContent, PopoverAnchor };
