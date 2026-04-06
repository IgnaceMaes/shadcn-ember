import { shouldRehydrate } from 'vite-ember-ssr/client';

import Application from './app.ts';
import config from './config/environment.ts';

const app = Application.create({ ...config.APP, autoboot: false });

void app.visit(window.location.pathname + window.location.search, {
  ...(shouldRehydrate() ? { _renderMode: 'rehydrate' } : {}),
});
