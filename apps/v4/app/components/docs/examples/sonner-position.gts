import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { Button } from '@/components/ui/button';
import { Toaster } from '@/components/ui/sonner';

import type FlashMessagesService from '@/services/flash-messages';

type Position =
  | 'top-left'
  | 'top-center'
  | 'top-right'
  | 'bottom-left'
  | 'bottom-center'
  | 'bottom-right';

export default class SonnerPosition extends Component {
  @service declare flashMessages: FlashMessagesService;
  @tracked position: Position = 'top-center';

  showToast = (position: Position) => {
    this.position = position;
    this.flashMessages.add({
      message: 'Event has been created',
    });
  };

  showTopLeft = () => this.showToast('top-left');
  showTopCenter = () => this.showToast('top-center');
  showTopRight = () => this.showToast('top-right');
  showBottomLeft = () => this.showToast('bottom-left');
  showBottomCenter = () => this.showToast('bottom-center');
  showBottomRight = () => this.showToast('bottom-right');

  <template>
    <div class="flex flex-wrap justify-center gap-2">
      <Button @variant="outline" {{on "click" this.showTopLeft}}>
        Top Left
      </Button>
      <Button @variant="outline" {{on "click" this.showTopCenter}}>
        Top Center
      </Button>
      <Button @variant="outline" {{on "click" this.showTopRight}}>
        Top Right
      </Button>
      <Button @variant="outline" {{on "click" this.showBottomLeft}}>
        Bottom Left
      </Button>
      <Button @variant="outline" {{on "click" this.showBottomCenter}}>
        Bottom Center
      </Button>
      <Button @variant="outline" {{on "click" this.showBottomRight}}>
        Bottom Right
      </Button>
    </div>
    <Toaster @position={{this.position}} />
  </template>
}
