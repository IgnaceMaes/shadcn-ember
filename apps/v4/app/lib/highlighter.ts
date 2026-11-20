import { tracked } from '@glimmer/tracking';

import type { HighlighterCore, ShikiTransformer } from 'shiki/core';

class HighlighterState {
  @tracked highlighter?: HighlighterCore;
}

// Module-level so the highlighter is created once per process: once per page
// load in the browser, and once per worker during SSG (shared by every route).
const state = new HighlighterState();
let loading: Promise<HighlighterCore> | undefined;

export function loadHighlighter(): Promise<HighlighterCore> {
  loading ??= import('./shiki.ts')
    .then(({ createHighlighter }) => createHighlighter())
    .then((highlighter) => {
      state.highlighter = highlighter;
      return highlighter;
    });
  return loading;
}

function escapeHtml(value: string): string {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function plainHtml(code: string): string {
  const lines = code
    .split('\n')
    .map((line) => `<span class="line">${escapeHtml(line)}</span>`)
    .join('\n');
  return `<pre class="shiki" tabindex="0"><code>${lines}</code></pre>`;
}

function highlightLines(lines: number[]): ShikiTransformer {
  const set = new Set(lines);
  return {
    name: 'highlight-lines',
    line(node, line) {
      if (set.has(line)) this.addClassToHast(node, 'line--highlight-neutral');
    },
  };
}

/**
 * Returns highlighted HTML for `code`, or an unhighlighted fallback while the
 * highlighter is still loading. Reads tracked state, so callers re-render once
 * it's ready.
 *
 * Both themes are baked into the markup as CSS variables, so the output does
 * not depend on the visitor's light/dark preference. That's what lets the SSG
 * build emit it and the client adopt it during rehydration.
 */
export function highlight(
  code: string,
  language: string,
  lines?: number[]
): string {
  const { highlighter } = state;
  if (!highlighter) return plainHtml(code);

  const lang = highlighter.getLoadedLanguages().includes(language)
    ? language
    : 'text';

  return highlighter.codeToHtml(code, {
    lang,
    themes: { light: 'github-light', dark: 'github-dark' },
    transformers: lines?.length ? [highlightLines(lines)] : [],
  });
}
