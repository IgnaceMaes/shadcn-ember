export const FRAMEWORKS = {
  ember: {
    name: 'ember',
    label: 'Ember.js',
    links: {
      installation: 'https://shadcn-ember.com/docs/installation',
      tailwind: 'https://tailwindcss.com/docs/guides/emberjs',
    },
  },
  manual: {
    name: 'manual',
    label: 'Manual',
    links: {
      installation: 'https://shadcn-ember.com/docs/installation/manual',
      tailwind: 'https://tailwindcss.com/docs/installation',
    },
  },
} as const

export type Framework = (typeof FRAMEWORKS)[keyof typeof FRAMEWORKS]
