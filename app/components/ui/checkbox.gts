import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
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

class Checkbox extends Component<CheckboxSignature> {
  @tracked internalChecked = this.args.checked ?? false;

  get isControlled() {
    return this.args.onCheckedChange !== undefined;
  }

  get isChecked() {
    // Controlled mode: use args.checked when onCheckedChange is provided
    // Uncontrolled mode: use internal state
    return this.isControlled && this.args.checked !== undefined
      ? this.args.checked
      : this.internalChecked;
  }

  get rootClasses() {
    return cn(
      'peer border-input dark:bg-input/30 focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive size-4 shrink-0 rounded-[4px] border shadow-xs transition-shadow outline-none focus-visible:ring-[3px] disabled:cursor-not-allowed disabled:opacity-50',
      'data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground dark:data-[state=checked]:bg-primary data-[state=checked]:border-primary',
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
    if (!this.isControlled) {
      this.internalChecked = newChecked;
    }

    // Call the callback if provided
    this.args.onCheckedChange?.(newChecked);
  };

  <template>
    {{! template-lint-disable require-presentational-children }}
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
          <Check class="size-3.5" />
        </span>
      {{/if}}
    </button>
  </template>
}

export { Checkbox };
