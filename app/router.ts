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
    this.route('components', function () {
      this.route('alert');
      this.route('checkbox');
    });
  });
});
