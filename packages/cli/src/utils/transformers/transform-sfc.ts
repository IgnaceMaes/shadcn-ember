import type { TransformOpts } from '.'

// Ember uses .gts files, not Vue SFCs
// This transformer is a no-op for Ember projects
export async function transformSFC(opts: TransformOpts) {
  // Always return the raw content as-is for Ember
  // Type stripping will be handled by the TypeScript compiler
  return opts.raw
}

export async function transformByDetype(content: string, filename: string) {
  // No-op for Ember - TypeScript handling is done by the Ember build system
  return content
}
