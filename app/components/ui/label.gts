import Component from '@glimmer/component';
import { cn } from '@/lib/utils';

interface LabelSignature {
  Element: HTMLLabelElement;
  Args: {
    class?: string;
    for?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class Label extends Component<LabelSignature> {
  get classes() {
    return cn(
      'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
      this.args.class
    );
  }

  <template>
    <label class={{this.classes}} for={{@for}} ...attributes>
      {{yield}}
    </label>
  </template>
}
