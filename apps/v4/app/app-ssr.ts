import { run } from '@ember/runloop';
import { modifier } from 'ember-modifier';

import App, { appModules } from './app.ts';
import config from './config/environment.ts';

import type ApplicationInstance from '@ember/application/instance';

// Lets the SSG renderer wait for the run loop, timers and test waiters
// (e.g. ember-concurrency tasks) before capturing the DOM.
export { settled } from '@ember/test-helpers';

class SsrApp extends App {
  modules = {
    ...appModules,
    // Shiki can't load its WASM engine inside the ESM SSR bundle. Skip
    // highlighting on the server: CodeBlock then renders its plain-text
    // fallback, which is also what the client renders on first paint, so
    // rehydration matches and the client highlights afterwards.
    './modifiers/shiki-render': modifier(() => {}),
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
