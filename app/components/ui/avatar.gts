import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { eq } from 'ember-truth-helpers';
import { cn } from '@/lib/utils';

interface AvatarSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const Avatar: TOC<AvatarSignature> = <template>
  <div
    data-slot="avatar"
    class={{cn
      "relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface AvatarImageSignature {
  Element: HTMLImageElement;
  Args: {
    src: string;
    alt?: string;
    class?: string;
    onLoadingStatusChange?: (
      status: 'idle' | 'loading' | 'loaded' | 'error'
    ) => void;
  };
}

export class AvatarImage extends Component<AvatarImageSignature> {
  @tracked loadingStatus: 'idle' | 'loading' | 'loaded' | 'error' = 'loading';

  handleLoad = () => {
    this.loadingStatus = 'loaded';
    this.args.onLoadingStatusChange?.('loaded');
  };

  handleError = () => {
    this.loadingStatus = 'error';
    this.args.onLoadingStatusChange?.('error');
  };

  <template>
    {{#unless (eq this.loadingStatus "error")}}
      <img
        src={{@src}}
        alt={{if @alt @alt ""}}
        class={{cn "aspect-square h-full w-full" @class}}
        {{on "load" this.handleLoad}}
        {{on "error" this.handleError}}
        ...attributes
      />
    {{/unless}}
  </template>
}

interface AvatarFallbackSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    delayMs?: number;
  };
  Blocks: {
    default: [];
  };
}

export const AvatarFallback: TOC<AvatarFallbackSignature> = <template>
  <div
    class={{cn
      "flex h-full w-full items-center justify-center rounded-full bg-muted"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export { Avatar as default };
