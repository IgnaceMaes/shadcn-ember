import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike, ModifierLike } from '@glint/template';
import { tracked } from '@glimmer/tracking';
import { fn, hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { Popover } from 'ember-primitives';
import { cn } from '@/lib/utils';

interface TooltipProviderSignature {
  Args: {
    delayDuration?: number;
    skipDelayDuration?: number;
  };
  Blocks: {
    default: [];
  };
}

const TooltipProvider: TOC<TooltipProviderSignature> = <template>
  {{! template-lint-disable no-yield-only }}
  {{yield}}
</template>;

interface TooltipSignature {
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
        Trigger: ComponentLike<TooltipTriggerSignature>;
        Content: ComponentLike<TooltipContentSignature>;
      },
    ];
  };
}

class Tooltip extends Component<TooltipSignature> {
  @tracked isOpen = false;

  handleMouseEnter = () => {
    this.isOpen = true;
  };

  handleMouseLeave = () => {
    this.isOpen = false;
  };

  handleFocus = () => {
    this.isOpen = true;
  };

  handleBlur = () => {
    this.isOpen = false;
  };

  <template>
    <Popover
      @placement={{if @placement @placement "top"}}
      @offsetOptions={{if @offsetOptions @offsetOptions 4}}
      as |p|
    >
      {{yield
        (hash
          Trigger=(component
            TooltipTrigger
            reference=p.reference
            onMouseEnter=this.handleMouseEnter
            onMouseLeave=this.handleMouseLeave
            onFocus=this.handleFocus
            onBlur=this.handleBlur
          )
          Content=(component
            TooltipContent
            isOpen=this.isOpen
            popoverContent=p.Content
            arrow=p.arrow
          )
        )
      }}
    </Popover>
  </template>
}

interface TooltipTriggerSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
    reference?: ModifierLike<{
      Element: HTMLElement | SVGElement;
    }>;
    onMouseEnter?: () => void;
    onMouseLeave?: () => void;
    onFocus?: () => void;
    onBlur?: () => void;
  };
  Blocks: {
    default: [];
  };
}

const TooltipTrigger: TOC<TooltipTriggerSignature> = <template>
  <span
    class={{cn "inline-block" @class}}
    {{@reference}}
    {{on "mouseenter" (if @onMouseEnter @onMouseEnter (fn))}}
    {{on "mouseleave" (if @onMouseLeave @onMouseLeave (fn))}}
    {{on "focus" (if @onFocus @onFocus (fn))}}
    {{on "blur" (if @onBlur @onBlur (fn))}}
    ...attributes
  >
    {{yield}}
  </span>
</template>;

interface TooltipContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    sideOffset?: number;
    popoverContent?: ComponentLike<{
      Element: HTMLDivElement;
      Args: { as?: string; class?: string };
      Blocks: { default: [] };
    }>;
    isOpen?: boolean;
    arrow?: ModifierLike<{
      Element: HTMLElement;
    }>;
  };
  Blocks: {
    default: [];
  };
}

const TooltipContent: TOC<TooltipContentSignature> = <template>
  {{#if @isOpen}}
    {{#let @popoverContent as |Content|}}
      <Content
        @as="div"
        class={{cn
          "z-50 overflow-hidden rounded-md bg-foreground px-3 py-1.5 text-xs text-background animate-in fade-in-0 zoom-in-95"
          @class
        }}
        role="tooltip"
        ...attributes
      >
        {{yield}}
        <div class="absolute bg-foreground size-2 rotate-45" {{@arrow}}></div>
      </Content>
    {{/let}}
  {{/if}}
</template>;

export { Tooltip, TooltipTrigger, TooltipContent, TooltipProvider };
