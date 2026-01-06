import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

import type Owner from '@ember/owner';

export type PackageManager = 'pnpm' | 'npm' | 'yarn' | 'bun';

export default class PackageManagerService extends Service {
  @tracked selectedManager: PackageManager = 'pnpm';

  constructor(owner: Owner) {
    super(owner);
    this.initializePackageManager();
  }

  initializePackageManager() {
    const stored = localStorage.getItem(
      'packageManager'
    ) as PackageManager | null;

    if (stored && ['pnpm', 'npm', 'yarn', 'bun'].includes(stored)) {
      this.selectedManager = stored;
    }
  }

  setPackageManager = (manager: PackageManager) => {
    this.selectedManager = manager;
    localStorage.setItem('packageManager', manager);
  };
}

declare module '@ember/service' {
  interface Registry {
    'package-manager': PackageManagerService;
  }
}
