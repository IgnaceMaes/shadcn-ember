import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
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
    <dm.Content @class="w-56" @align="start" as |c|>
      <DropdownMenuLabel>My Account</DropdownMenuLabel>
      <c.Group as |g|>
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
      </c.Group>
      <DropdownMenuSeparator />
      <c.Group as |g|>
        <g.Item>Team</g.Item>
        <g.Sub as |sub|>
          <sub.Trigger>Invite users</sub.Trigger>
          <DropdownMenuPortal>
            <sub.Content as |sc|>
              <sc.Item>Email</sc.Item>
              <sc.Item>Message</sc.Item>
              <DropdownMenuSeparator />
              <sc.Item>More...</sc.Item>
            </sub.Content>
          </DropdownMenuPortal>
        </g.Sub>
        <g.Item>
          New Team
          <DropdownMenuShortcut>⌘+T</DropdownMenuShortcut>
        </g.Item>
      </c.Group>
      <DropdownMenuSeparator />
      <c.Item>GitHub</c.Item>
      <c.Item>Support</c.Item>
      <c.Item @disabled={{true}}>API</c.Item>
      <DropdownMenuSeparator />
      <c.Item>
        Log out
        <DropdownMenuShortcut>⇧⌘Q</DropdownMenuShortcut>
      </c.Item>
    </dm.Content>
  </DropdownMenu>
</template>
