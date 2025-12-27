import EmberRouter from '@embroider/router';
import { next } from '@ember/runloop';
import config from 'shadcn-ember/config/environment';

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
  // Add route declarations here
  this.route('kitchensink');
  this.route('docs', function () {
    // Catch-all for markdown pages
    this.route('catch-all', { path: '/*path' });
  });
});
