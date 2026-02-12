import type { Registry } from '../../../packages/cli/src/registry/schema';

export const composables: Registry['items'] = [
  {
    name: 'flash-messages',
    type: 'registry:composable',
    files: [
      {
        path: 'services/flash-messages.ts',
        type: 'registry:composable',
        target: 'app/services/flash-messages.ts',
      },
    ],
    dependencies: ['ember-cli-flash'],
  },
];
