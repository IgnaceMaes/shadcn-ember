import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { guidFor } from '@ember/object/internals';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { eq, lt } from 'ember-truth-helpers';

import type { ToastCustomFields } from '@/services/flash-messages';
import type ThemeService from '@/services/theme';
import type { FlashMessagesService, FlashObject } from 'ember-cli-flash';

import CircleCheck from '~icons/lucide/circle-check';
import Info from '~icons/lucide/info';
import Loader2 from '~icons/lucide/loader-2';
import OctagonX from '~icons/lucide/octagon-x';
import TriangleAlert from '~icons/lucide/triangle-alert';

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

type Toast = FlashObject<ToastCustomFields> & ToastCustomFields;

interface ToasterSignature {
  Element: HTMLElement;
  Args: {
    position?: Position;
    class?: string;
    richColors?: boolean;
    expand?: boolean;
  };
}

function toastStyle(
  heightMap: Record<string, number>,
  toasts: Toast[],
  index: number
): ReturnType<typeof htmlSafe> {
  let heightBefore = 0;

  for (let i = 0; i < index; i++) {
    heightBefore += heightMap[guidFor(toasts[i])] ?? 0;
  }

  const currentId = guidFor(toasts[index]);

  return htmlSafe(
    `--index: ${index}; --toasts-before: ${index}; --z-index: ${toasts.length - index}; --offset: ${index * GAP + heightBefore}px; --initial-height: ${heightMap[currentId] ?? 0}px`
  );
}

/**
 * Reads `flash.type` while consuming the tracked `toasts` array,
 * so Glimmer re-evaluates when the queue is reassigned (e.g. after
 * a promise toast transitions from loading → success/error).
 */
function toastType(toasts: Toast[], flash: Toast): string | undefined {
  void toasts.length;
  return flash.type;
}

class Toaster extends Component<ToasterSignature> {
  @service declare flashMessages: FlashMessagesService<ToastCustomFields>;
  @service declare theme: ThemeService;

  @tracked expanded = false;
  @tracked heightMap: Record<string, number> = {};

  get position(): Position {
    return this.args.position ?? 'top-center';
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

  get toasts(): Toast[] {
    return [...this.flashMessages.arrangedQueue].reverse();
  }

  get frontToastHeight() {
    for (const toast of this.toasts) {
      const height = this.heightMap[guidFor(toast)];

      if (height !== undefined) return height;
    }

    return 0;
  }

  get toasterStyle() {
    return htmlSafe(
      `--front-toast-height: ${this.frontToastHeight}px; --width: ${TOAST_WIDTH}px; --gap: ${GAP}px; --normal-bg: var(--popover); --normal-text: var(--popover-foreground); --normal-border: var(--border); --border-radius: var(--radius); --offset-top: 24px; --offset-right: 24px; --offset-bottom: 24px; --offset-left: 24px; --mobile-offset-top: 16px; --mobile-offset-right: 16px; --mobile-offset-bottom: 16px; --mobile-offset-left: 16px`
    );
  }

  registerHeight = (id: string, height: number) => {
    if (this.heightMap[id] === height) return;
    this.heightMap = { ...this.heightMap, [id]: height };
  };

  unregisterHeight = (id: string) => {
    const next = { ...this.heightMap };
    delete next[id];
    this.heightMap = next;
  };

  setupToast = modifier((element: HTMLElement, [flash]: [Toast]) => {
    const id = guidFor(flash);
    let mountRaf: number | undefined;

    const raf = requestAnimationFrame(() => {
      this.registerHeight(id, element.getBoundingClientRect().height);

      mountRaf = requestAnimationFrame(() => {
        element.dataset['mounted'] = 'true';
      });
    });

    return () => {
      cancelAnimationFrame(raf);
      if (mountRaf !== undefined) cancelAnimationFrame(mountRaf);
      this.unregisterHeight(id);
    };
  });

  handleMouseEnter = () => {
    this.expanded = true;

    for (const flash of this.flashMessages.arrangedQueue) {
      flash.preventExit();
    }
  };

  handleMouseMove = () => {
    this.expanded = true;
  };

  handleMouseLeave = () => {
    this.expanded = false;

    for (const flash of this.flashMessages.arrangedQueue) {
      if (!flash.exiting) flash.allowExit();
    }
  };

  handleAction = (flash: Toast) => {
    flash.action?.onClick?.();
    flash.destroyMessage();
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
            {{#let (toastType this.toasts flash) as |type|}}
              <li
                class="cn-toast"
                data-dismissible="true"
                data-expanded={{if this.isExpanded "true" "false"}}
                data-front={{if (eq index 0) "true" "false"}}
                data-index={{index}}
                data-mounted="false"
                data-promise="false"
                data-removed={{if flash.exiting "true" "false"}}
                data-rich-colors={{if @richColors "true" "false"}}
                data-sonner-toast=""
                data-styled="true"
                data-swipe-out="false"
                data-swiped="false"
                data-swiping="false"
                data-type={{type}}
                data-visible={{if
                  (lt index VISIBLE_TOASTS_AMOUNT)
                  "true"
                  "false"
                }}
                data-x-position={{this.xPosition}}
                data-y-position={{this.yPosition}}
                style={{toastStyle this.heightMap this.toasts index}}
                tabindex="0"
                {{this.setupToast flash}}
              >
                {{#if (eq type "success")}}
                  <div data-icon="">
                    <CircleCheck class="size-4" />
                  </div>
                {{else if (eq type "info")}}
                  <div data-icon="">
                    <Info class="size-4" />
                  </div>
                {{else if (eq type "warning")}}
                  <div data-icon="">
                    <TriangleAlert class="size-4" />
                  </div>
                {{else if (eq type "error")}}
                  <div data-icon="">
                    <OctagonX class="size-4" />
                  </div>
                {{else if (eq type "loading")}}
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
                      {{flash.description}}
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
                    {{flash.action.label}}
                  </button>
                {{/if}}
              </li>
            {{/let}}
          {{/each}}
        </ol>
      {{/if}}
    </section>
  </template>
}

export { Toaster };
