import Component from '@glimmer/component';
import { service } from '@ember/service';
import type ThemeService from '@/services/theme';
import { Button } from '@/components/ui/button';
import { on } from '@ember/modifier';
import onKey from 'ember-keyboard/helpers/on-key';

interface ThemeToggleSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
}

export default class ThemeToggle extends Component<ThemeToggleSignature> {
  @service declare theme: ThemeService;

  handleToggle = () => {
    this.theme.toggleTheme();
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
      @variant="ghost"
      @size="icon"
      class="group/toggle extend-touch-target size-8 {{@class}}"
      {{on "click" this.handleToggle}}
      ...attributes
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="size-4.5"
      >
        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
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
