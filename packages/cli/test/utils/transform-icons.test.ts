import { describe, expect, it } from 'vitest'
import { transform } from '../../src/utils/transformers'

describe('transformIcons', () => {
  it('transforms phosphor icons', async () => {
    const result = await transform({
      filename: 'Component.gts',
      raw: `import Check from '~icons/lucide/check'

      <template>
        <Check />
      </template>
      `,
      config: {
        iconLibrary: 'phosphor',
      },
    })
    expect(result).toMatchSnapshot()
  })

  it('transforms tabler icons', async () => {
    const result = await transform({
      filename: 'Component.gts',
      raw: `import Check from '~icons/lucide/check'

      <template>
        <Check />
      </template>
      `,
      config: {
        iconLibrary: 'tabler',
      },
    })
    expect(result).toMatchSnapshot()
  })

  it('transforms radix icons', async () => {
    const result = await transform({
      filename: 'Component.gts',
      raw: `import Check from '~icons/lucide/check'

      <template>
        <Check />
      </template>
      `,
      config: {
        iconLibrary: 'radix',
      },
    })
    expect(result).toMatchSnapshot()
  })

  it('does not transform lucide icons', async () => {
    const result = await transform({
      filename: 'Component.gts',
      raw: `import Check from '~icons/lucide/check'

      <template>
        <Check />
      </template>
      `,
      config: {
        iconLibrary: 'lucide',
      },
    })
    expect(result).toMatchSnapshot()
  })

  it('does nothing', async () => {
    const result = await transform({
      filename: 'Component.gts',
      raw: `import Check from '~icons/lucide/check'

      <template>
        <Check />
      </template>
      `,
      config: {
        style: 'new-york',
        tailwind: {
          config: 'tailwind.config.js',
          css: 'src/assets/index.css',
          baseColor: 'zinc',
          cssVariables: true,
        },
        aliases: {
          utils: '@/utils',
          components: '@/components',
        },
      },
    })
    expect(result).toMatchSnapshot()
  })
})
