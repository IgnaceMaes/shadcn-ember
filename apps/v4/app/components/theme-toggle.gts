import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import onKey from 'ember-keyboard/helpers/on-key';

import { Button } from '@/components/ui/button';

import type ThemeService from '@/services/theme';

interface ThemeToggleSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
}

export default class ThemeToggle extends Component<ThemeToggleSignature> {
  @service declare theme: ThemeService;

  handleToggle = () => {
    const nextTheme = this.theme.resolvedTheme === 'light' ? 'dark' : 'light';
    this.theme.setTheme(nextTheme);
  };

  handleKeyToggle = (event: KeyboardEvent) => {
    const target = event.target as HTMLElement;
    const isInputField =
      target.tagName === 'INPUT' ||
      target.tagName === 'TEXTAREA' ||
      target.isContentEditable;

    if (!isInputField) {
      this.handleToggle();
    }
  };

  <template>
    {{onKey "d" this.handleKeyToggle}}

    <Button
      @size="icon"
      @variant="ghost"
      class="group/toggle extend-touch-target size-8 {{@class}}"
      {{on "click" this.handleToggle}}
      ...attributes
    >
      <svg
        class="size-4.5"
        fill="none"
        height="24"
        stroke="currentColor"
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        viewBox="0 0 24 24"
        width="24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path d="M0 0h24v24H0z" fill="none" stroke="none"></path>
        <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"></path>
        <path d="M12 3l0 18"></path>
        <path d="M12 9l4.65 -4.65"></path>
        <path d="M12 14.3l7.37 -7.37"></path>
        <path d="M12 19.6l8.85 -8.85"></path>
      </svg>
      <span class="sr-only">Toggle theme</span>
    </Button>
  </template>
}
