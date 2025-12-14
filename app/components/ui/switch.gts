import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { cn } from '@/lib/utils';

interface SwitchSignature {
  Element: HTMLButtonElement;
  Args: {
    checked?: boolean;
    disabled?: boolean;
    onCheckedChange?: (checked: boolean) => void;
    class?: string;
  };
}

export default class Switch extends Component<SwitchSignature> {
  @tracked internalChecked = this.args.checked ?? false;

  get isChecked() {
    return this.args.checked ?? this.internalChecked;
  }

  get rootClasses() {
    return cn(
      'peer inline-flex h-5 w-9 shrink-0 cursor-pointer items-center rounded-full border-2 border-transparent shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:ring-offset-background disabled:cursor-not-allowed disabled:opacity-50',
      this.isChecked ? 'bg-primary' : 'bg-input',
      this.args.class
    );
  }

  get thumbClasses() {
    return cn(
      'pointer-events-none block h-4 w-4 rounded-full bg-background shadow-lg ring-0 transition-transform',
      this.isChecked ? 'translate-x-4' : 'translate-x-0'
    );
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
      role="switch"
      aria-checked={{if this.isChecked "true" "false"}}
      data-state={{if this.isChecked "checked" "unchecked"}}
      disabled={{@disabled}}
      class={{this.rootClasses}}
      {{on "click" this.handleClick}}
      ...attributes
    >
      <span
        data-state={{if this.isChecked "checked" "unchecked"}}
        class={{this.thumbClasses}}
      ></span>
    </button>
  </template>
}
