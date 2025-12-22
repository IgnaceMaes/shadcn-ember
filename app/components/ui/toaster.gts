/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { ToastProvider, ToastViewport } from './toast.gts';

interface ToasterSignature {
  Element: never;
  Args: Record<string, never>;
  Blocks: {
    default: [];
  };
}

export class Toaster extends Component<ToasterSignature> {
  // TODO: Wire up with toasts service when available
  // @service declare toasts: ToastsService;

  <template>
    <ToastProvider>
      {{! TODO: Wire up with toasts service to display toasts dynamically }}
      <ToastViewport />
    </ToastProvider>
  </template>
}

export default Toaster;
