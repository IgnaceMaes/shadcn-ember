import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

import type Owner from '@ember/owner';

export type InstallationMethod = 'cli' | 'manual';

export default class InstallationMethodService extends Service {
  @tracked selectedMethod: InstallationMethod = 'cli';

  constructor(owner: Owner) {
    super(owner);
    this.initializeMethod();
  }

  initializeMethod() {
    const stored = localStorage.getItem(
      'installationMethod'
    ) as InstallationMethod | null;

    if (stored && ['cli', 'manual'].includes(stored)) {
      this.selectedMethod = stored;
    }
  }

  setMethod = (method: InstallationMethod) => {
    this.selectedMethod = method;
    localStorage.setItem('installationMethod', method);
  };
}

declare module '@ember/service' {
  interface Registry {
    'installation-method': InstallationMethodService;
  }
}
