/* eslint-disable @typescript-eslint/no-explicit-any, @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-return, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-unused-vars, @typescript-eslint/require-await, import/order */
import type { RegistryItem } from '../../../packages/cli/src/registry/schema';

type RegistryFile = NonNullable<RegistryItem['files']>[number];
import { readdir, readFile } from 'node:fs/promises';

import { parseSync } from 'oxc-parser';
import { join, resolve } from 'pathe';

import { blockMeta } from '../registry/registry-block-meta';

// Simple kebab-case converter
function kebabCase(str: string): string {
  return str
    .replace(/([a-z])([A-Z])/g, '$1-$2')
    .replace(/[\s_]+/g, '-')
    .toLowerCase();
}

// [Dependency, [...PeerDependencies]]
const DEPENDENCIES = new Map<string, string[]>([
  ['ember-truth-helpers', []],
  ['ember-modifier', []],
  ['ember-provide-consume-context', []],
  ['ember-click-outside', []],
  ['ember-cli-flash', []],
  ['@floating-ui/dom', []],
  ['tracked-built-ins', []],
  ['class-variance-authority', []],
  ['clsx', []],
  ['tailwind-merge', []],
  ['@iconify-json/lucide', []],
]);

const REGISTRY_DEPENDENCY = '@/';

function sanitizeString(input: string): string {
  return input
    .replace(/[-_]\d+/g, '') // Remove hyphens/underscores followed by digits
    .replace(/\d+/g, '') // Remove any remaining digits
    .toLowerCase(); // Convert to lowercase
}

export async function crawlUI(rootPath: string) {
  const dir = (await readdir(rootPath, { withFileTypes: true })).sort();

  const uiRegistry: RegistryItem[] = [];
  const type = 'registry:ui' as const;

  for (const dirent of dir) {
    // Handle .gts files directly (Ember/Glimmer components)
    if (dirent.isFile() && dirent.name.endsWith('.gts')) {
      const [name = ''] = dirent.name.split('.gts');
      const filepath = join(rootPath, dirent.name);
      const source = await readFile(filepath, { encoding: 'utf8' });
      const relativePath = join('ui', dirent.name);

      const files: RegistryFile[] = [{ path: relativePath, type }];

      // Check for co-located .css file
      const cssFileName = `${name}.css`;
      if (dir.some((d) => d.isFile() && d.name === cssFileName)) {
        files.push({ path: join('ui', cssFileName), type });
      }

      const { dependencies, registryDependencies } = await getFileDependencies(
        filepath,
        source
      );

      uiRegistry.push({
        name,
        type,
        files,
        registryDependencies: registryDependencies.size
          ? Array.from(registryDependencies)
          : undefined,
        dependencies: dependencies.size ? Array.from(dependencies) : undefined,
      });
      continue;
    }

    // Handle directories (for components with multiple files)
    if (!dirent.isDirectory()) continue;

    const componentPath = resolve(rootPath, dirent.name);
    const ui = await buildUIRegistry(componentPath, dirent.name);
    uiRegistry.push(ui);
  }

  return uiRegistry;
}

export async function crawlExample(rootPath: string) {
  const type = 'registry:example' as const;

  const dir = (await readdir(rootPath, { withFileTypes: true })).sort();

  const registry: RegistryItem[] = [];

  for (const dirent of dir) {
    if (!dirent.name.endsWith('.gts') || !dirent.isFile()) continue;

    const [name = ''] = dirent.name.split('.gts');

    const filepath = join(rootPath, dirent.name);
    const source = await readFile(filepath, { encoding: 'utf8' });
    const relativePath = join('examples', dirent.name);

    const file = {
      name: dirent.name,
      content: source,
      path: relativePath,
      target: '',
      type,
    };
    const { dependencies, registryDependencies } = await getFileDependencies(
      filepath,
      source
    );

    registry.push({
      name,
      type,
      files: [file],
      registryDependencies: Array.from(registryDependencies),
      dependencies: Array.from(dependencies),
    });
  }

  return registry;
}

export async function crawlBlock(rootPath: string) {
  const type = 'registry:block' as const;

  const dir = (await readdir(rootPath, { withFileTypes: true })).sort();

  const registry: RegistryItem[] = [];

  for (const dirent of dir) {
    if (!dirent.isFile()) {
      const result = await buildBlockRegistry(
        `${rootPath}/${dirent.name}`,
        dirent.name
      );

      if (result.files.length) {
        registry.push(result);
      }
      continue;
    }
    if (!dirent.name.endsWith('.gts') || !dirent.isFile()) continue;

    const [name = ''] = dirent.name.split('.gts');

    const filepath = join(rootPath, dirent.name);
    const source = await readFile(filepath, { encoding: 'utf8' });
    const relativePath = join('charts', dirent.name);

    const file = {
      path: relativePath,
      type,
    };
    const { dependencies, registryDependencies } = await getFileDependencies(
      filepath,
      source
    );

    registry.push({
      name,
      type,
      files: [file],
      registryDependencies: Array.from(registryDependencies),
      dependencies: Array.from(dependencies),
      categories: kebabCase(name)
        .split('-')
        .slice(0, 2)
        .map((value, index) => (index === 1 ? `chart-${value}` : 'chart')),
    });
  }

  return registry;
}

export async function crawlChart(rootPath: string) {
  const type = 'registry:block' as const;

  const dir = (await readdir(rootPath, { withFileTypes: true })).sort();

  const registry: RegistryItem[] = [];

  for (const dirent of dir) {
    if (!dirent.isFile()) {
      const result = await buildBlockRegistry(
        `${rootPath}/${dirent.name}`,
        dirent.name
      );

      if (result.files.length) {
        registry.push(result);
      }
      continue;
    }
    if (!dirent.name.endsWith('.gts') || !dirent.isFile()) continue;

    const [name = ''] = dirent.name.split('.gts');

    const filepath = join(rootPath, dirent.name);
    const source = await readFile(filepath, { encoding: 'utf8' });
    const relativePath = join('charts', dirent.name);
    const target = '';
    const file = {
      name: dirent.name,
      path: relativePath,
      target,
      type,
    };
    const { dependencies, registryDependencies } = await getFileDependencies(
      filepath,
      source
    );

    registry.push({
      name,
      type,
      dependencies: dependencies.size ? Array.from(dependencies) : undefined,
      registryDependencies: registryDependencies.size
        ? Array.from(registryDependencies)
        : undefined,
      files: [file],
      categories: [], // TODO: get from file name
    });
  }

  return registry;
}

export async function crawlComposables(rootPath: string) {
  const type = 'registry:composable' as const;

  const dir = (await readdir(rootPath, { withFileTypes: true })).sort();

  const registry: RegistryItem[] = [];

  for (const dirent of dir) {
    if (!dirent.isFile()) continue;

    const [name = ''] = dirent.name.split('.ts');

    const filepath = join(rootPath, dirent.name);
    const source = await readFile(filepath, { encoding: 'utf8' });
    const relativePath = join('composables', dirent.name);

    const file = {
      content: source,
      path: relativePath,
      type,
    };
    const { dependencies, registryDependencies } = await getFileDependencies(
      filepath,
      source
    );

    registry.push({
      name,
      type,
      files: [file],
      registryDependencies: Array.from(registryDependencies),
      dependencies: Array.from(dependencies),
    });
  }

  return registry;
}

async function buildUIRegistry(componentPath: string, componentName: string) {
  const dir = (
    await readdir(componentPath, {
      withFileTypes: true,
    })
  ).sort();

  const files: RegistryFile[] = [];
  const dependencies = new Set<string>();
  const registryDependencies = new Set<string>();
  const type = 'registry:ui';

  for (const dirent of dir) {
    if (!dirent.isFile()) continue;

    const filepath = join(componentPath, dirent.name);
    const relativePath = join('ui', componentName, dirent.name);
    const source = await readFile(filepath, { encoding: 'utf8' });

    files.push({ path: relativePath, type });

    // only grab deps from the .gts component files, skip index.ts
    if (dirent.name === 'index.ts') continue;

    const deps = await getFileDependencies(filepath, source);
    if (!deps) continue;

    deps.dependencies.forEach((dep) => dependencies.add(dep));
    deps.registryDependencies.forEach((dep) => registryDependencies.add(dep));
  }

  return {
    name: componentName,
    type,
    dependencies: dependencies.size ? Array.from(dependencies) : undefined,
    registryDependencies: registryDependencies.size
      ? Array.from(registryDependencies)
      : undefined,
    files,
  } satisfies RegistryItem;
}

async function buildBlockRegistry(blockPath: string, blockName: string) {
  const dir = (
    await readdir(blockPath, { withFileTypes: true, recursive: true })
  ).sort();

  const files: RegistryFile[] = [];
  const dependencies = new Set<string>();
  const registryDependencies = new Set<string>();
  const meta = blockMeta[blockName];

  for (const dirent of dir) {
    if (!dirent.isFile()) continue;
    const isPage = dirent.name === 'page.gts';
    const type = isPage ? 'registry:page' : 'registry:component';

    const compPath = isPage ? dirent.name : `components/${dirent.name}`;
    const filepath = join(blockPath, compPath);
    const relativePath = join('blocks', blockName, compPath);
    const source = await readFile(filepath, { encoding: 'utf8' });
    const target = isPage
      ? `app/routes/${sanitizeString(blockName)}.gts`
      : undefined;

    // @ts-expect-error ignore target has optional type
    files.push({ path: relativePath, type, target });

    const deps = await getFileDependencies(filepath, source);
    if (!deps) continue;

    deps.dependencies.forEach((dep) => dependencies.add(dep));
    deps.registryDependencies.forEach((dep) => registryDependencies.add(dep));
  }

  return {
    name: blockName,
    type: 'registry:block',
    description: meta?.description || undefined,
    dependencies: dependencies.size ? Array.from(dependencies) : undefined,
    registryDependencies: registryDependencies.size
      ? Array.from(registryDependencies)
      : undefined,
    files,
    categories: meta?.categories ?? undefined,
  } satisfies RegistryItem;
}

async function getFileDependencies(filename: string, sourceCode: string) {
  const registryDependencies = new Set<string>();
  const dependencies = new Set<string>();

  const populateDeps = (source: string) => {
    // Extract base package name from sub-path imports (e.g., 'ember-click-outside/modifiers/on-click-outside' -> 'ember-click-outside')
    const packageName = source.startsWith('@')
      ? source.split('/').slice(0, 2).join('/') // Scoped packages: @scope/package
      : source.split('/')[0]!; // Regular packages: package - always exists for non-empty strings

    const peerDeps = DEPENDENCIES.get(packageName);
    if (peerDeps !== undefined) {
      dependencies.add(packageName);
      peerDeps.forEach((dep) => dependencies.add(dep));
    }

    if (
      source.startsWith(REGISTRY_DEPENDENCY) &&
      !source.endsWith('.gts') &&
      !source.endsWith('.ts')
    ) {
      const component = source.split('/').at(-1);
      if (component && component !== 'utils')
        registryDependencies.add(component);
    }
  };

  // For .gts files, extract imports using regex since oxc-parser can't handle template syntax
  if (filename.endsWith('.gts')) {
    // Match import statements: import { ... } from 'path' or import ... from 'path'
    const importRegex = /import\s+(?:[\w\s{},*]*)\s+from\s+['"]([^'"]+)['"]/g;
    let match;
    while ((match = importRegex.exec(sourceCode)) !== null) {
      const importPath = match[1];
      if (importPath) populateDeps(importPath);
    }
  } else {
    // Parse imports using oxc-parser for .ts files
    const ast = parseSync(filename, sourceCode, {
      sourceType: 'module',
    });

    const sources = ast.program.body
      .filter((i: any) => i.type === 'ImportDeclaration')
      .map((i: any) => i.source);
    sources.forEach((source: any) => {
      populateDeps(source.value);
    });
  }

  return { registryDependencies, dependencies };
}

export async function getBlockMetadata(filename: string, sourceCode: string) {
  const metadata = {
    description: null as string | null,
    iframeHeight: null as string | null,
    containerClass: null as string | null,
  };

  // For .gts files, we'll look for exported constants or JSDoc comments
  // This is a simplified version - Ember/Glimmer components use different patterns
  if (filename.endsWith('.gts') || filename.endsWith('.ts')) {
    try {
      const ast = parseSync(filename, sourceCode, {
        sourceType: 'module',
      });

      // Look for exported constants like description, iframeHeight, etc.
      ast.program.body.forEach((node: any) => {
        if (
          node.type === 'ExportNamedDeclaration' &&
          node.declaration?.type === 'VariableDeclaration'
        ) {
          node.declaration.declarations.forEach((decl: any) => {
            const name = decl.id.name;
            if (name in metadata && decl.init?.value) {
              // @ts-expect-error ignore missing type
              metadata[name] = decl.init.value;
            }
          });
        }
      });
    } catch (e) {
      // If parsing fails, return empty metadata
    }
  }

  return metadata;
}
