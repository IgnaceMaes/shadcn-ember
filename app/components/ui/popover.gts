import Component from '@glimmer/component';
import type Owner from '@ember/owner';
import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';
import { tracked } from '@glimmer/tracking';
import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { modifier } from 'ember-modifier';
import onClickOutside from 'ember-click-outside/modifiers/on-click-outside';
import { cn } from '@/lib/utils';
import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate,
  type Placement,
} from '@floating-ui/dom';

interface PopoverYields {
  Trigger: ComponentLike<PopoverTriggerSignature>;
  Content: ComponentLike<PopoverContentSignature>;
  Anchor: ComponentLike<PopoverAnchorSignature>;
}

interface PopoverSignature {
  Args: {
    open?: boolean;
    defaultOpen?: boolean;
    onOpenChange?: (open: boolean) => void;
  };
  Blocks: {
    default: [PopoverYields];
  };
}

class Popover extends Component<PopoverSignature> {
  @tracked isOpen: boolean;
  @tracked triggerElement: HTMLElement | null = null;

  constructor(owner: Owner, args: PopoverSignature['Args']) {
    super(owner, args);
    this.isOpen = args.open ?? args.defaultOpen ?? false;
  }

  get open() {
    return this.args.open ?? this.isOpen;
  }

  setOpen = (open: boolean) => {
    this.isOpen = open;
    this.args.onOpenChange?.(open);
  };

  setTriggerElement = (element: HTMLElement | null) => {
    this.triggerElement = element;
  };

  <template>
    <div data-slot="popover">
      {{yield
        (hash
          Trigger=(component
            PopoverTrigger
            isOpen=this.open
            setOpen=this.setOpen
            setTriggerElement=this.setTriggerElement
          )
          Content=(component
            PopoverContent
            isOpen=this.open
            setOpen=this.setOpen
            triggerElement=this.triggerElement
          )
          Anchor=(component PopoverAnchor)
        )
      }}
    </div>
  </template>
}

interface PopoverTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
    asChild?: boolean;
    setOpen?: (open: boolean) => void;
    isOpen?: boolean;
    setTriggerElement?: (element: HTMLElement | null) => void;
  };
  Blocks: {
    default: [];
  };
}

class PopoverTrigger extends Component<PopoverTriggerSignature> {
  handleClick = () => {
    const newOpen = !this.args.isOpen;
    this.args.setOpen?.(newOpen);
  };

  registerElement = modifier((element: HTMLElement) => {
    this.args.setTriggerElement?.(element);
    return () => {
      this.args.setTriggerElement?.(null);
    };
  });

  <template>
    {{#if @asChild}}
      <span
        data-slot="popover-trigger"
        role="button"
        tabindex="0"
        {{this.registerElement}}
        {{on "click" this.handleClick}}
        {{on "keydown" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </span>
    {{else}}
      <button
        type="button"
        class={{cn @class}}
        data-slot="popover-trigger"
        {{this.registerElement}}
        {{on "click" this.handleClick}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

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
    align?: 'start' | 'center' | 'end';
    side?: 'top' | 'right' | 'bottom' | 'left';
    sideOffset?: number;
    isOpen?: boolean;
    setOpen?: (open: boolean) => void;
    triggerElement?: HTMLElement | null;
  };
  Blocks: {
    default: [];
  };
}

class PopoverContent extends Component<PopoverContentSignature> {
  @tracked x = 0;
  @tracked y = 0;
  private cleanup?: () => void;

  handleClickOutside = () => {
    this.args.setOpen?.(false);
  };

  positionContent = modifier(
    (
      element: HTMLElement,
      [triggerElement]: [HTMLElement | null | undefined]
    ) => {
      if (!triggerElement) return;

      const align = this.args.align ?? 'center';
      const side = this.args.side ?? 'bottom';
      const placementMap: Record<string, Placement> = {
        'top-start': 'top-start',
        'top-center': 'top',
        'top-end': 'top-end',
        'right-start': 'right-start',
        'right-center': 'right',
        'right-end': 'right-end',
        'bottom-start': 'bottom-start',
        'bottom-center': 'bottom',
        'bottom-end': 'bottom-end',
        'left-start': 'left-start',
        'left-center': 'left',
        'left-end': 'left-end',
      };

      const placement =
        placementMap[`${side}-${align}`] || ('bottom' as Placement);

      const update = () => {
        void computePosition(triggerElement, element, {
          placement,
          strategy: 'fixed',
          middleware: [
            offset(this.args.sideOffset ?? 4),
            flip(),
            shift({ padding: 8 }),
          ],
        }).then(({ x, y }) => {
          this.x = x;
          this.y = y;
        });
      };

      this.cleanup = autoUpdate(triggerElement, element, update);

      return () => {
        this.cleanup?.();
      };
    }
  );

  get positionStyle(): string {
    return `position: fixed; left: ${this.x}px; top: ${this.y}px; z-index: 50;`;
  }

  <template>
    {{#if @isOpen}}
      <div
        data-slot="popover-content"
        class={{cn
          "bg-popover text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 z-50 w-72 origin-(--radix-popover-content-transform-origin) rounded-md border p-4 shadow-md outline-hidden"
          @class
        }}
        data-state={{if @isOpen "open" "closed"}}
        data-side={{if @side @side "bottom"}}
        data-align={{if @align @align "center"}}
        style={{this.positionStyle}}
        {{this.positionContent @triggerElement}}
        {{onClickOutside this.handleClickOutside}}
        ...attributes
      >
        {{yield}}
      </div>
    {{/if}}
  </template>
}

export { Popover, PopoverTrigger, PopoverContent, PopoverAnchor };
