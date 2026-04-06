import Application from './app.ts';
import config from './config/environment.ts';
import { shouldRehydrate } from 'vite-ember-ssr/client';

const app = Application.create({ ...config.APP, autoboot: false });

app.visit(window.location.pathname + window.location.search, {
  ...(shouldRehydrate() ? { _renderMode: 'rehydrate' } : {}),
});
