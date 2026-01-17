/* eslint-disable @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access */
// @ts-expect-error - zod is available through CLI package at build time
import { z } from 'zod';

import { blocks } from './registry-blocks';
import { charts } from './registry-charts';
import { composables } from './registry-composables';
import { examples } from './registry-examples';
import { internal } from './registry-internal';
import { lib } from './registry-lib';
import { themes } from './registry-themes';
import { ui } from './registry-ui';
import { registryItemSchema } from '../../../packages/cli/src/registry/schema';

import type { Registry } from '../../../packages/cli/src/registry/schema';

const DEPRECATED_ITEMS = [
  'toast',
  'toast-demo',
  'toast-destructive',
  'toast-simple',
  'toast-with-action',
  'toast-with-title',
];

// Shared between index and style for backward compatibility.
const NEW_YORK_V4_STYLE = {
  type: 'registry:style',
  dependencies: ['class-variance-authority', '@iconify-json/lucide'],
  devDependencies: ['tw-animate-css'],
  registryDependencies: ['utils'],
  cssVars: {},
  files: [],
};

export const registry = {
  name: 'shadcn-ember',
  homepage: 'https://shadcn-ember.com',
  items: z.array(registryItemSchema).parse(
    [
      {
        name: 'index',
        ...NEW_YORK_V4_STYLE,
      },
      {
        name: 'style',
        ...NEW_YORK_V4_STYLE,
      },
      ...ui,
      ...blocks,
      ...charts,
      ...lib,
      ...composables,
      ...themes,
      ...examples,
      ...internal,
    ]
      .filter((item) => {
        return !DEPRECATED_ITEMS.includes(item.name);
      })
      .map((item) => {
        // Temporary fix for dashboard-01.
        if (item.name === 'dashboard-01') {
          item.dependencies?.push('@iconify-json/lucide');
        }

        if (item.name === 'accordion' && 'tailwind' in item) {
          // we are not deleting tailwind meta
          // delete item.tailwind
        }

        return item;
      })
  ),
} satisfies Registry;
