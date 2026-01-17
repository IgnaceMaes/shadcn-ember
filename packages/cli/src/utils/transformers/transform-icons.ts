import type { TransformOpts } from '.'
import { ICON_LIBRARIES } from '@/src/utils/icon-libraries'

const SOURCE_LIBRARY = 'lucide'

const ICON_LIBRARY_IMPORTS = new Set(
  Object.values(ICON_LIBRARIES)
    .map(l => l.import)
    .filter(Boolean),
)

/**
 * Transform icon imports based on user's icon library choice
 * Works with Ember .gts/.gjs files
 */
export function transformIconLibrary(
  code: string,
  opts: TransformOpts,
  registryIcons: Record<string, Record<string, string>>,
): string {
  const { config } = opts

  if (!config.iconLibrary || !(config.iconLibrary in ICON_LIBRARIES)) {
    return code
  }

  const sourceLibrary = SOURCE_LIBRARY
  const targetLibrary = config.iconLibrary

  if (sourceLibrary === targetLibrary) {
    return code
  }

  // Transform icon imports
  const iconMap = registryIcons[sourceLibrary]?.[targetLibrary] || {}

  // Replace import statements for icon libraries
  const importRegex = /import\s+{([^}]+)}\s+from\s+['"]([^'"]+)['"]/g

  code = code.replace(importRegex, (match, imports, source) => {
    // Check if this is an icon library import
    const isIconLibrary = Array.from(ICON_LIBRARY_IMPORTS).some(prefix => source.startsWith(prefix))

    if (!isIconLibrary) {
      return match
    }

    // Map icon names
    const importList = imports.split(',').map((imp: string) => {
      const iconName = imp.trim()
      const mappedIcon = iconMap[iconName] || iconName
      return mappedIcon
    })

    // Update the import source to target library
    const targetImport = ICON_LIBRARIES[targetLibrary].import
    const newImports = importList.join(', ')

    return `import { ${newImports} } from '${targetImport}'`
  })

  return code
}
