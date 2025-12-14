/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { service } from '@ember/service';
import {
  Toast,
  ToastClose,
  ToastDescription,
  ToastProvider,
  ToastTitle,
  ToastViewport,
} from './toast.gts';

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
      {{! Example usage with toasts service: }}
      {{! #each this.toasts.toasts as |toast| }}
      {{!   <Toast @variant={{toast.variant}}> }}
      {{!     <div class="grid gap-1"> }}
      {{!       #if toast.title }}
      {{!         <ToastTitle>{{toast.title}}</ToastTitle> }}
      {{!       /if }}
      {{!       #if toast.description }}
      {{!         <ToastDescription>{{toast.description}}</ToastDescription> }}
      {{!       /if }}
      {{!     </div> }}
      {{!     #if toast.action }}
      {{!       {{toast.action}} }}
      {{!     /if }}
      {{!     <ToastClose /> }}
      {{!   </Toast> }}
      {{! /each }}
      <ToastViewport />
    </ToastProvider>
  </template>
}

export default Toaster;
