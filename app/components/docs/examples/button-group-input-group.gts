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
        <Button @variant="outline" @size="icon" aria-label="Add">
          <PlusIcon />
        </Button>
      </ButtonGroup>
      <ButtonGroup class="flex-1">
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
                  data-active={{this.voiceEnabled}}
                  class="data-[active=true]:bg-primary data-[active=true]:text-primary-foreground"
                  aria-pressed={{this.voiceEnabled}}
                  @size="icon-xs"
                  aria-label="Voice Mode"
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
