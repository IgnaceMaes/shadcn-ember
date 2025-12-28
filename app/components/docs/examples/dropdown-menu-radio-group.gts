import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';

export default class DropdownMenuRadioGroupDemo extends Component {
  @tracked position = 'bottom';

  setPosition = (value: string) => {
    this.position = value;
  };

  <template>
    <DropdownMenu as |dm|>
      <dm.Trigger @asChild={{true}}>
        <Button @variant="outline">Open</Button>
      </dm.Trigger>
      <dm.Content @class="w-56">
        <DropdownMenuLabel>Panel Position</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuRadioGroup
          @value={{this.position}}
          @onValueChange={{this.setPosition}}
          as |value setValue|
        >
          <DropdownMenuRadioItem
            @value="top"
            @currentValue={{value}}
            @setValue={{setValue}}
          >
            Top
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem
            @value="bottom"
            @currentValue={{value}}
            @setValue={{setValue}}
          >
            Bottom
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem
            @value="right"
            @currentValue={{value}}
            @setValue={{setValue}}
          >
            Right
          </DropdownMenuRadioItem>
        </DropdownMenuRadioGroup>
      </dm.Content>
    </DropdownMenu>
  </template>
}
