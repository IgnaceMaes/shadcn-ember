import { resolve } from 'pathe'
import { describe, expect, it } from 'vitest'
import { transform } from '../../src/utils/transformers'

describe('transformSFC', () => {
  it('basic', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `const array: (number | string)[] = [1, 2, 3]

<template>
  <div ...attributes>
    template
  </div>
</template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('type annotations preserved', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `const array: (number | string)[] = [1, 2, 3]

<template>
  <div ...attributes>
    {{123}}
  </div>
</template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('cn helper with classes', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `const array: (number | string)[] = [1, 2, 3]

<template>
  <div class={{cn
    "relative z-50 max-h-96 min-w-32 overflow-hidden rounded-md border bg-popover text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2"
    @class
  }}>
    {{123}}
  </div>
</template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('defineProps', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `import Component from '@glimmer/component';

      interface Signature {
        Args: { foo: string };
      }

      export default class extends Component<Signature> {}

      <template></template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('defineProps with withDefaults', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `import Component from '@glimmer/component';

      interface Signature {
        Args: { foo?: string };
      }

      export default class extends Component<Signature> {
        get foo() {
          return this.args.foo ?? 'bar';
        }
      }

      <template></template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('defineProps with external props', async () => {
    const result = await transform({
      filename: resolve(__dirname, './test.gts'),
      raw: `import Component from '@glimmer/component';
      import { type Props } from './__fixtures__/props'

      interface Signature {
        Args: { foo?: string } & Props;
      }

      export default class extends Component<Signature> {
        get foo() {
          return this.args.foo ?? 'bar';
        }
      }

      <template></template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })

  it('defineProps with package props', async () => {
    const result = await transform({
      filename: resolve(__dirname, './test.gts'),
      raw: `import Component from '@glimmer/component';
      import { type LabelProps } from 'reka-ui'

      interface Signature {
        Args: { foo?: string } & LabelProps;
      }

      export default class extends Component<Signature> {
        get foo() {
          return this.args.foo ?? 'bar';
        }
      }

      <template></template>
      `,
      config: {},
    })
    // TODO: We need to improve this. https://github.com/ignace/shadcn-ember/issues/187
    expect(result).toMatchSnapshot()
  })

  it('defineEmits', async () => {
    const result = await transform({
      filename: 'app.gts',
      raw: `import Component from '@glimmer/component';

      interface Signature {
        Args: {
          onFoo?: (value: string) => void;
        };
      }

      export default class extends Component<Signature> {}

      <template></template>
      `,
      config: {},
    })
    expect(result).toMatchSnapshot()
  })
})
