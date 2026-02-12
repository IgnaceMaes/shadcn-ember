import type { Registry } from '../../../packages/cli/src/registry/schema';

export const composables: Registry['items'] = [
  {
    name: 'toast',
    type: 'registry:composable',
    files: [
      {
        path: 'services/toast.ts',
        type: 'registry:composable',
        target: 'app/services/toast.ts',
      },
    ],
    dependencies: ['ember-cli-flash'],
  },
];
