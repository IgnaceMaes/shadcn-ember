import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
// import PhCheck from 'ember-phosphor-icons/components/ph-check';
import Check from '~icons/lucide/check';

interface CheckboxSignature {
  Element: HTMLButtonElement;
  Args: {
    checked?: boolean;
    disabled?: boolean;
    onCheckedChange?: (checked: boolean) => void;
    class?: string;
  };
}

export default class Checkbox extends Component<CheckboxSignature> {
  @tracked internalChecked = this.args.checked ?? false;

  get isChecked() {
    return this.args.checked ?? this.internalChecked;
  }

  get rootClasses() {
    return cn(
      'peer border-input dark:bg-input/30 data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground dark:data-[state=checked]:bg-primary data-[state=checked]:border-primary focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive size-4 shrink-0 rounded-[4px] border shadow-xs transition-shadow outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50',
      this.isChecked ? 'bg-primary text-primary-foreground' : '',
      this.args.class
    );
  }

  get indicatorClasses() {
    return cn('grid place-content-center text-current');
  }

  handleClick = (event: Event) => {
    event.preventDefault();
    if (this.args.disabled) return;

    const newChecked = !this.isChecked;

    // Update internal state if not controlled
    if (this.args.checked === undefined) {
      this.internalChecked = newChecked;
    }

    // Call the callback
    this.args.onCheckedChange?.(newChecked);
  };

  <template>
    <button
      type="button"
      role="checkbox"
      aria-checked={{if this.isChecked "true" "false"}}
      data-state={{if this.isChecked "checked" "unchecked"}}
      disabled={{@disabled}}
      class={{this.rootClasses}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      {{#if this.isChecked}}
        <span
          data-state="checked"
          class={{this.indicatorClasses}}
          aria-hidden="true"
        >
          {{! template-lint-disable require-presentational-children }}
          <Check class="size-3.5" />
        </span>
      {{/if}}
    </button>
  </template>
}
