import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
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
      <dm.Content @class="w-56" as |c|>
        <DropdownMenuLabel>Appearance</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <c.CheckboxItem
          @checked={{this.showStatusBar}}
          @onCheckedChange={{this.setShowStatusBar}}
        >
          Status Bar
        </c.CheckboxItem>
        <c.CheckboxItem
          @checked={{this.showActivityBar}}
          @onCheckedChange={{this.setShowActivityBar}}
        >
          Activity Bar
        </c.CheckboxItem>
        <c.CheckboxItem
          @checked={{this.showPanel}}
          @onCheckedChange={{this.setShowPanel}}
        >
          Panel
        </c.CheckboxItem>
      </dm.Content>
    </DropdownMenu>
  </template>
}
