import type * as z from 'zod'
import type { TransformOpts } from '.'
import type { registryBaseColorSchema } from '@/src/schema'

/**
 * Transform CSS variable usage based on baseColor configuration
 * Works with Ember .gts/.gjs files
 */
export function transformCssVariables(code: string, opts: TransformOpts): string {
  const { baseColor, config } = opts

  if (config.tailwind?.cssVariables || !baseColor?.inlineColors) {
    return code
  }

  // Transform CSS variable references to inline colors
  // This is a simplified version that handles common patterns
  const cssVarRegex = /hsl\(var\(--([^)]+)\)\)/g

  code = code.replace(cssVarRegex, (match, varName) => {
    // Map CSS variable names to inline colors
    const lightColor = baseColor.inlineColors.light[varName]
    const darkColor = baseColor.inlineColors.dark[varName]

    if (lightColor && darkColor) {
      // Return the light color by default (dark mode would need runtime handling)
      return lightColor
    }

    return match
  })

  return code
}

// Splits a className into variant-name-alpha.
// eg. hover:bg-primary-100 -> [hover, bg-primary, 100]
export function splitClassName(className: string): (string | null)[] {
  if (!className.includes('/') && !className.includes(':'))
    return [null, className, null]

  const parts: (string | null)[] = []
  // First we split to find the alpha.
  const [rest, alpha] = className.split('/')

  // Check if rest has a colon.
  if (!rest.includes(':'))
    return [null, rest, alpha]

  // Next we split the rest by the colon.
  const split = rest.split(':')

  // We take the last item from the split as the name.
  const name = split.pop()

  // We glue back the rest of the split.
  const variant = split.join(':')

  // Finally we push the variant, name and alpha.
  parts.push(variant ?? null, name ?? null, alpha ?? null)

  return parts
}

const PREFIXES = ['bg-', 'text-', 'border-', 'ring-offset-', 'ring-']

export function applyColorMapping(
  input: string,
  mapping: z.infer<typeof registryBaseColorSchema>['inlineColors'],
) {
  // Handle border classes.
  if (input.includes(' border '))
    input = input.replace(' border ', ' border border-border ')

  const classNames = input.split(' ')
  const lightMode = new Set<string>()
  const darkMode = new Set<string>()
  for (const className of classNames) {
    const [variant, value, modifier] = splitClassName(className)
    const prefix = PREFIXES.find(prefix => value?.startsWith(prefix))
    if (!prefix) {
      if (!lightMode.has(className))
        lightMode.add(className)

      continue
    }

    const needle = value?.replace(prefix, '')
    if (needle && needle in mapping.light) {
      lightMode.add(
        [variant, `${prefix}${mapping.light[needle]}`]
          .filter(Boolean)
          .join(':') + (modifier ? `/${modifier}` : ''),
      )

      darkMode.add(
        ['dark', variant, `${prefix}${mapping.dark[needle]}`]
          .filter(Boolean)
          .join(':') + (modifier ? `/${modifier}` : ''),
      )
      continue
    }

    if (!lightMode.has(className))
      lightMode.add(className)
  }

  return [...Array.from(lightMode), ...Array.from(darkMode)].join(' ').trim()
}
