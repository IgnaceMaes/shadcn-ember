import { next } from '@ember/runloop';
import EmberRouter from '@embroider/router';

import config from 'shadcn-ember-docs/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;

  constructor(...args: ConstructorParameters<typeof EmberRouter>) {
    super(...args);
    this.on('routeDidChange', () => {
      // eslint-disable-next-line ember/no-runloop
      next(() => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    });
  }
}

Router.map(function () {
  this.route('blocks');
  this.route('docs', function () {
    // Catch-all for markdown pages
    this.route('catch-all', { path: '/*path' });
  });
});
