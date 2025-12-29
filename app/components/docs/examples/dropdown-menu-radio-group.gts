import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

export default class DropdownMenuRadioGroupDemo extends Component {
  @tracked position = 'bottom';

  setPosition = (value: string) => {
    this.position = value;
  };

  <template>
    <DropdownMenu>
      <DropdownMenuTrigger @asChild={{true}}>
        <Button @variant="outline">Open</Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent @class="w-56">
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
      </DropdownMenuContent>
    </DropdownMenu>
  </template>
}
