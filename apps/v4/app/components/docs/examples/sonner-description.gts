import { on } from '@ember/modifier';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Button } from '@/components/ui/button';

import type { FlashMessagesService } from 'ember-cli-flash';

export default class SonnerDescription extends Component {
  @service declare flashMessages: FlashMessagesService;

  showToast = () => {
    this.flashMessages.add({
      message: 'Event has been created',
      description: 'Monday, January 3rd at 6:00pm',
      type: 'info',
    });
  };

  <template>
    <Button @variant="outline" class="w-fit" {{on "click" this.showToast}}>
      Show Toast
    </Button>
  </template>
}
