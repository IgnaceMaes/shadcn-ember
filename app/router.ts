import EmberRouter from '@embroider/router';
import config from 'shadcn-ember/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  // Add route declarations here
  this.route('kitchensink');
  this.route('docs', function () {
    // this.route('installation', function () {
    //   this.route('manual');
    // });
    // this.route('components', function () {
    //   this.route('accordion');
    //   this.route('alert');
    //   this.route('aspect-ratio');
    //   this.route('checkbox');
    // });
    // this.route('changelog');
    // Catch-all for markdown pages
    this.route('catch-all', { path: '/*path' });
  });
});
