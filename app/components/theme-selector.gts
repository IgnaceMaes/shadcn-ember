import Component from '@glimmer/component';
import { service } from '@ember/service';
import { THEMES } from '@/lib/themes';
import { cn } from '@/lib/utils';
import { Label } from '@/components/ui/label';
import { Select } from '@/components/ui/select';
import { CopyCodeButton } from '@/components/theme-customizer';
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
    return this.theme.currentColorTheme === 'default' ? 'neutral' : this.theme.currentColorTheme;
  }

  setActiveTheme = (value: string) => {
    this.theme.setColorTheme(value);
  };

  <template>
    <div class={{cn "flex items-center gap-2" @className}} ...attributes>
      <Label @for="theme-selector" @class="sr-only">
        Theme
      </Label>
      <Select
        @value={{this.value}}
        @onValueChange={{this.setActiveTheme}}
        as |s|
      >
        <s.Trigger
          id="theme-selector"
          @size="sm"
          @class="bg-secondary text-secondary-foreground border-secondary justify-start shadow-none *:data-[slot=select-value]:w-12"
        >
          <span class="font-medium">Theme:</span>
          <s.Value @placeholder="Select a theme" />
        </s.Trigger>
        <s.Content @align="end" as |c|>
          {{#each THEMES as |theme|}}
            <c.Item
              @value={{theme.name}}
              @class="data-[state=checked]:opacity-50"
            >
              {{theme.label}}
            </c.Item>
          {{/each}}
        </s.Content>
      </Select>
      <CopyCodeButton @variant="secondary" @size="icon-sm" />
    </div>
  </template>
}

export { ThemeSelector };
export default ThemeSelector;
