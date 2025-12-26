import Component from '@glimmer/component';
import { service } from '@ember/service';
import { LinkTo } from '@ember/routing';
import type RouterService from '@ember/routing/router-service';

interface Signature {
  Element: HTMLAnchorElement;
  Args: {
    route: string;
  };
  Blocks: {
    default: [];
  };
}

export default class DocLinkTo extends Component<Signature> {
  @service declare router: RouterService;

  get routeExists(): boolean {
    try {
      // Try to recognize the route
      this.router.recognize(this.router.urlFor(this.args.route));
      return true;
    } catch {
      return false;
    }
  }

  get pathModel(): string | undefined {
    if (this.routeExists) {
      return undefined;
    }
    // Return the path for the catch-all route
    const path = this.args.route.replace(/^docs\./, '').replace(/\./g, '/');
    return path;
  }

  <template>
    {{#if this.routeExists}}
      <LinkTo @route={{@route}} ...attributes>
        {{yield}}
      </LinkTo>
    {{else}}
      <LinkTo @route="docs.catch-all" @model={{this.pathModel}} ...attributes>
        {{yield}}
      </LinkTo>
    {{/if}}
  </template>
}
