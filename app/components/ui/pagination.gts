import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
// import PhCaretLeft from 'ember-phosphor-icons/components/ph-caret-left';
// import PhCaretRight from 'ember-phosphor-icons/components/ph-caret-right';
// import PhDotsThree from 'ember-phosphor-icons/components/ph-dots-three';
import ChevronLeft from '~icons/lucide/chevron-left';
import ChevronRight from '~icons/lucide/chevron-right';
import MoreHorizontal from '~icons/lucide/more-horizontal';
import { buttonVariants } from './button.gts';

// Pagination Root Component
interface PaginationSignature {
  Element: HTMLElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const Pagination: TOC<PaginationSignature> = <template>
  <nav
    role="navigation"
    aria-label="pagination"
    class={{cn "mx-auto flex w-full justify-center" @class}}
    ...attributes
  >
    {{yield}}
  </nav>
</template>;

// PaginationContent Component
interface PaginationContentSignature {
  Element: HTMLUListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const PaginationContent: TOC<PaginationContentSignature> = <template>
  <ul class={{cn "flex flex-row items-center gap-1" @class}} ...attributes>
    {{yield}}
  </ul>
</template>;

// PaginationItem Component
interface PaginationItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const PaginationItem: TOC<PaginationItemSignature> = <template>
  <li class={{cn @class}} ...attributes>
    {{yield}}
  </li>
</template>;

// PaginationLink Component
interface PaginationLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    class?: string;
    isActive?: boolean;
    size?: 'default' | 'sm' | 'lg' | 'icon';
  };
  Blocks: {
    default: [];
  };
}

export class PaginationLink extends Component<PaginationLinkSignature> {
  get classes() {
    const variant = this.args.isActive ? 'outline' : 'ghost';
    const size = this.args.size ?? 'icon';
    return buttonVariants(variant, size, this.args.class);
  }

  <template>
    {{! template-lint-disable link-href-attributes }}
    <a
      class={{this.classes}}
      aria-current={{if @isActive "page"}}
      ...attributes
    >
      {{yield}}
    </a>
  </template>
}

// PaginationPrevious Component
interface PaginationPreviousSignature {
  Element: HTMLAnchorElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const PaginationPrevious: TOC<PaginationPreviousSignature> = <template>
  <PaginationLink
    aria-label="Go to previous page"
    @size="default"
    class={{cn "gap-1 pl-2.5" @class}}
    ...attributes
  >
    <ChevronLeft class="size-4" />
    <span>Previous</span>
  </PaginationLink>
</template>;

// PaginationNext Component
interface PaginationNextSignature {
  Element: HTMLAnchorElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const PaginationNext: TOC<PaginationNextSignature> = <template>
  <PaginationLink
    aria-label="Go to next page"
    @size="default"
    class={{cn "gap-1 pr-2.5" @class}}
    ...attributes
  >
    <span>Next</span>
    <ChevronRight class="size-4" />
  </PaginationLink>
</template>;

// PaginationEllipsis Component
interface PaginationEllipsisSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const PaginationEllipsis: TOC<PaginationEllipsisSignature> = <template>
  <span
    aria-hidden="true"
    class={{cn "flex h-9 w-9 items-center justify-center" @class}}
    ...attributes
  >
    <MoreHorizontal class="size-4" />
    <span class="sr-only">More pages</span>
  </span>
</template>;

export default Pagination;
