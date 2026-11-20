import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';

import { highlight, loadHighlighter } from '@/lib/highlighter';

import type Owner from '@ember/owner';

interface CodeHighlightSignature {
  Args: {
    code: string;
    language: string;
    showLineNumbers?: boolean;
    highlightLines?: number[];
  };
  Element: HTMLDivElement;
}

/**
 * Syntax-highlighted code that survives SSG.
 *
 * The highlighted HTML is always rendered through the same trusted-HTML slot.
 * During rehydration Glimmer keeps the server's markup for such a slot rather
 * than replacing it, so the prerendered highlighting stays on screen while the
 * client loads Shiki, then gets swapped for identical markup.
 */
export default class CodeHighlight extends Component<CodeHighlightSignature> {
  constructor(owner: Owner, args: CodeHighlightSignature['Args']) {
    super(owner, args);
    loadHighlighter().catch((error: unknown) => {
      console.error('Failed to load the syntax highlighter', error);
    });
  }

  get html() {
    return htmlSafe(
      highlight(this.args.code, this.args.language, this.args.highlightLines)
    );
  }

  <template>
    <div class="shiki-code-block" ...attributes>
      <div
        class="shiki-code-block__code {{if @showLineNumbers 'line-numbers'}}"
      >{{this.html}}</div>
    </div>
  </template>
}
