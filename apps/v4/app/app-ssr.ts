import { run } from '@ember/runloop';

import App, { appModules } from './app.ts';
import config from './config/environment.ts';
import { loadHighlighter } from './lib/highlighter.ts';
import ThemeService from './services/theme.ts';

import type ApplicationInstance from '@ember/application/instance';

// Lets the SSG renderer wait for the run loop, timers and test waiters
// (e.g. ember-concurrency tasks) before capturing the DOM.
export { settled } from '@ember/test-helpers';

class SsrThemeService extends ThemeService {
  override applyTheme() {}
}

class SsrApp extends App {
  modules = {
    ...appModules,
    // The server can't know the visitor's theme. Don't bake a light/dark
    // class into <html>; the inline script in index.html sets it before
    // first paint.
    './services/theme': SsrThemeService,
  };
}

export function createSsrApp() {
  const app = SsrApp.create({ ...config.APP, autoboot: false });

  // The renderer calls `instance.destroy()` after capturing the HTML, which
  // schedules teardown asynchronously. That teardown would then run after
  // HappyDOM is gone (or during the next route's render in the same worker),
  // where `@consume` getters return undefined because the owner is destroying.
  // Flush teardown synchronously instead, and ignore its errors: the HTML has
  // already been captured at this point.
  const visit = app.visit.bind(app);
  app.visit = async (...args: Parameters<typeof visit>) => {
    // Have the highlighter ready before rendering, so code blocks are
    // prerendered with syntax highlighting rather than as plain text.
    await loadHighlighter();
    const instance = (await visit(...args)) as ApplicationInstance;
    const destroy = instance.destroy.bind(instance);
    instance.destroy = () => {
      try {
        // eslint-disable-next-line ember/no-runloop -- must flush teardown synchronously
        run(destroy);
      } catch {
        // Teardown after capture; nothing to recover.
      }
      return instance;
    };
    return instance;
  };

  return app;
}
