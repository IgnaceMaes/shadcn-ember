// Ember uses unplugin-icons with iconify packages
// Icons are imported like: import Check from '~icons/lucide/check'
export const ICON_LIBRARIES = {
  lucide: {
    name: 'Lucide',
    package: '@iconify-json/lucide',
    import: '~icons/lucide',
  },
  radix: {
    name: 'Radix Icons',
    package: '@iconify-json/radix-icons',
    import: '~icons/radix-icons',
  },
  tabler: {
    name: 'Tabler Icons',
    package: '@iconify-json/tabler',
    import: '~icons/tabler',
  },
  phosphor: {
    name: 'Phosphor Icons',
    package: '@iconify-json/ph',
    import: '~icons/ph',
  },
}
