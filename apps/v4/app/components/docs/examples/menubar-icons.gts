import {
  Menubar,
  MenubarContent,
  MenubarGroup,
  MenubarItem,
  MenubarMenu,
  MenubarSeparator,
  MenubarShortcut,
  MenubarTrigger,
} from '@/components/ui/menubar';

import FileIcon from '~icons/lucide/file';
import FolderIcon from '~icons/lucide/folder';
import HelpCircleIcon from '~icons/lucide/help-circle';
import SaveIcon from '~icons/lucide/save';
import SettingsIcon from '~icons/lucide/settings';
import TrashIcon from '~icons/lucide/trash';

<template>
  <Menubar @class="w-72">
    <MenubarMenu>
      <MenubarTrigger>File</MenubarTrigger>
      <MenubarContent>
        <MenubarItem>
          <FileIcon />
          New File
          <MenubarShortcut>⌘N</MenubarShortcut>
        </MenubarItem>
        <MenubarItem>
          <FolderIcon />
          Open Folder
        </MenubarItem>
        <MenubarSeparator />
        <MenubarItem>
          <SaveIcon />
          Save
          <MenubarShortcut>⌘S</MenubarShortcut>
        </MenubarItem>
      </MenubarContent>
    </MenubarMenu>
    <MenubarMenu>
      <MenubarTrigger>More</MenubarTrigger>
      <MenubarContent>
        <MenubarGroup>
          <MenubarItem>
            <SettingsIcon />
            Settings
          </MenubarItem>
          <MenubarItem>
            <HelpCircleIcon />
            Help
          </MenubarItem>
          <MenubarSeparator />
          <MenubarItem @variant="destructive">
            <TrashIcon />
            Delete
          </MenubarItem>
        </MenubarGroup>
      </MenubarContent>
    </MenubarMenu>
  </Menubar>
</template>
