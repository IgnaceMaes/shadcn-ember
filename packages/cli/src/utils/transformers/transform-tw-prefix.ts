import type { TransformOpts } from '.'
import type { TailwindVersion } from '../get-project-info'
import { splitClassName } from './transform-css-vars'

/**
 * Add prefix to Tailwind CSS classes
 * Works with Ember .gts/.gjs files
 */
export function transformTailwindPrefix(code: string, opts: TransformOpts): string {
  const { config } = opts

  if (!config.tailwind?.prefix) {
    return code
  }

  const prefix = config.tailwind.prefix

  // Transform class strings - handles both string literals and template literals
  // This is a simplified approach that targets common patterns
  const classRegex = /class(?:Name)?=["']([^"']+)["']/g

  code = code.replace(classRegex, (match, classes) => {
    const prefixedClasses = classes.split(/\s+/).map((cls: string) => {
      // Don't prefix if already prefixed or if it's a special class
      if (cls.startsWith(prefix) || !cls || cls.includes(':')) {
        return cls
      }
      return `${prefix}${cls}`
    }).join(' ')

    return match.replace(classes, prefixedClasses)
  })

  // Transform cn() calls with class strings
  const cnRegex = /cn\([^)]+\)/g

  code = code.replace(cnRegex, (match) => {
    return match.replace(/["']([^"']+)["']/g, (m, classes) => {
      const prefixedClasses = classes.split(/\s+/).map((cls: string) => {
        if (cls.startsWith(prefix) || !cls || cls.includes(':')) {
          return cls
        }
        return `${prefix}${cls}`
      }).join(' ')
      return m.replace(classes, prefixedClasses)
    })
  })

  return code
}

export function applyPrefix(input: string, prefix: string = '', tailwindVersion: TailwindVersion) {
  if (tailwindVersion === 'v3') {
    return input
      .split(' ')
      .map((className) => {
        const [variant, value, modifier] = splitClassName(className)
        if (variant) {
          return modifier
            ? `${variant}:${prefix}${value}/${modifier}`
            : `${variant}:${prefix}${value}`
        }
        else {
          return modifier
            ? `${prefix}${value}/${modifier}`
            : `${prefix}${value}`
        }
      })
      .join(' ')
  }

  return input
    .split(' ')
    .map(className =>
      className.indexOf(`${prefix}:`) === 0
        ? className
        : `${prefix}:${className.trim()}`,
    )
    .join(' ')
}

export function applyPrefixesCss(css: string, prefix: string, tailwindVersion: TailwindVersion) {
  const lines = css.split('\n')
  for (const line of lines) {
    if (line.includes('@apply')) {
      const originalTWCls = line.replace('@apply', '').trim()
      const prefixedTwCls = applyPrefix(originalTWCls, prefix, tailwindVersion)
      css = css.replace(originalTWCls, prefixedTwCls)
    }
  }
  return css
}
