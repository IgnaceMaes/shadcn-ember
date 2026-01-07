import path from 'node:path'
import { describe, expect, it } from 'vitest'

import { FRAMEWORKS } from '../../src/utils/frameworks'
import { getProjectInfo } from '../../src/utils/get-project-info'

describe('get project info', async () => {
  it.each([
    {
      name: 'vite',
      type: {
        framework: FRAMEWORKS.manual,
        isSrcDir: true,
        typescript: true,
        tailwindConfigFile: 'tailwind.config.js',
        tailwindCssFile: 'src/index.css',
        tailwindVersion: 'v4',
        aliasPrefix: null,
      },
    },
  ])(`getProjectType($name) -> $type`, async ({ name, type }) => {
    expect(
      await getProjectInfo(
        path.resolve(__dirname, `../fixtures/frameworks/${name}`),
      ),
    ).toStrictEqual(type)
  })
})
