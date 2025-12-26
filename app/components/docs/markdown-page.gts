import Component from '@glimmer/component';
import { service } from '@ember/service';
import RouterService from '@ember/routing/router-service';
import { MarkdownRenderer } from '@/components/docs';

interface Signature {
  Args: {};
}

// Use Vite's import.meta.glob to import all markdown files
const markdownFiles = import.meta.glob<{ default: string }>(
  '/app/content/docs/**/*.md',
  { query: '?raw', eager: true, import: 'default' }
);

export default class DocsMarkdownPage extends Component<Signature> {
  @service declare router: RouterService;

  get markdown(): string | null {
    const route = this.router.currentRouteName;

    let path: string;

    // If we're on the catch-all route, use the URL path instead of route name
    if (route === 'docs.catch-all') {
      // Get the URL path, e.g., "/docs/installation" -> "installation"
      const url = this.router.currentURL;
      path = url.replace(/^\/docs\/?/, '');
      if (!path) {
        path = 'index';
      }
    } else {
      // Convert route name to file path
      // e.g., "docs.index" -> "index"
      // e.g., "docs.installation.manual" -> "installation/manual"
      path = route.replace(/^docs\.?/, '');
      if (!path) {
        path = 'index';
      }

      // Handle Ember's .index route quirk - try without the /index first
      // e.g., "installation.index" should try "installation" first
      path = path.replace(/\.index$/, '');

      path = path.replace(/\./g, '/');
    }

    const fullPath = `/app/content/docs/${path}.md`;

    return markdownFiles[fullPath] || null;
  }

  <template>
    {{#if this.markdown}}
      <MarkdownRenderer @markdown={{this.markdown}} />
    {{else}}
      <div class="p-8">
        <h1 class="text-2xl font-bold">Page not found</h1>
        <p class="mt-2">No documentation found for this route.</p>
      </div>
    {{/if}}
  </template>
}
