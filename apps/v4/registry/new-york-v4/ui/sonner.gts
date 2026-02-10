import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { guidFor } from '@ember/object/internals';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { eq } from 'ember-truth-helpers';

import type ThemeService from '@/services/theme';
import type { FlashMessagesService } from 'ember-cli-flash';

import CircleCheck from '~icons/lucide/circle-check';
import Info from '~icons/lucide/info';
import Loader2 from '~icons/lucide/loader-2';
import OctagonX from '~icons/lucide/octagon-x';
import TriangleAlert from '~icons/lucide/triangle-alert';

// Constants matching original sonner
const VISIBLE_TOASTS_AMOUNT = 3;
const TOAST_WIDTH = 356;
const GAP = 14;

type Position =
  | 'top-left'
  | 'top-center'
  | 'top-right'
  | 'bottom-left'
  | 'bottom-center'
  | 'bottom-right';

interface ToasterSignature {
  Element: HTMLElement;
  Args: {
    position?: Position;
    class?: string;
    richColors?: boolean;
    expand?: boolean;
  };
}

function asString(value: unknown): string {
  if (typeof value === 'string') return value;
  if (typeof value === 'number') return String(value);
  return '';
}

function isVisibleStr(index: number): string {
  return index + 1 <= VISIBLE_TOASTS_AMOUNT ? 'true' : 'false';
}

function isFrontStr(index: number): string {
  return index === 0 ? 'true' : 'false';
}

function dataStr(value: boolean | undefined): string {
  return value ? 'true' : 'false';
}

function getActionLabel(action: unknown): string {
  if (action && typeof action === 'object' && 'label' in action) {
    return String((action as { label: string }).label);
  }
  return '';
}

function computeToastStyle(
  heightMap: Record<string, number>,
  toasts: unknown[],
  index: number,
  totalCount: number,
): ReturnType<typeof htmlSafe> {
  let toastsHeightBefore = 0;
  for (let i = 0; i < index; i++) {
    const id = guidFor(toasts[i]);
    toastsHeightBefore += heightMap[id] ?? 0;
  }
  const offset = index * GAP + toastsHeightBefore;
  const currentId = guidFor(toasts[index]);
  const initialHeight = heightMap[currentId] ?? 0;

  return htmlSafe(
    `--index: ${index}; --toasts-before: ${index}; --z-index: ${totalCount - index}; --offset: ${offset}px; --initial-height: ${initialHeight}px`,
  );
}

class Toaster extends Component<ToasterSignature> {
  @service declare flashMessages: FlashMessagesService;
  @service declare theme: ThemeService;

  @tracked expanded = false;
  @tracked _heightMap: Record<string, number> = {};

  get position(): Position {
    return this.args.position ?? 'bottom-right';
  }

  get yPosition() {
    return this.position.split('-')[0]!;
  }

  get xPosition() {
    return this.position.split('-')[1]!;
  }

  get isExpanded() {
    return this.expanded || this.args.expand;
  }

  get toasts() {
    return [...this.flashMessages.arrangedQueue].reverse();
  }

  get frontToastHeight() {
    if (this.toasts.length === 0) return 0;

    // Look up the front toast's height first. If it hasn't been measured yet
    // (new toast just added), fall back to the first measured toast's height.
    // This matches React sonner where heights[0] retains the previous front
    // toast's height until the new one is prepended.
    for (const toast of this.toasts) {
      const id = guidFor(toast);
      const height = this._heightMap[id];

      if (height !== undefined) return height;
    }

    return 0;
  }

  get toasterStyle() {
    return htmlSafe(
      `--front-toast-height: ${this.frontToastHeight}px; --width: ${TOAST_WIDTH}px; --gap: ${GAP}px; --normal-bg: var(--popover); --normal-text: var(--popover-foreground); --normal-border: var(--border); --border-radius: var(--radius); --offset-top: 24px; --offset-right: 24px; --offset-bottom: 24px; --offset-left: 24px; --mobile-offset-top: 16px; --mobile-offset-right: 16px; --mobile-offset-bottom: 16px; --mobile-offset-left: 16px`,
    );
  }

  registerHeight = (id: string, height: number) => {
    if (this._heightMap[id] === height) return;
    this._heightMap = { ...this._heightMap, [id]: height };
  };

  unregisterHeight = (id: string) => {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { [id]: _, ...rest } = this._heightMap;
    this._heightMap = rest;
  };

  setupToast = modifier(
    (element: HTMLElement, [flash]: [/* flash */ unknown]) => {
      const id = guidFor(flash);
      let mountRaf: number | undefined;

      // First rAF: measure height and register it. This triggers a re-render
      // so all toasts get correct offsets/heights before the enter animation.
      const raf = requestAnimationFrame(() => {
        const height = element.getBoundingClientRect().height;
        this.registerHeight(id, height);

        // Second rAF: set mounted after the browser has painted the initial
        // state (invisible, correct offsets). This ensures the CSS transition
        // has a painted "from" frame to animate from — matching React sonner's
        // useEffect(() => setMounted(true), []) which fires after paint.
        mountRaf = requestAnimationFrame(() => {
          element.dataset['mounted'] = 'true';
        });
      });

      return () => {
        cancelAnimationFrame(raf);

        if (mountRaf !== undefined) cancelAnimationFrame(mountRaf);

        this.unregisterHeight(id);
      };
    },
  );

  handleMouseEnter = () => {
    this.expanded = true;
    for (const flash of this.flashMessages.arrangedQueue) {
      const f = flash as Record<string, unknown>;
      if (typeof f['preventExit'] === 'function') {
        (f['preventExit'] as () => void)();
      }
    }
  };

  handleMouseMove = () => {
    this.expanded = true;
  };

  handleMouseLeave = () => {
    this.expanded = false;
    for (const flash of this.flashMessages.arrangedQueue) {
      const f = flash as Record<string, unknown>;
      if (!f['exiting'] && typeof f['allowExit'] === 'function') {
        (f['allowExit'] as () => void)();
      }
    }
  };

  handleAction = (flash: Record<string, unknown>) => {
    const action = flash['action'] as
      | { onClick?: () => void; label?: string }
      | undefined;
    if (action && typeof action.onClick === 'function') {
      action.onClick();
    }
    if (typeof flash['destroyMessage'] === 'function') {
      (flash['destroyMessage'] as () => void)();
    }
  };

  handleClose = (flash: Record<string, unknown>) => {
    if (typeof flash['destroyMessage'] === 'function') {
      (flash['destroyMessage'] as () => void)();
    }
  };

  <template>
    <section
      aria-atomic="false"
      aria-label="Notifications alt+T"
      aria-live="polite"
      aria-relevant="additions text"
      tabindex="-1"
    >
      {{#if this.toasts.length}}
        <ol
          class="toaster group"
          data-sonner-theme={{this.theme.resolvedTheme}}
          data-sonner-toaster="true"
          data-x-position={{this.xPosition}}
          data-y-position={{this.yPosition}}
          dir="ltr"
          style={{this.toasterStyle}}
          tabindex="-1"
          {{on "mouseenter" this.handleMouseEnter}}
          {{on "mouseleave" this.handleMouseLeave}}
          {{on "mousemove" this.handleMouseMove}}
          ...attributes
        >
          {{#each this.toasts as |flash index|}}
            <li
              class="cn-toast"
              data-dismissible="true"
              data-expanded={{dataStr this.isExpanded}}
              data-front={{isFrontStr index}}
              data-index={{index}}
              data-mounted="false"
              data-promise="false"
              data-removed="false"
              data-rich-colors={{dataStr @richColors}}
              data-sonner-toast=""
              data-styled="true"
              data-swipe-out="false"
              data-swiped="false"
              data-swiping="false"
              data-type={{flash.type}}
              data-visible={{isVisibleStr index}}
              data-x-position={{this.xPosition}}
              data-y-position={{this.yPosition}}
              style={{computeToastStyle
                this._heightMap
                this.toasts
                index
                this.toasts.length
              }}
              tabindex="0"
              {{this.setupToast flash}}
            >
              {{#if (eq flash.type "success")}}
                <div data-icon="">
                  <CircleCheck class="size-4" />
                </div>
              {{else if (eq flash.type "info")}}
                <div data-icon="">
                  <Info class="size-4" />
                </div>
              {{else if (eq flash.type "warning")}}
                <div data-icon="">
                  <TriangleAlert class="size-4" />
                </div>
              {{else if (eq flash.type "error")}}
                <div data-icon="">
                  <OctagonX class="size-4" />
                </div>
              {{else if (eq flash.type "loading")}}
                <div data-icon="">
                  <Loader2 class="size-4 animate-spin" />
                </div>
              {{/if}}
              <div data-content="">
                {{#if flash.message}}
                  <div data-title="">
                    {{flash.message}}
                  </div>
                {{/if}}
                {{#if flash.description}}
                  <div data-description="">
                    {{asString flash.description}}
                  </div>
                {{/if}}
              </div>
              {{#if flash.action}}
                <button
                  data-action="true"
                  data-button="true"
                  type="button"
                  {{on "click" (fn this.handleAction flash)}}
                >
                  {{getActionLabel flash.action}}
                </button>
              {{/if}}
            </li>
          {{/each}}
        </ol>
      {{/if}}
    </section>
  </template>
}

export { Toaster };
