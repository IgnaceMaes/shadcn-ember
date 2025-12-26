// Documentation navigation structure
// This defines the order of pages for prev/next navigation

export interface DocNavItem {
  route: string;
  title: string;
  href?: string;
}

// This should match the order in the sidebar
export const docsNavigation: DocNavItem[] = [
  // Sections - main pages
  { route: 'docs', title: 'Get Started' },
  { route: 'docs.components', title: 'Components' },
  { route: 'docs.changelog', title: 'Changelog' },
  // Get Started section
  { route: 'docs.installation', title: 'Installation' },
  { route: 'docs.cli', title: 'CLI' },
  { route: 'docs.figma', title: 'Figma' },
  // Components section
  { route: 'docs.components.accordion', title: 'Accordion' },
  { route: 'docs.components.alert', title: 'Alert' },
  { route: 'docs.components.aspect-ratio', title: 'Aspect Ratio' },
  { route: 'docs.components.checkbox', title: 'Checkbox' },
];

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
