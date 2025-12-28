import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuPortal,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
} from '@/components/ui/dropdown-menu';

<template>
  <DropdownMenu as |dm|>
    <dm.Trigger @asChild={{true}}>
      <Button @variant="outline">Open</Button>
    </dm.Trigger>
    <dm.Content @class="w-56" @align="start">
      <DropdownMenuLabel>My Account</DropdownMenuLabel>
      <DropdownMenuGroup as |closeSubmenus|>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>
          Profile
          <DropdownMenuShortcut>⇧⌘P</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>
          Billing
          <DropdownMenuShortcut>⌘B</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>
          Settings
          <DropdownMenuShortcut>⌘S</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>
          Keyboard shortcuts
          <DropdownMenuShortcut>⌘K</DropdownMenuShortcut>
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuSeparator />
      <DropdownMenuGroup as |closeSubmenus|>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>Team</DropdownMenuItem>
        <DropdownMenuSub @closeOtherSubmenus={{closeSubmenus}} as |sub|>
          <sub.Trigger>Invite users</sub.Trigger>
          <DropdownMenuPortal>
            <sub.Content>
              <DropdownMenuItem>Email</DropdownMenuItem>
              <DropdownMenuItem>Message</DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem>More...</DropdownMenuItem>
            </sub.Content>
          </DropdownMenuPortal>
        </DropdownMenuSub>
        <DropdownMenuItem @closeOtherSubmenus={{closeSubmenus}}>
          New Team
          <DropdownMenuShortcut>⌘+T</DropdownMenuShortcut>
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuSeparator />
      <DropdownMenuItem>GitHub</DropdownMenuItem>
      <DropdownMenuItem>Support</DropdownMenuItem>
      <DropdownMenuItem @disabled={{true}}>API</DropdownMenuItem>
      <DropdownMenuSeparator />
      <DropdownMenuItem>
        Log out
        <DropdownMenuShortcut>⇧⌘Q</DropdownMenuShortcut>
      </DropdownMenuItem>
    </dm.Content>
  </DropdownMenu>
</template>
