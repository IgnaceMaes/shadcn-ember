import { bootRehydrated } from 'vite-ember-ssr/client';

import Application from './app.ts';
import config from './config/environment.ts';

bootRehydrated(Application, config);
