import type { z } from 'zod'
import type { registryBaseColorSchema } from '@/src/schema'
import type { Config } from '@/src/utils/get-config'
import { updateJavaScript } from '@codemod-utils/ast-template-tag'
import { getRegistryIcons } from '@/src/registry/api'
import { transformSFC } from '@/src/utils/transformers/transform-sfc'
import { transformImportPaths } from '@/src/utils/transformers/transform-import'
import { transformTailwindPrefix } from '@/src/utils/transformers/transform-tw-prefix'
import { transformIconLibrary } from '@/src/utils/transformers/transform-icons'
import { transformCssVariables } from '@/src/utils/transformers/transform-css-vars'

export interface TransformOpts {
  filename: string
  raw: string
  config: Config
  baseColor?: z.infer<typeof registryBaseColorSchema>
  isRemote?: boolean
}

export async function transform(opts: TransformOpts) {
  // For Ember .gts/.gjs files, handle TypeScript stripping first
  let source = await transformSFC(opts)

  // Get registry icons for icon transformation
  const registryIcons = await getRegistryIcons()

  // Apply transformations to the JavaScript/TypeScript part
  // using @codemod-utils/ast-template-tag for .gjs/.gts files
  source = updateJavaScript(source, (code) => {
    // Apply import path aliasing
    code = transformImportPaths(code, opts)

    // Apply Tailwind prefix transformations
    code = transformTailwindPrefix(code, opts)

    // Apply icon library transformations
    code = transformIconLibrary(code, opts, registryIcons)

    // Apply CSS variable transformations
    code = transformCssVariables(code, opts)

    return code
  })

  // TODO: Template transformations can be added using updateTemplates
  // if we need to transform the <template> tags separately

  return source
}
