import { FlashMessagesService } from 'ember-cli-flash';

import type { FlashObjectOptions } from 'ember-cli-flash';

export interface ToastCustomFields extends Record<string, unknown> {
  description?: string;
  action?: { label: string; onClick?: () => void };
}

type Options = FlashObjectOptions & ToastCustomFields;

interface PromiseOptions<T> {
  loading: string;
  success: string | ((data: T) => string);
  error: string | ((error: unknown) => string);
}

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

  promise<T>(promise: Promise<T> | (() => Promise<T>), options: PromiseOptions<T>): Promise<T> {
    const flash = this.add({
      message: options.loading,
      type: 'loading',
      sticky: true,
    }).getFlashObject();

    const p = typeof promise === 'function' ? promise() : promise;

    p.then(
      (data) => {
        flash.type = 'success';
        flash.message = typeof options.success === 'function' ? options.success(data) : options.success;
        flash.sticky = false;
        // `type` isn't tracked on FlashObject, so reassign queue to trigger re-render
        this.queue = [...this.queue];
      },
      (err) => {
        flash.type = 'error';
        flash.message = typeof options.error === 'function' ? options.error(err) : options.error;
        flash.sticky = false;
        this.queue = [...this.queue];
      },
    );

    return p;
  }
}

declare module '@ember/service' {
  interface Registry {
    flashMessages: CustomFlashMessagesService;
  }
}
