import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from '@/components/ui/input-group';
import { Tooltip } from '@/components/ui/tooltip';
import AudioLinesIcon from '~icons/lucide/audio-lines';
import PlusIcon from '~icons/lucide/plus';

export default class ButtonGroupInputGroup extends Component {
  @tracked voiceEnabled = false;

  toggleVoice = () => {
    this.voiceEnabled = !this.voiceEnabled;
  };

  <template>
    <ButtonGroup class="[--radius:9999rem]">
      <ButtonGroup>
        <Button @variant="outline" @size="icon">
          <PlusIcon />
        </Button>
      </ButtonGroup>
      <ButtonGroup>
        <InputGroup>
          <InputGroupInput
            placeholder={{if
              this.voiceEnabled
              "Record and send audio..."
              "Send a message..."
            }}
            disabled={{this.voiceEnabled}}
          />
          <InputGroupAddon @align="inline-end">
            <Tooltip as |t|>
              <t.Trigger>
                <InputGroupButton
                  {{on "click" this.toggleVoice}}
                  @size="icon-sm"
                  data-active={{this.voiceEnabled}}
                  class="data-[active=true]:bg-orange-100 data-[active=true]:text-orange-700 dark:data-[active=true]:bg-orange-800 dark:data-[active=true]:text-orange-100"
                  aria-pressed={{this.voiceEnabled}}
                >
                  <AudioLinesIcon />
                </InputGroupButton>
              </t.Trigger>
              <t.Content>Voice Mode</t.Content>
            </Tooltip>
          </InputGroupAddon>
        </InputGroup>
      </ButtonGroup>
    </ButtonGroup>
  </template>
}
