import Component from '@glimmer/component';
import DocLinkTo from './doc-link-to';
import { cn } from '@/lib/utils';

interface DocLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    href: string;
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocLink extends Component<DocLinkSignature> {
  get isInternalRoute(): boolean {
    return this.args.href.startsWith('/');
  }

  get routeName(): string {
    // Convert path to route name
    // e.g., "/docs/installation/manual" -> "docs.installation.manual"
    const path = this.args.href.slice(1); // Remove leading /
    return path.replace(/\//g, '.');
  }

  <template>
    {{#if this.isInternalRoute}}
      <DocLinkTo
        @route={{this.routeName}}
        class={{cn "font-medium underline underline-offset-4" @class}}
        ...attributes
      >
        {{yield}}
      </DocLinkTo>
    {{else}}
      <a
        class={{cn "font-medium underline underline-offset-4" @class}}
        href={{@href}}
        rel="noopener noreferrer"
        target="_blank"
        ...attributes
      >
        {{yield}}
      </a>
    {{/if}}
  </template>
}
