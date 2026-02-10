import { FlashMessagesService } from 'ember-cli-flash';

export interface ToastCustomFields extends Record<string, unknown> {
  description?: string;
  action?: { label: string; onClick?: () => void };
}

export default class CustomFlashMessagesService extends FlashMessagesService<ToastCustomFields> {
  get flashMessageDefaults() {
    return {
      ...super.flashMessageDefaults,
      type: 'default',
      extendedTimeout: 400,
    };
  }
}

declare module '@ember/service' {
  interface Registry {
    flashMessages: CustomFlashMessagesService;
  }
}
