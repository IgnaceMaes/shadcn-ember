interface BlockMeta {
  iframeHeight?: string
  className?: string
  description: string
  mobile?: "component"
  categories?: string[]
}

export const blockMeta = {
} as Record<string, BlockMeta>
