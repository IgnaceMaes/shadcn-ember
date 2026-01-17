import { service } from '@ember/service';
import Component from '@glimmer/component';

import { CopyCodeButton } from '@/components/theme-customizer';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { THEMES } from '@/lib/themes';
import { cn } from '@/lib/utils';

import type ThemeService from '@/services/theme';

interface ThemeSelectorSignature {
  Element: HTMLDivElement;
  Args: {
    className?: string;
  };
}

class ThemeSelector extends Component<ThemeSelectorSignature> {
  @service declare theme: ThemeService;

  get value() {
    return this.theme.currentColorTheme === 'default'
      ? 'neutral'
      : this.theme.currentColorTheme;
  }

  get valueLabel() {
    return THEMES.find((t) => t.name === this.value)?.label ?? '';
  }

  setActiveTheme = (value: string) => {
    this.theme.setColorTheme(value);
  };

  <template>
    <div class={{cn "flex items-center gap-2" @className}} ...attributes>
      <Label @class="sr-only" @for="theme-selector">
        Theme
      </Label>
      <Select
        @onValueChange={{this.setActiveTheme}}
        @value={{this.value}}
        @valueLabel={{this.valueLabel}}
      >
        <SelectTrigger
          @class="bg-secondary text-secondary-foreground border-secondary justify-start shadow-none *:data-[slot=select-value]:w-12"
          @size="sm"
          id="theme-selector"
        >
          <span class="font-medium">Theme:</span>
          <SelectValue @placeholder="Select a theme" />
        </SelectTrigger>
        <SelectContent @align="end">
          {{#each THEMES as |theme|}}
            <SelectItem
              @class="data-[state=checked]:opacity-50"
              @value={{theme.name}}
            >
              {{theme.label}}
            </SelectItem>
          {{/each}}
        </SelectContent>
      </Select>
      <CopyCodeButton @size="icon-sm" @variant="secondary" />
    </div>
  </template>
}

export default ThemeSelector;
