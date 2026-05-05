import { RuleTester } from 'eslint'
import { describe, it } from 'vitest'

import rule from '../../src/eslint/rules/require-class-arg'

function wrapGjs(code: string): string {
  return `<template>${code}</template>`
}

// eslint-disable-next-line @typescript-eslint/no-require-imports
const gjsParser = require('ember-eslint-parser')

describe('require-class-arg', () => {
  const ruleTester = new RuleTester({
    languageOptions: {
      parser: gjsParser,
      ecmaVersion: 2022,
      sourceType: 'module',
    },
  })

  const valid = [
    // @class is correct on shadcn-ember components
    '<Button @class="my-class" />',
    '<Card @class="my-class">content</Card>',
    // class on HTML elements is fine
    '<div class="my-class"></div>',
    '<button class="my-class">click</button>',
    '<span class="text-sm">text</span>',
    '<input class="input" />',
    // no class at all
    '<Button @variant="primary" />',
    '<div id="main"></div>',
    // class with dynamic value on HTML element
    '<div class={{this.classes}}></div>',
    // shadcn-ember component without class
    '<Badge @variant="secondary">badge</Badge>',
    // Non-shadcn component with class is allowed
    '<MyCustomComponent class="custom" />',
    '<SomeOtherLib class="other" />',
  ]

  const invalid = [
    {
      code: '<Button class="my-class" />',
      output: '<Button @class="my-class" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Card class="my-class">content</Card>',
      output: '<Card @class="my-class">content</Card>',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Badge class="extra-class" @variant="destructive">text</Badge>',
      output: '<Badge @class="extra-class" @variant="destructive">text</Badge>',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Input class="w-full" />',
      output: '<Input @class="w-full" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    // Dynamic class value
    {
      code: '<Button class={{this.classes}} />',
      output: '<Button @class={{this.classes}} />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    // Various shadcn-ember components
    {
      code: '<Dialog class="my-dialog" />',
      output: '<Dialog @class="my-dialog" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Table class="w-full" />',
      output: '<Table @class="w-full" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Separator class="my-2" />',
      output: '<Separator @class="my-2" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
    {
      code: '<Sidebar class="w-64" />',
      output: '<Sidebar @class="w-64" />',
      errors: [{ messageId: 'requireClassArg' as const }],
    },
  ]

  describe('gjs/gts', () => {
    it('passes valid and invalid cases', () => {
      ruleTester.run('require-class-arg', rule, {
        valid: valid.map((code) => ({ code: wrapGjs(code) })),
        invalid: invalid.map((entry) => ({
          ...entry,
          code: wrapGjs(entry.code),
          output: wrapGjs(entry.output),
        })),
      })
    })
  })
})
