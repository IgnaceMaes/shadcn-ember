import KeyboardService from 'ember-keyboard/services/keyboard';
import PageTitleService from 'ember-page-title/services/page-title';
import GlimmerOverridesInitializer from 'ember-provide-consume-context/initializers/glimmer-overrides';
import EmberApp from 'ember-strict-application-resolver';

import config from './config/environment.ts';
import Router from './router.ts';

export const appModules = {
  './router': Router,
  './config/environment': config,
  './services/keyboard': KeyboardService,
  './services/page-title': PageTitleService,
  ...import.meta.glob('./{routes,templates}/**/*.{ts,gts}', { eager: true }),
  ...import.meta.glob('./services/*.ts', { eager: true }),
  ...import.meta.glob('./controllers/*.ts', { eager: true }),
};

export default class App extends EmberApp {
  modulePrefix = config.modulePrefix;
  modules: Record<string, unknown> = appModules;
}

// The overrides patch Glimmer's prototypes globally and are not idempotent.
// During SSG many app instances boot in the same process, so only apply them
// once — stacking them breaks @consume lookups on every render after the first.
let glimmerOverridesApplied = false;

App.initializer({
  name: 'glimmer-overrides',
  initialize() {
    if (glimmerOverridesApplied) return;
    glimmerOverridesApplied = true;
    GlimmerOverridesInitializer.initialize();
  },
});
