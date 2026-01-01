declare module 'ember-keyboard/helpers/on-key' {
  import Helper from '@ember/component/helper';

  interface OnKeySignature {
    Args: {
      Positional: [keyCombo: string, callback: (event: KeyboardEvent) => void];
      Named: {
        event?: string;
        activated?: boolean;
        priority?: number;
      };
    };
    Return: void;
  }

  export default class OnKeyHelper extends Helper<OnKeySignature> {}
}
