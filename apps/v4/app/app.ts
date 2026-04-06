import KeyboardService from 'ember-keyboard/services/keyboard';
import PageTitleService from 'ember-page-title/services/page-title';
import GlimmerOverridesInitializer from 'ember-provide-consume-context/initializers/glimmer-overrides';
import ShikiService from 'ember-shiki/services/shiki';
import EmberApp from 'ember-strict-application-resolver';

import config from './config/environment.ts';
import Router from './router.ts';

export default class App extends EmberApp {
  modulePrefix = config.modulePrefix;
  modules = {
    './router': Router,
    './services/keyboard': KeyboardService,
    './services/page-title': PageTitleService,
    './services/shiki': ShikiService,
    ...import.meta.glob('./{routes,templates}/**/*.{ts,gts}', { eager: true }),
    ...import.meta.glob('./services/*.ts', { eager: true }),
    ...import.meta.glob('./controllers/*.ts', { eager: true }),
  };
}

App.initializer({
  name: 'glimmer-overrides',
  ...GlimmerOverridesInitializer,
});
