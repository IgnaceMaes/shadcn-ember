import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuPortal,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
} from '@/components/ui/dropdown-menu';

<template>
  <DropdownMenu as |dm|>
    <dm.Trigger @asChild={{true}}>
      <Button @variant="outline">Open</Button>
    </dm.Trigger>
    <dm.Content @class="w-56" @align="start">
      <DropdownMenuLabel>My Account</DropdownMenuLabel>
      <DropdownMenuGroup as |g|>
        <g.Item>
          Profile
          <DropdownMenuShortcut>⇧⌘P</DropdownMenuShortcut>
        </g.Item>
        <g.Item>
          Billing
          <DropdownMenuShortcut>⌘B</DropdownMenuShortcut>
        </g.Item>
        <g.Item>
          Settings
          <DropdownMenuShortcut>⌘S</DropdownMenuShortcut>
        </g.Item>
        <g.Item>
          Keyboard shortcuts
          <DropdownMenuShortcut>⌘K</DropdownMenuShortcut>
        </g.Item>
      </DropdownMenuGroup>
      <DropdownMenuSeparator />
      <DropdownMenuGroup as |g|>
        <g.Item>Team</g.Item>
        <g.Sub as |sub|>
          <sub.Trigger>Invite users</sub.Trigger>
          <DropdownMenuPortal>
            <sub.Content>
              <DropdownMenuItem>Email</DropdownMenuItem>
              <DropdownMenuItem>Message</DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem>More...</DropdownMenuItem>
            </sub.Content>
          </DropdownMenuPortal>
        </g.Sub>
        <g.Item>
          New Team
          <DropdownMenuShortcut>⌘+T</DropdownMenuShortcut>
        </g.Item>
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
