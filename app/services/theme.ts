import Service from '@ember/service';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class ThemeService extends Service {
  @tracked currentTheme: 'light' | 'dark' = 'light';
  @tracked currentColorTheme: string = 'neutral';

  get codeBlockTheme() {
    return this.currentTheme === 'dark' ? 'github-dark' : 'github-light';
  }

  constructor(owner: Owner) {
    super(owner);
    this.initializeTheme();
  }

  private initializeTheme() {
    // Check localStorage first
    const storedTheme = localStorage.getItem('theme') as
      | 'light'
      | 'dark'
      | null;
    const storedColorTheme = localStorage.getItem('colorTheme');

    if (storedTheme) {
      this.currentTheme = storedTheme;
    } else {
      // Check system preference
      const prefersDark = window.matchMedia(
        '(prefers-color-scheme: dark)'
      ).matches;
      this.currentTheme = prefersDark ? 'dark' : 'light';
    }

    if (storedColorTheme) {
      this.currentColorTheme = storedColorTheme;
    }

    this.applyTheme();
    this.applyColorTheme();
  }

  private applyTheme() {
    const root = document.documentElement;
    if (this.currentTheme === 'dark') {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
  }

  private applyColorTheme() {
    const normalizedTheme = this.currentColorTheme === 'default' ? 'neutral' : this.currentColorTheme;
    // Apply theme to all theme containers
    const containers = document.querySelectorAll('.theme-container');
    containers.forEach((container) => {
      container.setAttribute('data-theme', normalizedTheme);
    });
  }

  @action
  toggleTheme() {
    this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light';
    localStorage.setItem('theme', this.currentTheme);
    this.applyTheme();
  }

  @action
  setTheme(theme: 'light' | 'dark') {
    this.currentTheme = theme;
    localStorage.setItem('theme', theme);
    this.applyTheme();
  }

  @action
  setColorTheme(colorTheme: string) {
    this.currentColorTheme = colorTheme;
    localStorage.setItem('colorTheme', colorTheme);
    this.applyColorTheme();
  }
}

// DO NOT DELETE: this is how TypeScript knows how to look up your services.
declare module '@ember/service' {
  interface Registry {
    theme: ThemeService;
  }
}
