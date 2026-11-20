// The actual Shiki setup. Imported lazily through `./highlighter.ts` so the
// client only downloads grammars and themes once a code block needs them.
//
// Only the languages used in the docs are bundled; anything else renders as
// plain text. Uses the JavaScript regex engine instead of Oniguruma: no WASM to fetch,
// and it bundles cleanly into the ESM SSR build.
import { createHighlighterCore } from 'shiki/core';
import { createJavaScriptRegexEngine } from 'shiki/engine/javascript';
import bash from 'shiki/langs/bash.mjs';
import css from 'shiki/langs/css.mjs';
import glimmerTs from 'shiki/langs/glimmer-ts.mjs';
import handlebars from 'shiki/langs/handlebars.mjs';
import javascript from 'shiki/langs/javascript.mjs';
import json from 'shiki/langs/json.mjs';
import toml from 'shiki/langs/toml.mjs';
import typescript from 'shiki/langs/typescript.mjs';
import githubDark from 'shiki/themes/github-dark.mjs';
import githubLight from 'shiki/themes/github-light.mjs';

export function createHighlighter() {
  return createHighlighterCore({
    themes: [githubLight, githubDark],
    langs: [
      bash,
      css,
      glimmerTs,
      handlebars,
      javascript,
      json,
      toml,
      typescript,
    ],
    engine: createJavaScriptRegexEngine(),
  });
}
