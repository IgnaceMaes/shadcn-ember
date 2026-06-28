import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Marker, MarkerContent, MarkerIcon } from '@/components/ui/marker';

import type ToastService from '@/services/toast';

import GitBranchIcon from '~icons/lucide/git-branch';
import RotateCcwIcon from '~icons/lucide/rotate-ccw';

export default class MarkerLinkButtonDemo extends Component {
  @service declare toast: ToastService;

  revert = () => {
    this.toast.add({ message: 'You clicked the revert button' });
  };

  <template>
    <div class="flex w-full max-w-sm flex-col gap-8 py-12">
      <Marker @asChild={{true}} as |marker|>
        <a
          class={{marker.classes}}
          data-slot="marker"
          data-variant="default"
          href="#links-and-buttons"
        >
          <MarkerIcon>
            <GitBranchIcon />
          </MarkerIcon>
          <MarkerContent>View the pull request</MarkerContent>
        </a>
      </Marker>
      <Marker @asChild={{true}} as |marker|>
        <button
          class="{{marker.classes}} transition-colors hover:text-foreground"
          data-slot="marker"
          data-variant="default"
          type="button"
          {{on "click" this.revert}}
        >
          <MarkerIcon>
            <RotateCcwIcon />
          </MarkerIcon>
          <MarkerContent>Revert this change</MarkerContent>
        </button>
      </Marker>
    </div>
  </template>
}
