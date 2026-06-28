import { hash } from '@ember/helper';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

type State = 'idle' | 'uploading' | 'processing' | 'error' | 'done';
type Size = 'default' | 'sm' | 'xs';
type Orientation = 'horizontal' | 'vertical';
type MediaVariant = 'icon' | 'image';

function attachmentVariants(
  size: Size = 'default',
  orientation: Orientation = 'horizontal',
  className?: string
): string {
  const baseClasses =
    'group/attachment relative flex w-fit max-w-full min-w-0 shrink-0 flex-wrap rounded-xl border bg-card text-card-foreground transition-colors focus-within:ring-1 focus-within:ring-ring/50 has-[>a,>button]:hover:bg-muted/50 data-[state=error]:border-destructive/30 data-[state=idle]:border-dashed';

  const sizeClasses: Record<Size, string> = {
    default:
      'gap-2 text-sm has-data-[slot=attachment-content]:px-2.5 has-data-[slot=attachment-content]:py-2 has-data-[slot=attachment-media]:p-2',
    sm: 'gap-2.5 text-xs has-data-[slot=attachment-content]:px-2 has-data-[slot=attachment-content]:py-1.5 has-data-[slot=attachment-media]:p-1.5',
    xs: 'gap-1.5 rounded-lg text-xs has-data-[slot=attachment-content]:px-1.5 has-data-[slot=attachment-content]:py-1 has-data-[slot=attachment-media]:p-1',
  };

  const orientationClasses: Record<Orientation, string> = {
    horizontal: 'min-w-40 items-center',
    vertical: 'w-24 flex-col has-data-[slot=attachment-content]:w-30',
  };

  return cn(
    baseClasses,
    sizeClasses[size],
    orientationClasses[orientation],
    className
  );
}

interface AttachmentSignature {
  Element: HTMLDivElement;
  Args: {
    state?: State;
    size?: Size;
    orientation?: Orientation;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Attachment extends Component<AttachmentSignature> {
  get state(): State {
    return this.args.state ?? 'done';
  }

  get size(): Size {
    return this.args.size ?? 'default';
  }

  get orientation(): Orientation {
    return this.args.orientation ?? 'horizontal';
  }

  get classes() {
    return attachmentVariants(this.size, this.orientation, this.args.class);
  }

  <template>
    <div
      class={{this.classes}}
      data-orientation={{this.orientation}}
      data-size={{this.size}}
      data-slot="attachment"
      data-state={{this.state}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

function attachmentMediaVariants(
  variant: MediaVariant = 'icon',
  className?: string
): string {
  const baseClasses =
    "relative flex aspect-square w-10 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-muted text-foreground group-data-[orientation=vertical]/attachment:w-full group-data-[size=sm]/attachment:w-8 group-data-[size=xs]/attachment:w-7 group-data-[size=xs]/attachment:rounded-md group-data-[state=error]/attachment:bg-destructive/10 group-data-[state=error]/attachment:text-destructive group-data-[orientation=vertical]/attachment:*:data-[slot=spinner]:size-6! [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 group-data-[orientation=vertical]/attachment:[&_svg:not([class*='size-'])]:size-6 group-data-[size=xs]/attachment:[&_svg:not([class*='size-'])]:size-3.5";

  const variantClasses: Record<MediaVariant, string> = {
    icon: '',
    image:
      'opacity-60 group-data-[state=done]/attachment:opacity-100 group-data-[state=idle]/attachment:opacity-100 *:[img]:aspect-square *:[img]:w-full *:[img]:object-cover',
  };

  return cn(baseClasses, variantClasses[variant], className);
}

interface AttachmentMediaSignature {
  Element: HTMLDivElement;
  Args: {
    variant?: MediaVariant;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentMedia: TOC<AttachmentMediaSignature> = <template>
  <div
    class={{attachmentMediaVariants @variant @class}}
    data-slot="attachment-media"
    data-variant={{if @variant @variant "icon"}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface AttachmentContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentContent: TOC<AttachmentContentSignature> = <template>
  <div
    class={{cn
      "max-w-full min-w-0 flex-1 leading-tight group-data-[orientation=vertical]/attachment:px-1"
      @class
    }}
    data-slot="attachment-content"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface AttachmentTitleSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentTitle: TOC<AttachmentTitleSignature> = <template>
  <span
    class={{cn
      "block max-w-full min-w-0 truncate font-medium group-data-[state=processing]/attachment:shimmer group-data-[state=uploading]/attachment:shimmer"
      @class
    }}
    data-slot="attachment-title"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

interface AttachmentDescriptionSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentDescription: TOC<AttachmentDescriptionSignature> = <template>
  <span
    class={{cn
      "mt-0.5 block min-w-0 truncate text-xs text-muted-foreground group-data-[state=error]/attachment:text-destructive/80"
      "max-w-full"
      @class
    }}
    data-slot="attachment-description"
    ...attributes
  >
    {{yield}}
  </span>
</template>;

interface AttachmentActionsSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentActions: TOC<AttachmentActionsSignature> = <template>
  <div
    class={{cn
      "relative z-20 flex shrink-0 items-center group-data-[orientation=vertical]/attachment:absolute group-data-[orientation=vertical]/attachment:top-3 group-data-[orientation=vertical]/attachment:right-3 group-data-[orientation=vertical]/attachment:gap-1"
      @class
    }}
    data-slot="attachment-actions"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface AttachmentActionSignature {
  Element: HTMLButtonElement;
  Args: {
    variant?:
      | 'default'
      | 'destructive'
      | 'outline'
      | 'secondary'
      | 'ghost'
      | 'link';
    size?: 'default' | 'sm' | 'lg' | 'icon' | 'icon-xs' | 'icon-sm' | 'icon-lg';
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentAction: TOC<AttachmentActionSignature> = <template>
  <Button
    @class={{@class}}
    @size={{if @size @size "icon-xs"}}
    @variant={{if @variant @variant "ghost"}}
    data-slot="attachment-action"
    ...attributes
  >
    {{yield}}
  </Button>
</template>;

interface AttachmentTriggerSignature {
  Element: HTMLButtonElement;
  Args: {
    asChild?: boolean;
    class?: string;
    type?: 'button' | 'submit' | 'reset';
  };
  Blocks: {
    default: [{ classes: string }?];
  };
}

class AttachmentTrigger extends Component<AttachmentTriggerSignature> {
  get classes() {
    return cn('absolute inset-0 z-10 outline-none', this.args.class);
  }

  <template>
    {{#if @asChild}}
      {{yield (hash classes=this.classes)}}
    {{else}}
      <button
        class={{this.classes}}
        data-slot="attachment-trigger"
        type={{if @type @type "button"}}
        ...attributes
      >
        {{yield}}
      </button>
    {{/if}}
  </template>
}

interface AttachmentGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const AttachmentGroup: TOC<AttachmentGroupSignature> = <template>
  <div
    class={{cn
      "flex min-w-0 scroll-fade-x snap-x snap-mandatory scroll-px-1 scrollbar-none gap-3 overflow-x-auto overscroll-x-contain py-1 *:data-[slot=attachment]:flex-none *:data-[slot=attachment]:snap-start"
      @class
    }}
    data-slot="attachment-group"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export {
  Attachment,
  AttachmentGroup,
  AttachmentMedia,
  AttachmentContent,
  AttachmentTitle,
  AttachmentDescription,
  AttachmentActions,
  AttachmentAction,
  AttachmentTrigger,
};
