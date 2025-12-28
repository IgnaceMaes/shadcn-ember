---
title: Dark Mode
description: Adding dark mode to your Ember app.
order: 21
---

## Create a theme service

Create a theme service to manage light, dark, and system theme preferences. The service handles persistence via localStorage and automatically responds to system theme changes.

```gts title="app/services/theme.ts"
import Service from '@ember/service';
import type Owner from '@ember/owner';
import { tracked } from '@glimmer/tracking';

type Theme = 'dark' | 'light' | 'system';

export default class ThemeService extends Service {
  @tracked theme: Theme = 'system';
  mediaQuery?: MediaQueryList;

  get resolvedTheme(): 'light' | 'dark' {
    if (this.theme === 'system') {
      return this.mediaQuery?.matches ? 'dark' : 'light';
    }
    return this.theme;
  }

  constructor(owner: Owner) {
    super(owner);

    const storedTheme = localStorage.getItem('theme') as Theme | null;
    if (storedTheme) {
      this.theme = storedTheme;
    }

    this.mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    this.mediaQuery.addEventListener('change', this.handleSystemThemeChange);
    this.applyTheme();
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

  setTheme = (theme: Theme) => {
    this.theme = theme;
    localStorage.setItem('theme', theme);
    this.applyTheme();
  };
}

declare module '@ember/service' {
  interface Registry {
    theme: ThemeService;
  }
}
```

## Add a mode toggle

Place a mode toggle on your site to allow users to switch between light, dark, and system theme.

```gts title="app/components/mode-toggle.gts"
import Component from '@glimmer/component';
import { service } from '@ember/service';
import type ThemeService from '@/services/theme';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import Sun from '~icons/lucide/sun';
import Moon from '~icons/lucide/moon';

export default class ModeToggle extends Component {
  @service declare theme: ThemeService;

  <template>
    <DropdownMenu>
      <DropdownMenuTrigger>
        <Button @variant="outline" @size="icon">
          <Sun
            class="h-[1.2rem] w-[1.2rem] scale-100 rotate-0 transition-all dark:scale-0 dark:-rotate-90"
          />
          <Moon
            class="absolute h-[1.2rem] w-[1.2rem] scale-0 rotate-90 transition-all dark:scale-100 dark:rotate-0"
          />
          <span class="sr-only">Toggle theme</span>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent @align="end">
        <DropdownMenuItem {{on "click" (fn this.theme.setTheme "light")}}>
          Light
        </DropdownMenuItem>
        <DropdownMenuItem {{on "click" (fn this.theme.setTheme "dark")}}>
          Dark
        </DropdownMenuItem>
        <DropdownMenuItem {{on "click" (fn this.theme.setTheme "system")}}>
          System
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  </template>
}
```
