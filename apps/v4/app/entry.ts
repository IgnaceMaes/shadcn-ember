import { bootRehydrated } from 'vite-ember-ssr/client';

import Application from './app.ts';
import config from './config/environment.ts';
// Imported after the app so its overrides come after addon CSS
// (e.g. ember-shiki's styles) in the bundle.
import './app.css';

bootRehydrated(Application, config);
