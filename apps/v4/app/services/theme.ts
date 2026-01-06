import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

import type Owner from '@ember/owner';

type Theme = 'dark' | 'light' | 'system';

export default class ThemeService extends Service {
  @tracked theme: Theme = 'system';
  @tracked currentColorTheme: string = 'neutral';

  mediaQuery?: MediaQueryList;

  get codeBlockTheme() {
    return this.resolvedTheme === 'dark' ? 'github-dark' : 'github-light';
  }

  get resolvedTheme(): 'light' | 'dark' {
    if (this.theme === 'system') {
      return this.mediaQuery?.matches ? 'dark' : 'light';
    }
    return this.theme;
  }

  constructor(owner: Owner) {
    super(owner);
    this.initializeTheme();
  }

  initializeTheme() {
    const storedTheme = localStorage.getItem('theme') as Theme | null;
    const storedColorTheme = localStorage.getItem('colorTheme');

    if (storedTheme) {
      this.theme = storedTheme;
    }

    if (storedColorTheme) {
      this.currentColorTheme = storedColorTheme;
    }

    this.mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    this.mediaQuery.addEventListener('change', this.handleSystemThemeChange);

    this.applyTheme();
    this.applyColorTheme();
  }

  handleSystemThemeChange = () => {
    if (this.theme === 'system') {
      this.applyTheme();
    }
  };

  applyTheme() {
    const root = document.documentElement;
    root.classList.remove('light', 'dark');
    root.classList.add(this.resolvedTheme);
  }

  applyColorTheme() {
    const normalizedTheme =
      this.currentColorTheme === 'default' ? 'neutral' : this.currentColorTheme;
    const containers = document.querySelectorAll('.theme-container');
    containers.forEach((container) => {
      container.setAttribute('data-theme', normalizedTheme);
    });
  }

  setTheme = (theme: Theme) => {
    this.theme = theme;
    localStorage.setItem('theme', theme);
    this.applyTheme();
  };

  setColorTheme = (colorTheme: string) => {
    this.currentColorTheme = colorTheme;
    localStorage.setItem('colorTheme', colorTheme);
    this.applyColorTheme();
  };
}

declare module '@ember/service' {
  interface Registry {
    theme: ThemeService;
  }
}
