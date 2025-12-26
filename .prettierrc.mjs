export default {
  plugins: ['prettier-plugin-ember-template-tag'],
  singleQuote: true,
  overrides: [
    {
      files: ['*.js', '*.ts', '*.cjs', '.mjs', '.cts', '.mts', '.cts'],
      options: {
        trailingComma: 'es5',
      },
    },
    {
      files: ['*.html'],
      options: {
        singleQuote: false,
      },
    },
    {
      files: ['*.json', '*.json5', '*.jsonc'],
      options: {
        singleQuote: false,
        trailingComma: 'none',
      },
    },
    {
      files: ['*.hbs'],
      options: {
        singleQuote: false,
      },
    },
    {
      files: ['*.gjs', '*.gts'],
      options: {
        templateSingleQuote: false,
        trailingComma: 'es5',
      },
    },
    {
      files: ['*.md'],
      options: {
        embeddedLanguageFormatting: 'off',
        singleQuote: false,
      },
    },
  ],
};
