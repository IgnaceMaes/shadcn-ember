import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  DropdownMenu,
  DropdownMenuGroup,
  DropdownMenuItem,
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
      <dm.Content @class="[--radius:1rem]">
        <DropdownMenuGroup>
          <DropdownMenuItem>
            <VolumeOffIcon />
            Mute Conversation
          </DropdownMenuItem>
          <DropdownMenuItem>
            <CheckIcon />
            Mark as Read
          </DropdownMenuItem>
          <DropdownMenuItem>
            <AlertTriangleIcon />
            Report Conversation
          </DropdownMenuItem>
          <DropdownMenuItem>
            <UserRoundXIcon />
            Block User
          </DropdownMenuItem>
          <DropdownMenuItem>
            <ShareIcon />
            Share Conversation
          </DropdownMenuItem>
          <DropdownMenuItem>
            <CopyIcon />
            Copy Conversation
          </DropdownMenuItem>
        </DropdownMenuGroup>
        <DropdownMenuSeparator />
        <DropdownMenuGroup>
          <DropdownMenuItem @class="text-destructive focus:text-destructive">
            <TrashIcon />
            Delete Conversation
          </DropdownMenuItem>
        </DropdownMenuGroup>
      </dm.Content>
    </DropdownMenu>
  </ButtonGroup>
</template>
