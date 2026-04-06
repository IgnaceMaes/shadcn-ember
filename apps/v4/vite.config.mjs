import { existsSync, readdirSync } from 'node:fs';
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

// Suppress expected errors during SSG cleanup.
// Ember's Backburner schedules destruction tasks via native setTimeout after
// HappyDOM globals are restored. These tasks reference browser globals or DOM
// nodes that are no longer available. The HTML has already been extracted at
// this point, so it's safe to ignore these cleanup errors.
// The RangeError is from ember-provide-consume-context's @consume decorator
// recursing when re-rendering across SSG pages (known SSR limitation).
process.on('uncaughtException', (err) => {
  const msg = err?.message ?? '';
  if (
    (err?.name === 'DOMException' && msg.includes('removeChild')) ||
    (err instanceof ReferenceError && msg.includes('window is not defined')) ||
    (err instanceof RangeError && msg.includes('Maximum call stack'))
  ) {
    return;
  }
  console.error(err);
  process.exit(1);
});

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
      rehydrate: true,
    }),
    {
      name: 'debug-build',
      config() {
        console.log('[debug] cwd:', process.cwd());
        console.log(
          '[debug] existsSync index.html:',
          existsSync('index.html'),
        );
        console.log(
          '[debug] existsSync abs:',
          existsSync(resolve(import.meta.dirname, 'index.html')),
        );
      },
      configResolved(config) {
        console.log('[debug] build.outDir:', config.build.outDir);
        console.log(
          '[debug] rollupOptions.input:',
          JSON.stringify(config.build.rollupOptions?.input),
        );
        console.log(
          '[debug] client.build.outDir:',
          config.environments?.client?.build?.outDir,
        );
      },
      writeBundle(options, bundle) {
        const htmlFiles = Object.keys(bundle).filter((k) =>
          k.endsWith('.html'),
        );
        console.log('[debug] writeBundle dir:', options.dir);
        console.log('[debug] HTML files in bundle:', htmlFiles);
      },
    },
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
