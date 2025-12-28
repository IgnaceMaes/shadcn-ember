import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

import InfoIcon from '~icons/lucide/info';
import StarIcon from '~icons/lucide/star';

import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from '@/components/ui/input-group';
import { Label } from '@/components/ui/label';
import { Popover } from '@/components/ui/popover';

export default class InputGroupButtonExample extends Component {
  @tracked isFavorite = false;

  toggleFavorite = () => {
    this.isFavorite = !this.isFavorite;
  };

  <template>
    <div class="grid w-full max-w-sm gap-6">
      <Label @for="input-secure-19" @class="sr-only">
        Input Secure
      </Label>
      <InputGroup @class="[--radius:9999px]">
        <InputGroupInput id="input-secure-19" @class="!pl-0.5" />
        <Popover as |p|>
          <p.Trigger>
            <InputGroupAddon>
              <InputGroupButton
                @variant="secondary"
                @size="icon-xs"
                aria-label="Info"
              >
                <InfoIcon />
              </InputGroupButton>
            </InputGroupAddon>
          </p.Trigger>
          <p.Content
            @align="start"
            @alignOffset={{10}}
            @class="flex flex-col gap-1 rounded-xl text-sm"
          >
            <div class="font-medium">Your connection is not secure.</div>
            <div>You should not enter any sensitive information on this site.</div>
          </p.Content>
        </Popover>
        <InputGroupAddon @class="text-muted-foreground !pl-1">
          https://
        </InputGroupAddon>
        <InputGroupAddon @align="inline-end">
          <InputGroupButton
            {{on "click" this.toggleFavorite}}
            @size="icon-xs"
            aria-label="Favorite"
          >
            <StarIcon
              data-favorite={{this.isFavorite}}
              class="data-[favorite=true]:fill-primary data-[favorite=true]:stroke-primary"
            />
          </InputGroupButton>
        </InputGroupAddon>
      </InputGroup>
    </div>
  </template>
}
