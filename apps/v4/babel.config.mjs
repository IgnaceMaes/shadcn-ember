import { dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { buildMacros } from '@embroider/macros/babel';

const __filename = fileURLToPath(import.meta.url);

const macros = buildMacros({
  configure: (config) => {
    config.setGlobalConfig(__filename, '@embroider/core', { active: true });
  },
});

export default {
  plugins: [
    [
      '@babel/plugin-transform-typescript',
      {
        allExtensions: true,
        onlyRemoveTypeImports: true,
        allowDeclareFields: true,
      },
    ],
    [
      'babel-plugin-ember-template-compilation',
      {
        compilerPath: 'ember-source/dist/ember-template-compiler.js',
        transforms: [...macros.templateMacros],
      },
    ],
    [
      'module:decorator-transforms',
      {
        runtime: {
          import: import.meta.resolve('decorator-transforms/runtime-esm'),
        },
      },
    ],
    [
      '@babel/plugin-transform-runtime',
      {
        absoluteRuntime: dirname(__filename),
        useESModules: true,
        regenerator: false,
      },
    ],
    ...macros.babelMacros,
  ],

  generatorOpts: {
    compact: false,
  },
};
