import { readdirSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import tailwindcss from '@tailwindcss/vite';
import Icons from 'unplugin-icons/vite';
import { emberSsg } from 'vite-ember-ssr/vite-plugin';

function getDocsRoutes(dir, prefix = 'docs') {
  const routes = [];
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      routes.push(
        ...getDocsRoutes(join(dir, entry.name), `${prefix}/${entry.name}`),
      );
    } else if (entry.name.endsWith('.md')) {
      const name = entry.name.replace('.md', '');
      if (name === 'index') {
        routes.push(prefix);
      } else {
        routes.push(`${prefix}/${name}`);
      }
    }
  }
  return routes;
}

const docsRoutes = getDocsRoutes(join(import.meta.dirname, 'app/content/docs'));

export default defineConfig({
  plugins: [
    ember(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
    tailwindcss(),
    Icons({ compiler: 'ember' }),
    emberSsg({
      routes: ['index', 'blocks', ...docsRoutes],
    }),
  ],
  build: {
    rollupOptions: {
      input: {
        main: resolve(import.meta.dirname, 'index.html'),
      },
    },
  },
  resolve: {
    alias: {
      '@': resolve(import.meta.dirname, './app'),
    },
  },
  assetsInclude: ['**/*.md'],
});
