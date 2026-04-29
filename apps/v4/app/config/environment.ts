const ENV = {
  modulePrefix: 'shadcn-ember-docs',
  environment: import.meta.env?.DEV ? 'development' : 'production',
  rootURL: '/',
  locationType: 'history',
  EmberENV: {
    EXTEND_PROTOTYPES: false,
    FEATURES: {},
  },
  APP: {} as Record<string, unknown>,
  'ember-shiki': {
    defaultLanguages: [
      'gjs',
      'gts',
      'typescript',
      'javascript',
      'tsx',
      'bash',
      'css',
      'json',
    ],
    defaultThemes: ['github-dark', 'github-light'],
  },
};

export default ENV;
