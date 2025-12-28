import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';

export default class DropdownMenuCheckboxesDemo extends Component {
  @tracked showStatusBar = true;
  @tracked showActivityBar = false;
  @tracked showPanel = false;

  setShowStatusBar = (checked: boolean) => {
    this.showStatusBar = checked;
  };

  setShowActivityBar = (checked: boolean) => {
    this.showActivityBar = checked;
  };

  setShowPanel = (checked: boolean) => {
    this.showPanel = checked;
  };

  <template>
    <DropdownMenu as |dm|>
      <dm.Trigger @asChild={{true}}>
        <Button @variant="outline">Open</Button>
      </dm.Trigger>
      <dm.Content @class="w-56">
        <DropdownMenuLabel>Appearance</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuCheckboxItem
          @checked={{this.showStatusBar}}
          @onCheckedChange={{this.setShowStatusBar}}
        >
          Status Bar
        </DropdownMenuCheckboxItem>
        <DropdownMenuCheckboxItem
          @checked={{this.showActivityBar}}
          @onCheckedChange={{this.setShowActivityBar}}
        >
          Activity Bar
        </DropdownMenuCheckboxItem>
        <DropdownMenuCheckboxItem
          @checked={{this.showPanel}}
          @onCheckedChange={{this.setShowPanel}}
        >
          Panel
        </DropdownMenuCheckboxItem>
      </dm.Content>
    </DropdownMenu>
  </template>
}
