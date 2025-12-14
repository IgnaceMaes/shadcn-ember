/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import PhCaretRight from 'ember-phosphor-icons/components/ph-caret-right';
import PhDotsThree from 'ember-phosphor-icons/components/ph-dots-three';
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

export class Breadcrumb extends Component<BreadcrumbSignature> {
  <template>
    <nav aria-label="breadcrumb" class={{@class}} ...attributes>
      {{yield}}
    </nav>
  </template>
}

interface BreadcrumbListSignature {
  Element: HTMLOListElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class BreadcrumbList extends Component<BreadcrumbListSignature> {
  <template>
    <ol
      class={{cn
        "flex flex-wrap items-center gap-1.5 break-words text-sm text-muted-foreground sm:gap-2.5"
        @class
      }}
      ...attributes
    >
      {{yield}}
    </ol>
  </template>
}

interface BreadcrumbItemSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class BreadcrumbItem extends Component<BreadcrumbItemSignature> {
  <template>
    <li class={{cn "inline-flex items-center gap-1.5" @class}} ...attributes>
      {{yield}}
    </li>
  </template>
}

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

export class BreadcrumbLink extends Component<BreadcrumbLinkSignature> {
  <template>
    {{#if @asChild}}
      {{yield}}
    {{else}}
      <a
        href={{@href}}
        class={{cn "transition-colors hover:text-foreground" @class}}
        ...attributes
      >
        {{yield}}
      </a>
    {{/if}}
  </template>
}

interface BreadcrumbPageSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class BreadcrumbPage extends Component<BreadcrumbPageSignature> {
  <template>
    <span
      role="link"
      aria-disabled="true"
      aria-current="page"
      class={{cn "font-normal text-foreground" @class}}
      ...attributes
    >
      {{yield}}
    </span>
  </template>
}

interface BreadcrumbSeparatorSignature {
  Element: HTMLLIElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class BreadcrumbSeparator extends Component<BreadcrumbSeparatorSignature> {
  <template>
    <li
      role="presentation"
      aria-hidden="true"
      class={{cn "[&>svg]:w-3.5 [&>svg]:h-3.5" @class}}
      ...attributes
    >
      {{#if (has-block)}}
        {{yield}}
      {{else}}
        <PhCaretRight @size={{14}} />
      {{/if}}
    </li>
  </template>
}

interface BreadcrumbEllipsisSignature {
  Element: HTMLSpanElement;
  Args: {
    class?: string;
  };
}

export class BreadcrumbEllipsis extends Component<BreadcrumbEllipsisSignature> {
  <template>
    <span
      role="presentation"
      aria-hidden="true"
      class={{cn "flex h-9 w-9 items-center justify-center" @class}}
      ...attributes
    >
      <PhDotsThree @size={{16}} />
      <span class="sr-only">More</span>
    </span>
  </template>
}

export { Breadcrumb as default };
