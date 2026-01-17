import type { TransformOpts } from '.'

/**
 * Transform import paths based on user config aliases
 * Works with Ember .gts/.gjs files
 */
export function transformImportPaths(code: string, opts: TransformOpts): string {
  const { config, isRemote } = opts

  if (!config.aliases) {
    return code
  }

  const utilsAlias = config.aliases?.utils
  const workspaceAlias
    = typeof utilsAlias === 'string' && utilsAlias.includes('/')
      ? utilsAlias.split('/')[0]
      : '@'
  const utilsImport = `${workspaceAlias}/lib/utils`

  // Transform import statements using regex
  // This handles both static and dynamic imports
  const importRegex = /from\s+['"]([^'"]+)['"]/g

  code = code.replace(importRegex, (match, importPath) => {
    const updatedImport = updateImportAliases(importPath, config, isRemote)

    if (updatedImport !== importPath) {
      // Handle utils alias replacement for cn imports
      if ((utilsImport === updatedImport || updatedImport === '@/lib/utils') && config.aliases.utils) {
        return match.replace(importPath, config.aliases.utils)
      }
      return match.replace(importPath, updatedImport)
    }

    return match
  })

  return code
}

function updateImportAliases(
  moduleSpecifier: string,
  config: TransformOpts['config'],
  isRemote: boolean = false,
) {
  // Not a local import.
  if (!moduleSpecifier.startsWith('@/') && !isRemote) {
    return moduleSpecifier
  }

  // This treats the remote as coming from a faux registry.
  if (isRemote && moduleSpecifier.startsWith('@/')) {
    moduleSpecifier = moduleSpecifier.replace(/^@\//, `@/registry/new-york/`)
  }

  // Not a registry import.
  if (!moduleSpecifier.startsWith('@/registry/')) {
    // We fix the alias and return.
    const alias = config.aliases.components.split('/')[0]
    return moduleSpecifier.replace(/^@\//, `${alias}/`)
  }

  const aliases = config.aliases
  if (!aliases) {
    return moduleSpecifier
  }

  for (const [alias, aliasPath] of Object.entries(aliases)) {
    const prefixes = [
      `@/registry/new-york/ui`,
      `@/registry/new-york/components`,
      `@/registry/new-york/lib`,
      `@/registry/new-york/hooks`,
      `@/registry/new-york/composables`,
    ]

    for (const prefix of prefixes) {
      if (moduleSpecifier.startsWith(prefix)) {
        if (prefix.endsWith('/ui') && alias === 'ui') {
          return moduleSpecifier.replace(prefix, aliasPath)
        }
        else if (prefix.endsWith('/components') && alias === 'components') {
          return moduleSpecifier.replace(prefix, aliasPath)
        }
        else if (prefix.endsWith('/lib') && alias === 'lib') {
          return moduleSpecifier.replace(prefix, aliasPath)
        }
        else if (prefix.endsWith('/hooks') && alias === 'hooks') {
          return moduleSpecifier.replace(prefix, aliasPath)
        }
        else if (prefix.endsWith('/composables') && alias === 'composables') {
          return moduleSpecifier.replace(prefix, aliasPath)
        }
      }
    }
  }

  return moduleSpecifier
}
