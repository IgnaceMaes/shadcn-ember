import Component from '@glimmer/component';
import { service } from '@ember/service';
import type ThemeService from '@/services/theme';
import Toggle from '@/components/ui/toggle';
import Moon from '~icons/lucide/moon';
import Sun from '~icons/lucide/sun';

interface ThemeToggleSignature {
  Element: HTMLButtonElement;
  Args: {
    variant?: 'default' | 'outline';
    size?: 'default' | 'sm' | 'lg';
    class?: string;
  };
}

export default class ThemeToggle extends Component<ThemeToggleSignature> {
  @service declare theme: ThemeService;

  get isDark() {
    return this.theme.currentTheme === 'dark';
  }

  handleToggle = () => {
    this.theme.toggleTheme();
  };

  <template>
    <Toggle
      @variant={{if @variant @variant "outline"}}
      @size={{if @size @size "default"}}
      @pressed={{this.isDark}}
      @onPressedChange={{this.handleToggle}}
      aria-label="Toggle theme"
      class={{@class}}
      ...attributes
    >
      {{#if this.isDark}}
        <Moon />
      {{else}}
        <Sun />
      {{/if}}
    </Toggle>
  </template>
}
