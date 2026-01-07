import { describe, expect, it } from 'vitest'

import { migrateIconsFile } from './migrate-icons'

describe('migrateIconsFile', () => {
  it('should replace radix icons with lucide icons', async () => {
    const input = `
      import { CheckIcon, CloseIcon } from "@radix-ui/react-icons"
      import { Something } from "other-package"

      export function Component() {
        return (
          <div>
            <CheckIcon className="w-4 h-4" />
            <CloseIcon />
          </div>
        )
      }`

    expect(
      await migrateIconsFile(input, 'radix', 'lucide', {
        Check: {
          lucide: 'Check',
          radix: 'CheckIcon',
        },
        X: {
          lucide: 'X',
          radix: 'CloseIcon',
        },
      }),
    ).toMatchInlineSnapshot(`
      "import { CheckIcon, CloseIcon } from "@radix-ui/react-icons"
            import { Something } from "other-package"

            export function Component() {
              return (
                <div>
                  <CheckIcon className="w-4 h-4" />
                  <CloseIcon />
                </div>
              )
            }"
    `)
  })

  it('should return null if no radix icons are found', async () => {
    const input = `
      import { Something } from "other-package"

      <template>
        <div>No icons here</div>
      </template>
      `

    expect(await migrateIconsFile(input, 'lucide', 'radix', {}))
      .toMatchInlineSnapshot(`
      "import { Something } from \"other-package\"

            <template>
              <div>No icons here</div>
            </template>
            "
    `)
  })

  it('should handle mixed icon imports from different packages', async () => {
    const input = `
      import CheckIcon from '~icons/radix-icons/check'
      import AlertCircle from '~icons/lucide/alert-circle'
      import { Something } from "other-package"
      import Cross2Icon from '~icons/radix-icons/cross-2'

      <template>
        <div>
          <CheckIcon class="w-4 h-4" />
          <AlertCircle />
          <Cross2Icon />
        </div>
      </template>
      `

    expect(
      await migrateIconsFile(input, 'radix', 'lucide', {
        Check: {
          lucide: 'Check',
          radix: 'CheckIcon',
        },
        X: {
          lucide: 'X',
          radix: 'Cross2Icon',
        },
      }),
    ).toMatchInlineSnapshot(`
      "import CheckIcon from '~icons/radix-icons/check'
            import AlertCircle from '~icons/lucide/alert-circle'
            import { Something } from "other-package"
            import Cross2Icon from '~icons/radix-icons/cross-2'

            <template>
              <div>
                <CheckIcon class="w-4 h-4" />
                <AlertCircle />
                <Cross2Icon />
              </div>
            </template>
            "
    `)
  })

  it('should preserve all props and children on icons', async () => {
    const input = `
      import CheckIcon from '~icons/radix-icons/check'
      import Cross2Icon from '~icons/radix-icons/cross-2'

      <template>
        <div>
          <CheckIcon
            class="w-4 h-4"
            {{on "click" this.handleClick}}
            data-testid="check-icon"
          >
            <span>Child content</span>
          </CheckIcon>
          <Cross2Icon style="color: red;" aria-label="Close" />
        </div>
      </template>
      `

    expect(
      await migrateIconsFile(input, 'radix', 'lucide', {
        Check: {
          lucide: 'Check',
          radix: 'CheckIcon',
        },
        X: {
          lucide: 'X',
          radix: 'Cross2Icon',
        },
      }),
    ).toMatchInlineSnapshot(`
      "import CheckIcon from '~icons/radix-icons/check'
            import Cross2Icon from '~icons/radix-icons/cross-2'

            <template>
              <div>
                <CheckIcon
                  class="w-4 h-4"
                  {{on "click" this.handleClick}}
                  data-testid="check-icon"
                >
                  <span>Child content</span>
                </CheckIcon>
                <Cross2Icon style="color: red;" aria-label="Close" />
              </div>
            </template>
            "
    `)
  })
})
