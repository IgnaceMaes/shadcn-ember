import Component from '@glimmer/component';

import { cn } from '@/lib/utils';

// Sonner/Toaster placeholder component
// Note: This is a simplified version. Full toast functionality would require
// a toast service and more complex state management.

interface ToasterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    position?:
      | 'top-left'
      | 'top-center'
      | 'top-right'
      | 'bottom-left'
      | 'bottom-center'
      | 'bottom-right';
  };
  Blocks: {
    default: [];
  };
}

class Toaster extends Component<ToasterSignature> {
  get positionClasses() {
    const position = this.args.position ?? 'bottom-right';
    const positions: Record<string, string> = {
      'top-left': 'top-0 left-0',
      'top-center': 'top-0 left-1/2 -translate-x-1/2',
      'top-right': 'top-0 right-0',
      'bottom-left': 'bottom-0 left-0',
      'bottom-center': 'bottom-0 left-1/2 -translate-x-1/2',
      'bottom-right': 'bottom-0 right-0',
    };
    return positions[position];
  }

  <template>
    <div
      class={{cn
        "fixed z-[100] flex flex-col gap-2 p-4 pointer-events-none"
        this.positionClasses
        @class
      }}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

export { Toaster };
