import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';

import type { FlashMessagesService } from 'ember-cli-flash';

export default class SonnerDemo extends Component {
  @service declare flashMessages: FlashMessagesService;

  showToast = () => {
    this.flashMessages.add({
      message: 'Event has been created',
      description: 'Sunday, December 03, 2023 at 9:00 AM',
      action: {
        label: 'Undo',
        onClick: () => console.log('Undo'),
      },
    });
  };

  <template>
    <Button @variant="outline" {{on "click" this.showToast}}>
      Show Toast
    </Button>
  </template>
}
