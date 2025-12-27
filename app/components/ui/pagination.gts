import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
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

const Pagination: TOC<PaginationSignature> = <template>
  <nav
    role="navigation"
    aria-label="pagination"
    data-slot="pagination"
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

const PaginationContent: TOC<PaginationContentSignature> = <template>
  <ul
    data-slot="pagination-content"
    class={{cn "flex flex-row items-center gap-1" @class}}
    ...attributes
  >
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

const PaginationItem: TOC<PaginationItemSignature> = <template>
  <li data-slot="pagination-item" ...attributes>
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

class PaginationLink extends Component<PaginationLinkSignature> {
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
      data-slot="pagination-link"
      data-active={{@isActive}}
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

const PaginationPrevious: TOC<PaginationPreviousSignature> = <template>
  <PaginationLink
    aria-label="Go to previous page"
    @size="default"
    class={{cn "gap-1 px-2.5 sm:pl-2.5" @class}}
    ...attributes
  >
    <ChevronLeft />
    <span class="hidden sm:block">Previous</span>
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

const PaginationNext: TOC<PaginationNextSignature> = <template>
  <PaginationLink
    aria-label="Go to next page"
    @size="default"
    class={{cn "gap-1 px-2.5 sm:pr-2.5" @class}}
    ...attributes
  >
    <span class="hidden sm:block">Next</span>
    <ChevronRight />
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

const PaginationEllipsis: TOC<PaginationEllipsisSignature> = <template>
  <span
    aria-hidden="true"
    data-slot="pagination-ellipsis"
    class={{cn "flex size-9 items-center justify-center" @class}}
    ...attributes
  >
    <MoreHorizontal class="size-4" />
    <span class="sr-only">More pages</span>
  </span>
</template>;

export {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationPrevious,
  PaginationNext,
  PaginationEllipsis,
};
