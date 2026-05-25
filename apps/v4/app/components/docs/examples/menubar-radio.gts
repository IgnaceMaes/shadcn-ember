import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import {
  Menubar,
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarSeparator,
  MenubarTrigger,
} from '@/components/ui/menubar';

export default class MenubarRadioDemo extends Component {
  @tracked user = 'benoit';
  @tracked theme = 'system';

  setUser = (value: string) => {
    this.user = value;
  };

  setTheme = (value: string) => {
    this.theme = value;
  };

  <template>
    <Menubar @class="w-72">
      <MenubarMenu>
        <MenubarTrigger>Profiles</MenubarTrigger>
        <MenubarContent>
          <MenubarRadioGroup
            @onValueChange={{this.setUser}}
            @value={{this.user}}
            as |value setValue|
          >
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="andy"
            >
              Andy
            </MenubarRadioItem>
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="benoit"
            >
              Benoit
            </MenubarRadioItem>
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="luis"
            >
              Luis
            </MenubarRadioItem>
          </MenubarRadioGroup>
          <MenubarSeparator />
          <MenubarItem @inset={{true}}>Edit...</MenubarItem>
          <MenubarItem @inset={{true}}>Add Profile...</MenubarItem>
        </MenubarContent>
      </MenubarMenu>
      <MenubarMenu>
        <MenubarTrigger>Theme</MenubarTrigger>
        <MenubarContent>
          <MenubarRadioGroup
            @onValueChange={{this.setTheme}}
            @value={{this.theme}}
            as |value setValue|
          >
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="light"
            >
              Light
            </MenubarRadioItem>
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="dark"
            >
              Dark
            </MenubarRadioItem>
            <MenubarRadioItem
              @currentValue={{value}}
              @setValue={{setValue}}
              @value="system"
            >
              System
            </MenubarRadioItem>
          </MenubarRadioGroup>
        </MenubarContent>
      </MenubarMenu>
    </Menubar>
  </template>
}
