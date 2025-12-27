import { PortalTargets } from 'ember-primitives';
import type { TOC } from '@ember/component/template-only';

interface PortalSignature {
  Blocks: {
    default: [];
  };
}

const Portal: TOC<PortalSignature> = <template><PortalTargets /></template>;

export { Portal };
