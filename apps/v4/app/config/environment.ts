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
};

export default ENV;
