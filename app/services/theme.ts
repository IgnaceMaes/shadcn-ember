import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class ThemeService extends Service {
  @tracked currentTheme: 'light' | 'dark' = 'light';

  get codeBlockTheme() {
    return this.currentTheme === 'dark' ? 'github-dark' : 'github-light';
  }

  constructor(properties?: object) {
    super(properties);
    this.initializeTheme();
  }

  private initializeTheme() {
    // Check localStorage first
    const storedTheme = localStorage.getItem('theme') as
      | 'light'
      | 'dark'
      | null;

    if (storedTheme) {
      this.currentTheme = storedTheme;
    } else {
      // Check system preference
      const prefersDark = window.matchMedia(
        '(prefers-color-scheme: dark)'
      ).matches;
      this.currentTheme = prefersDark ? 'dark' : 'light';
    }

    this.applyTheme();
  }

  private applyTheme() {
    const root = document.documentElement;
    if (this.currentTheme === 'dark') {
      root.classList.add('dark');
    } else {
      root.classList.remove('dark');
    }
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
}

// DO NOT DELETE: this is how TypeScript knows how to look up your services.
declare module '@ember/service' {
  interface Registry {
    theme: ThemeService;
  }
}
