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
      <DropdownMenuGroup>
        <DropdownMenuItem>
          Profile
          <DropdownMenuShortcut>⇧⌘P</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem>
          Billing
          <DropdownMenuShortcut>⌘B</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem>
          Settings
          <DropdownMenuShortcut>⌘S</DropdownMenuShortcut>
        </DropdownMenuItem>
        <DropdownMenuItem>
          Keyboard shortcuts
          <DropdownMenuShortcut>⌘K</DropdownMenuShortcut>
        </DropdownMenuItem>
      </DropdownMenuGroup>
      <DropdownMenuSeparator />
      <DropdownMenuGroup>
        <DropdownMenuItem>Team</DropdownMenuItem>
        <DropdownMenuSub as |isSubOpen|>
          <DropdownMenuSubTrigger>Invite users</DropdownMenuSubTrigger>
          <DropdownMenuPortal>
            <DropdownMenuSubContent @isOpen={{isSubOpen}}>
              <DropdownMenuItem>Email</DropdownMenuItem>
              <DropdownMenuItem>Message</DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem>More...</DropdownMenuItem>
            </DropdownMenuSubContent>
          </DropdownMenuPortal>
        </DropdownMenuSub>
        <DropdownMenuItem>
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
