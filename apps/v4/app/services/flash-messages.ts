import { FlashMessagesService } from 'ember-cli-flash';

import type { FlashObjectOptions } from 'ember-cli-flash';

export interface ToastCustomFields extends Record<string, unknown> {
  description?: string;
  action?: { label: string; onClick?: () => void };
}

type Options = FlashObjectOptions & ToastCustomFields;

export default class CustomFlashMessagesService extends FlashMessagesService<ToastCustomFields> {
  declare error: (message: string, options?: Options) => this;
  declare loading: (message: string, options?: Options) => this;

  get flashMessageDefaults() {
    return {
      ...super.flashMessageDefaults,
      type: 'default',
      extendedTimeout: 400,
      types: [...super.flashMessageDefaults.types, 'error', 'loading'],
    };
  }
}

declare module '@ember/service' {
  interface Registry {
    flashMessages: CustomFlashMessagesService;
  }
}
