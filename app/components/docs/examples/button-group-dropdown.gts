import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  DropdownMenu,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';
import AlertTriangleIcon from '~icons/lucide/alert-triangle';
import CheckIcon from '~icons/lucide/check';
import ChevronDownIcon from '~icons/lucide/chevron-down';
import CopyIcon from '~icons/lucide/copy';
import ShareIcon from '~icons/lucide/share';
import TrashIcon from '~icons/lucide/trash';
import UserRoundXIcon from '~icons/lucide/user-round-x';
import VolumeOffIcon from '~icons/lucide/volume-off';

<template>
  <ButtonGroup>
    <Button @variant="outline">Follow</Button>
    <DropdownMenu as |dm|>
      <dm.Trigger @asChild={{true}}>
        <Button @variant="outline" class="!pl-2">
          <ChevronDownIcon />
        </Button>
      </dm.Trigger>
      <dm.Content @class="[--radius:1rem]" as |c|>
        <c.Group as |g|>
          <g.Item>
            <VolumeOffIcon />
            Mute Conversation
          </g.Item>
          <g.Item>
            <CheckIcon />
            Mark as Read
          </g.Item>
          <g.Item>
            <AlertTriangleIcon />
            Report Conversation
          </g.Item>
          <g.Item>
            <UserRoundXIcon />
            Block User
          </g.Item>
          <g.Item>
            <ShareIcon />
            Share Conversation
          </g.Item>
          <g.Item>
            <CopyIcon />
            Copy Conversation
          </g.Item>
        </c.Group>
        <DropdownMenuSeparator />
        <c.Group as |g|>
          <g.Item @class="text-destructive focus:text-destructive">
            <TrashIcon />
            Delete Conversation
          </g.Item>
        </c.Group>
      </dm.Content>
    </DropdownMenu>
  </ButtonGroup>
</template>
