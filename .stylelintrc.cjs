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
        ],
      },
    ],
    'import-notation': null, // Allow string imports for Tailwind CSS
    'lightness-notation': null, // Allow decimal lightness in oklch colors
    'hue-degree-notation': null, // Allow degree-less hue values in oklch colors
    'rule-empty-line-before': [
      'always-multi-line',
      {
        except: ['first-nested'],
        ignore: ['after-comment'],
      },
    ],
  },
};
