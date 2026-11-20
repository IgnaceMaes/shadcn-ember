import type { ESLint, Linter } from 'eslint'

import requireClassArg from './rules/require-class-arg'

const rules = {
  'require-class-arg': requireClassArg,
}

const plugin: ESLint.Plugin = {
  rules,
}

/**
 * Flat config for enabling all shadcn-ember recommended rules.
 * Requires `ember-eslint-parser` to be installed.
 *
 * @example
 * ```js
 * // eslint.config.mjs
 * import shadcnEmber from 'shadcn-ember/eslint';
 *
 * export default [
 *   ...shadcnEmber.configs.recommended,
 *   // your other config...
 * ];
 * ```
 */
const configs: Record<string, Linter.Config[]> = {
  recommended: [
    {
      plugins: {
        'shadcn-ember': plugin,
      },
      rules: {
        'shadcn-ember/require-class-arg': 'error',
      },
    },
  ],
}

export default plugin
export { configs, rules }
