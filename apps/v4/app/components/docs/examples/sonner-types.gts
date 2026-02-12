import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';

import type FlashMessagesService from '@/services/flash-messages';

export default class SonnerTypes extends Component {
  @service declare flashMessages: FlashMessagesService;

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

  showPromise = () => {
    void this.flashMessages.promise<{ name: string }>(
      () =>
        new Promise((resolve) =>
          setTimeout(() => resolve({ name: 'Event' }), 2000)
        ),
      {
        loading: 'Loading...',
        success: (data) => `${data.name} has been created`,
        error: 'Error',
      }
    );
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
      <Button @variant="outline" {{on "click" this.showPromise}}>
        Promise
      </Button>
    </div>
  </template>
}
