import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import {
  Menubar,
  MenubarCheckboxItem,
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarSeparator,
  MenubarShortcut,
  MenubarTrigger,
} from '@/components/ui/menubar';

export default class MenubarCheckboxDemo extends Component {
  @tracked showBookmarksBar = false;
  @tracked showFullUrls = true;
  @tracked showStrikethrough = true;
  @tracked showCode = false;
  @tracked showSuperscript = false;

  setShowBookmarksBar = (checked: boolean) => {
    this.showBookmarksBar = checked;
  };

  setShowFullUrls = (checked: boolean) => {
    this.showFullUrls = checked;
  };

  setShowStrikethrough = (checked: boolean) => {
    this.showStrikethrough = checked;
  };

  setShowCode = (checked: boolean) => {
    this.showCode = checked;
  };

  setShowSuperscript = (checked: boolean) => {
    this.showSuperscript = checked;
  };

  <template>
    <Menubar @class="w-72">
      <MenubarMenu>
        <MenubarTrigger>View</MenubarTrigger>
        <MenubarContent @class="w-64">
          <MenubarCheckboxItem
            @checked={{this.showBookmarksBar}}
            @onCheckedChange={{this.setShowBookmarksBar}}
          >
            Always Show Bookmarks Bar
          </MenubarCheckboxItem>
          <MenubarCheckboxItem
            @checked={{this.showFullUrls}}
            @onCheckedChange={{this.setShowFullUrls}}
          >
            Always Show Full URLs
          </MenubarCheckboxItem>
          <MenubarSeparator />
          <MenubarItem @inset={{true}}>
            Reload
            <MenubarShortcut>⌘R</MenubarShortcut>
          </MenubarItem>
          <MenubarItem @disabled={{true}} @inset={{true}}>
            Force Reload
            <MenubarShortcut>⇧⌘R</MenubarShortcut>
          </MenubarItem>
        </MenubarContent>
      </MenubarMenu>
      <MenubarMenu>
        <MenubarTrigger>Format</MenubarTrigger>
        <MenubarContent>
          <MenubarCheckboxItem
            @checked={{this.showStrikethrough}}
            @onCheckedChange={{this.setShowStrikethrough}}
          >
            Strikethrough
          </MenubarCheckboxItem>
          <MenubarCheckboxItem
            @checked={{this.showCode}}
            @onCheckedChange={{this.setShowCode}}
          >
            Code
          </MenubarCheckboxItem>
          <MenubarCheckboxItem
            @checked={{this.showSuperscript}}
            @onCheckedChange={{this.setShowSuperscript}}
          >
            Superscript
          </MenubarCheckboxItem>
        </MenubarContent>
      </MenubarMenu>
    </Menubar>
  </template>
}
