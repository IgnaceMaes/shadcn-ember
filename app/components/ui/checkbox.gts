import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';
import PhCheck from 'ember-phosphor-icons/components/ph-check';

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
      'grid place-content-center peer h-4 w-4 shrink-0 rounded-sm border border-primary shadow focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50',
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
        <span data-state="checked" class={{this.indicatorClasses}} aria-hidden="true">
          {{!-- template-lint-disable require-presentational-children --}}
          <PhCheck @size={{16}} />
        </span>
      {{/if}}
    </button>
  </template>
}
