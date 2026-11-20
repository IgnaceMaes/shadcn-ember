'use strict';

module.exports = {
  extends: ['stylelint-config-standard'],
  rules: {
    // Disable rules that conflict with Tailwind CSS v4 syntax
    'at-rule-no-unknown': [
      true,
      {
        ignoreAtRules: [
          'tailwind',
          'apply',
          'layer',
          'theme',
          'custom-variant',
          'utility',
          'variant',
        ],
      },
    ],
    'import-notation': null, // Allow string imports for Tailwind CSS
    'lightness-notation': null, // Allow decimal lightness in oklch colors
    'hue-degree-notation': null, // Allow degree-less hue values in oklch colors
    'property-no-vendor-prefix': null, // Allow -webkit-background-clip for Safari
    'declaration-block-no-duplicate-custom-properties': null, // Allow Tailwind v4 progressive-enhancement fallbacks
    'rule-empty-line-before': [
      'always-multi-line',
      {
        except: ['first-nested'],
        ignore: ['after-comment'],
      },
    ],
  },
};
