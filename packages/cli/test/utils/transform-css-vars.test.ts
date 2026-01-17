import { expect, it } from 'vitest'

import { transform } from '../../src/utils/transformers'
import stone from '../fixtures/colors/stone.json'

it('transform css vars', async () => {
  expect(
    await transform({
      filename: 'app.gts',
      raw: `<template>
<div class="bg-background hover:bg-muted text-primary-foreground sm:focus:text-accent-foreground">foo</div>
</template>`,
      config: {
        typescript: true,
        tailwind: {
          baseColor: 'stone',
          cssVariables: true,
        },
        aliases: {
          components: '@/components',
          utils: '@/lib/utils',
        },
      },
      baseColor: stone,
    }),
  ).toMatchSnapshot()

  expect(
    await transform({
      filename: 'app.gts',
      raw: `<template>
<div class="bg-background hover:bg-muted text-primary-foreground sm:focus:text-accent-foreground">foo</div>
</template>`,
      config: {
        typescript: true,
        tailwind: {
          baseColor: 'stone',
          cssVariables: false,
        },
        aliases: {
          components: '@/components',
          utils: '@/lib/utils',
        },
      },
      baseColor: stone,
    }),
  ).toMatchSnapshot()

  expect(
    await transform({
      filename: 'app.gts',
      raw: `<template>
<div class={{cn "bg-background hover:bg-muted" "text-primary-foreground sm:focus:text-accent-foreground"}}>foo</div>
</template>`,
      config: {
        typescript: true,
        tailwind: {
          baseColor: 'stone',
          cssVariables: false,
        },
        aliases: {
          components: '@/components',
          utils: '@/lib/utils',
        },
      },
      baseColor: stone,
    }),
  ).toMatchSnapshot()

  expect(
    await transform({
      filename: 'app.gts',
      raw: `<template>
<div class={{cn "bg-background border border-input"}}>foo</div>
</template>`,
      config: {
        typescript: true,
        tailwind: {
          baseColor: 'stone',
          cssVariables: false,
        },
        aliases: {
          components: '@/components',
          utils: '@/lib/utils',
        },
      },
      baseColor: stone,
    }),
  ).toMatchSnapshot()
})
