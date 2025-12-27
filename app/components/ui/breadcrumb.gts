import type { TOC } from '@ember/component/template-only';
import ChevronRight from '~icons/lucide/chevron-right';
import MoreHorizontal from '~icons/lucide/more-horizontal';
import { cn } from '@/lib/utils';

interface BreadcrumbSignature {
  Element: HTMLElement;
  Args: {
    separator?: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Breadcrumb: TOC<BreadcrumbSignature> = <template>
  <nav
    aria-label="breadcrumb"
    data-slot="breadcrumb"
    class={{@class}}
    ...attributes
  >
    {{yield}}
  </nav>
</template>;

interface BreadcrumbListSignature {
  Element: HTMLOListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const BreadcrumbList: TOC<BreadcrumbListSignature> = <template>
  <ol
    data-slot="breadcrumb-list"
    class={{cn
      "text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </ol>
</template>;

interface BreadcrumbItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const BreadcrumbItem: TOC<BreadcrumbItemSignature> = <template>
  <li
    data-slot="breadcrumb-item"
    class={{cn "inline-flex items-center gap-1.5" @class}}
    ...attributes
  >
    {{yield}}
  </li>
</template>;

interface BreadcrumbLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    href?: string;
    class?: string;
    asChild?: boolean;
  };
  Blocks: {
    default: [];
  };
}

const BreadcrumbLink: TOC<BreadcrumbLinkSignature> = <template>
  {{#if @asChild}}
    {{yield}}
  {{else}}
    <a
      data-slot="breadcrumb-link"
      href={{@href}}
      class={{cn "hover:text-foreground transition-colors" @class}}
      ...attributes
    >
      {{yield}}
    </a>
  {{/if}}
</template>;

interface BreadcrumbPageSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const BreadcrumbPage: TOC<BreadcrumbPageSignature> = <template>
  <span
    data-slot="breadcrumb-page"
    role="link"
    aria-disabled="true"
    aria-current="page"
    class={{cn "text-foreground font-normal" @class}}
    ...attributes
  >
    {{yield}}
  </span>
</template>;

interface BreadcrumbSeparatorSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const BreadcrumbSeparator: TOC<BreadcrumbSeparatorSignature> = <template>
  <li
    data-slot="breadcrumb-separator"
    role="presentation"
    aria-hidden="true"
    class={{cn "[&>svg]:size-3.5" @class}}
    ...attributes
  >
    {{#if (has-block)}}
      {{yield}}
    {{else}}
      <ChevronRight />
    {{/if}}
  </li>
</template>;

interface BreadcrumbEllipsisSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
}

const BreadcrumbEllipsis: TOC<BreadcrumbEllipsisSignature> = <template>
  <span
    data-slot="breadcrumb-ellipsis"
    role="presentation"
    aria-hidden="true"
    class={{cn "flex size-9 items-center justify-center" @class}}
    ...attributes
  >
    <MoreHorizontal class="size-4" />
    <span class="sr-only">More</span>
  </span>
</template>;

export {
  Breadcrumb,
  BreadcrumbList,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbPage,
  BreadcrumbSeparator,
  BreadcrumbEllipsis,
};
