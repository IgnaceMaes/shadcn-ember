import { FlashMessagesService } from 'ember-cli-flash';

export default class CustomFlashMessagesService extends FlashMessagesService {
  get flashMessageDefaults() {
    return {
      ...super.flashMessageDefaults,
      type: 'default',
    };
  }
}
