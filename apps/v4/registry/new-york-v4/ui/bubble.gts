import { hash } from '@ember/helper';
import Component from '@glimmer/component';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

type Variant =
  | 'default'
  | 'secondary'
  | 'muted'
  | 'tinted'
  | 'outline'
  | 'ghost'
  | 'destructive';

type Align = 'start' | 'end';
type Side = 'top' | 'bottom';

function bubbleVariants(
  variant: Variant = 'default',
  className?: string
): string {
  const baseClasses =
    'group/bubble relative flex w-fit max-w-[80%] min-w-0 flex-col gap-1 group-data-[align=end]/message:self-end data-[align=end]:self-end data-[variant=ghost]:max-w-full';

  const variantClasses: Record<Variant, string> = {
    default:
      '*:data-[slot=bubble-content]:bg-primary *:data-[slot=bubble-content]:text-primary-foreground [&>[data-slot=bubble-content]:is(button,a):hover]:bg-primary/80',
    secondary:
      '*:data-[slot=bubble-content]:bg-secondary *:data-[slot=bubble-content]:text-secondary-foreground [&>[data-slot=bubble-content]:is(button,a):hover]:bg-[color-mix(in_oklch,var(--secondary),var(--foreground)_5%)]',
    muted:
      '*:data-[slot=bubble-content]:bg-muted [&>[data-slot=bubble-content]:is(button,a):hover]:bg-[color-mix(in_oklch,var(--muted),var(--foreground)_5%)]',
    tinted:
      '*:data-[slot=bubble-content]:bg-[oklch(from_var(--primary)_0.93_calc(c*0.4)_h)] *:data-[slot=bubble-content]:text-foreground dark:*:data-[slot=bubble-content]:bg-[oklch(from_var(--primary)_0.3_calc(c*0.4)_h)] [&>[data-slot=bubble-content]:is(button,a):hover]:bg-[oklch(from_var(--primary)_0.88_calc(c*0.5)_h)] dark:[&>[data-slot=bubble-content]:is(button,a):hover]:bg-[oklch(from_var(--primary)_0.35_calc(c*0.5)_h)]',
    outline:
      '*:data-[slot=bubble-content]:border-border *:data-[slot=bubble-content]:bg-background [&>[data-slot=bubble-content]:is(button,a):hover]:bg-muted [&>[data-slot=bubble-content]:is(button,a):hover]:text-foreground dark:[&>[data-slot=bubble-content]:is(button,a):hover]:bg-input/30',
    ghost:
      'border-none *:data-[slot=bubble-content]:rounded-none *:data-[slot=bubble-content]:bg-transparent *:data-[slot=bubble-content]:p-0 [&>[data-slot=bubble-content]:is(button,a):hover]:bg-muted [&>[data-slot=bubble-content]:is(button,a):hover]:text-foreground dark:[&>[data-slot=bubble-content]:is(button,a):hover]:bg-muted/50',
    destructive:
      '*:data-[slot=bubble-content]:bg-destructive/10 *:data-[slot=bubble-content]:text-destructive dark:*:data-[slot=bubble-content]:bg-destructive/20 [&>[data-slot=bubble-content]:is(button,a):hover]:bg-destructive/20 dark:[&>[data-slot=bubble-content]:is(button,a):hover]:bg-destructive/30',
  };

  return cn(baseClasses, variantClasses[variant], className);
}

function bubbleReactionsVariants(
  side: Side = 'bottom',
  align: Align = 'end',
  className?: string
): string {
  const baseClasses =
    'absolute z-10 flex w-fit shrink-0 items-center justify-center gap-1 rounded-full bg-muted px-1.5 py-0.5 text-sm ring-3 ring-card has-[button]:p-0';

  const sideClasses: Record<Side, string> = {
    top: 'top-0 -translate-y-3/4',
    bottom: 'bottom-0 translate-y-3/4',
  };

  const alignClasses: Record<Align, string> = {
    start: 'left-3',
    end: 'right-3',
  };

  return cn(baseClasses, sideClasses[side], alignClasses[align], className);
}

interface BubbleGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const BubbleGroup: TOC<BubbleGroupSignature> = <template>
  <div
    class={{cn "flex min-w-0 flex-col gap-2" @class}}
    data-slot="bubble-group"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface BubbleSignature {
  Element: HTMLDivElement;
  Args: {
    variant?: Variant;
    align?: Align;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Bubble extends Component<BubbleSignature> {
  get variant(): Variant {
    return this.args.variant ?? 'default';
  }

  get align(): Align {
    return this.args.align ?? 'start';
  }

  get classes() {
    return bubbleVariants(this.variant, this.args.class);
  }

  <template>
    <div
      class={{this.classes}}
      data-align={{this.align}}
      data-slot="bubble"
      data-variant={{this.variant}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface BubbleContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [{ classes: string }?];
  };
}

class BubbleContent extends Component<BubbleContentSignature> {
  get classes() {
    return cn(
      'w-fit max-w-full min-w-0 overflow-hidden rounded-3xl border border-transparent px-3 py-2.5 text-sm leading-relaxed wrap-break-word group-data-[align=end]/bubble:self-end [button]:text-left [button,a]:transition-colors [button,a]:outline-none [button,a]:focus-visible:border-ring [button,a]:focus-visible:ring-3 [button,a]:focus-visible:ring-ring/30',
      this.args.class
    );
  }

  <template>
    {{#if @asChild}}
      {{yield (hash classes=this.classes)}}
    {{else}}
      <div class={{this.classes}} data-slot="bubble-content" ...attributes>
        {{yield}}
      </div>
    {{/if}}
  </template>
}

interface BubbleReactionsSignature {
  Element: HTMLDivElement;
  Args: {
    side?: Side;
    align?: Align;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class BubbleReactions extends Component<BubbleReactionsSignature> {
  get side(): Side {
    return this.args.side ?? 'bottom';
  }

  get align(): Align {
    return this.args.align ?? 'end';
  }

  get classes() {
    return bubbleReactionsVariants(this.side, this.align, this.args.class);
  }

  <template>
    <div
      class={{this.classes}}
      data-align={{this.align}}
      data-side={{this.side}}
      data-slot="bubble-reactions"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

export {
  BubbleGroup,
  Bubble,
  BubbleContent,
  BubbleReactions,
  bubbleVariants,
  bubbleReactionsVariants,
};
