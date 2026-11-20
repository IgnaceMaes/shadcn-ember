import Component from '@glimmer/component';

import { cn } from '@/lib/utils';

import type { TOC } from '@ember/component/template-only';

type Align = 'start' | 'end';

interface MessageGroupSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MessageGroup: TOC<MessageGroupSignature> = <template>
  <div
    class={{cn "flex min-w-0 flex-col gap-2" @class}}
    data-slot="message-group"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface MessageSignature {
  Element: HTMLDivElement;
  Args: {
    align?: Align;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class Message extends Component<MessageSignature> {
  get align(): Align {
    return this.args.align ?? 'start';
  }

  get classes() {
    return cn(
      'group/message relative flex w-full min-w-0 gap-2 text-sm data-[align=end]:flex-row-reverse',
      this.args.class
    );
  }

  <template>
    <div
      class={{this.classes}}
      data-align={{this.align}}
      data-slot="message"
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface MessageAvatarSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MessageAvatar: TOC<MessageAvatarSignature> = <template>
  <div
    class={{cn
      "flex w-fit min-w-8 shrink-0 items-center justify-center self-end overflow-hidden rounded-full bg-muted group-has-data-[slot=message-footer]/message:-translate-y-8"
      @class
    }}
    data-slot="message-avatar"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface MessageContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MessageContent: TOC<MessageContentSignature> = <template>
  <div
    class={{cn
      "flex w-full min-w-0 flex-col gap-2.5 wrap-break-word group-data-[align=end]/message:*:data-slot:self-end"
      @class
    }}
    data-slot="message-content"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface MessageHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MessageHeader: TOC<MessageHeaderSignature> = <template>
  <div
    class={{cn
      "flex max-w-full min-w-0 items-center px-3 text-xs font-medium text-muted-foreground group-has-data-[variant=ghost]/message:px-0"
      @class
    }}
    data-slot="message-header"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface MessageFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const MessageFooter: TOC<MessageFooterSignature> = <template>
  <div
    class={{cn
      "flex max-w-full min-w-0 items-center px-3 text-xs font-medium text-muted-foreground group-has-data-[variant=ghost]/message:px-0 group-data-[align=end]/message:justify-end"
      @class
    }}
    data-slot="message-footer"
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export {
  MessageGroup,
  Message,
  MessageAvatar,
  MessageContent,
  MessageFooter,
  MessageHeader,
};
