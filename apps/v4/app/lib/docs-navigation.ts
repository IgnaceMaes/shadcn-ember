// Documentation navigation structure
// This defines the order of pages for prev/next navigation

import { parseFrontmatter } from './frontmatter';

export interface DocNavItem {
  route: string;
  title: string;
  href?: string;
}

export interface DocSidebarSection {
  title: string;
  items: DocNavItem[];
}

// Import all markdown files to extract metadata
const markdownFiles = import.meta.glob<string>('/app/content/docs/**/*.md', {
  query: '?raw',
  eager: true,
  import: 'default',
});

// Convert file path to route name
// e.g., "/app/content/docs/index.md" -> "docs.index"
// e.g., "/app/content/docs/installation.md" -> "docs.installation"
// e.g., "/app/content/docs/components/accordion.md" -> "docs.components.accordion"
function filePathToRoute(filePath: string): string {
  const relativePath = filePath
    .replace('/app/content/docs/', '')
    .replace('.md', '');

  return 'docs.' + relativePath.replace(/\//g, '.');
}

// Generate navigation from markdown files
function generateNavigation(): DocNavItem[] {
  const items: (DocNavItem & { order?: number })[] = [];

  for (const [filePath, content] of Object.entries(markdownFiles)) {
    const { frontmatter } = parseFrontmatter(content);
    const route = filePathToRoute(filePath);

    items.push({
      route,
      title: frontmatter.title ?? 'Untitled',
      order: frontmatter.order,
    });
  }

  // Sort by order if specified, otherwise by route name
  items.sort((a, b) => {
    // Hardcode introduction (index page) to be first
    if (a.route === 'docs.index') return -1;
    if (b.route === 'docs.index') return 1;

    if (a.order !== undefined && b.order !== undefined) {
      return a.order - b.order;
    }
    if (a.order !== undefined) return -1;
    if (b.order !== undefined) return 1;
    return a.route.localeCompare(b.route);
  });

  // Remove order property from final items
  return items.map(({ route, title }) => ({ route, title }));
}

export const docsNavigation: DocNavItem[] = generateNavigation();

// Generate sidebar structure grouped by section
function generateSidebar(): DocSidebarSection[] {
  const sectionsSection: DocSidebarSection = {
    title: 'Sections',
    items: [],
  };
  const getStartedSection: DocSidebarSection = {
    title: 'Get Started',
    items: [],
  };
  const componentsSection: DocSidebarSection = {
    title: 'Components',
    items: [],
  };

  for (const item of docsNavigation) {
    // Top-level pages go into "Sections"
    if (
      item.route === 'docs.index' ||
      item.route === 'docs.components' ||
      item.route === 'docs.mcp-server' ||
      item.route === 'docs.changelog'
    ) {
      sectionsSection.items.push(item);
    }
    // Get Started section - only show direct children (docs.X), not deep links (docs.installation.manual)
    else if (
      item.route.startsWith('docs.') &&
      !item.route.startsWith('docs.components.')
    ) {
      // Count dots to determine depth: docs.installation = 1 dot after "docs", docs.installation.manual = 2 dots
      const routeAfterDocs = item.route.substring(5); // Remove "docs."
      const depth = (routeAfterDocs.match(/\./g) || []).length;

      if (depth === 0) {
        getStartedSection.items.push(item);
      }
    }
    // Components section - only show docs.components.X, not docs.components.accordion.something
    else if (item.route.startsWith('docs.components.')) {
      const routeAfterComponents = item.route.substring(16); // Remove "docs.components."
      const depth = (routeAfterComponents.match(/\./g) || []).length;

      if (depth === 0) {
        componentsSection.items.push(item);
      }
    }
  }

  // Add llms.txt manually as it's not a markdown file
  getStartedSection.items.push({
    route: '',
    title: 'llms.txt',
    href: '/llms.txt',
  });

  return [sectionsSection, getStartedSection, componentsSection];
}

export const docsSidebar: DocSidebarSection[] = generateSidebar();

export interface AdjacentPages {
  prev?: DocNavItem;
  next?: DocNavItem;
}

export function getAdjacentPages(
  currentRoute: string,
  currentPath?: string
): AdjacentPages {
  let currentIndex = docsNavigation.findIndex(
    (item) => item.route === currentRoute
  );

  // If not found via route name, try to match via the catch-all path
  if (currentIndex === -1 && currentPath && currentRoute === 'docs.catch-all') {
    // Convert path to potential route name
    // e.g., "installation" -> "docs.installation"
    // e.g., "components/accordion" -> "docs.components.accordion"
    const routeFromPath = 'docs.' + currentPath.replace(/\//g, '.');
    currentIndex = docsNavigation.findIndex(
      (item) => item.route === routeFromPath
    );
  }

  if (currentIndex === -1) {
    return { prev: undefined, next: undefined };
  }

  return {
    prev: currentIndex > 0 ? docsNavigation[currentIndex - 1] : undefined,
    next:
      currentIndex < docsNavigation.length - 1
        ? docsNavigation[currentIndex + 1]
        : undefined,
  };
}
