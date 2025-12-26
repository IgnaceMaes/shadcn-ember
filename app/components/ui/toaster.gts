import type { TOC } from '@ember/component/template-only';
import { ToastProvider, ToastViewport } from './toast.gts';

interface ToasterSignature {
  Element: never;
  Args: Record<string, never>;
  Blocks: {
    default: [];
  };
}

export const Toaster: TOC<ToasterSignature> = <template>
  <ToastProvider>
    {{! TODO: Wire up with toasts service to display toasts dynamically }}
    <ToastViewport />
  </ToastProvider>
</template>;

export default Toaster;
