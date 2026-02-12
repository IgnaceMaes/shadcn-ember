import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';

import type CustomFlashMessagesService from '@/services/flash-messages';

export default class SonnerTypes extends Component {
  @service declare flashMessages: CustomFlashMessagesService;

  showDefault = () => {
    this.flashMessages.add({
      message: 'Event has been created',
    });
  };

  showSuccess = () => {
    this.flashMessages.success('Event has been created');
  };

  showInfo = () => {
    this.flashMessages.info('Be at the area 10 minutes before the event time');
  };

  showWarning = () => {
    this.flashMessages.warning('Event start time cannot be earlier than 8am');
  };

  showError = () => {
    this.flashMessages.error('Event has not been created');
  };

  showLoading = () => {
    const flash = this.flashMessages.add({
      message: 'Creating event...',
      type: 'loading',
      sticky: true,
    }).getFlashObject();

    // Simulate async work
    setTimeout(() => {
      flash.destroyMessage();
      this.flashMessages.success('Event has been created');
    }, 2000);
  };

  <template>
    <div class="flex flex-wrap gap-2">
      <Button @variant="outline" {{on "click" this.showDefault}}>
        Default
      </Button>
      <Button @variant="outline" {{on "click" this.showSuccess}}>
        Success
      </Button>
      <Button @variant="outline" {{on "click" this.showInfo}}>
        Info
      </Button>
      <Button @variant="outline" {{on "click" this.showWarning}}>
        Warning
      </Button>
      <Button @variant="outline" {{on "click" this.showError}}>
        Error
      </Button>
      <Button @variant="outline" {{on "click" this.showLoading}}>
        Loading
      </Button>
    </div>
  </template>
}
