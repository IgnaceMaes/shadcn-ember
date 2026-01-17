import type { Registry } from '../../../packages/cli/src/registry/schema';

export const internal: Registry['items'] = [
  // Do not move this. They are intentionally here for registry capture.
  //   {
  //     name: "sidebar-demo",
  //     type: "registry:internal",
  //     files: [
  //       {
  //         path: "internal/sidebar-demo.tsx",
  //         type: "registry:component",
  //       },
  //     ],
  //   },
];
