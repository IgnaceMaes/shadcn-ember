import Check from '~icons/lucide/check';
import InfoCircle from '~icons/lucide/info';
import Plus from '~icons/lucide/plus';
import ArrowUp from '~icons/lucide/arrow-up';
import Search from '~icons/lucide/search';

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
  InputGroupText,
  InputGroupTextarea,
} from '@/components/ui/input-group';
import { Separator } from '@/components/ui/separator';
import { Tooltip } from '@/components/ui/tooltip';

<template>
  <div class="grid w-full max-w-sm gap-6">
    <InputGroup>
      <InputGroupInput placeholder="Search..." />
      <InputGroupAddon>
        <Search />
      </InputGroupAddon>
      <InputGroupAddon @align="inline-end">12 results</InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="example.com" @class="!pl-1" />
      <InputGroupAddon>
        <InputGroupText>https://</InputGroupText>
      </InputGroupAddon>
      <InputGroupAddon @align="inline-end">
        <Tooltip as |t|>
          <t.Trigger>
            <InputGroupButton
              @class="rounded-full"
              @size="icon-xs"
              @variant="ghost"
              aria-label="Info"
            >
              <InfoCircle />
            </InputGroupButton>
          </t.Trigger>
          <t.Content>This is content in a tooltip.</t.Content>
        </Tooltip>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupTextarea placeholder="Ask, Search or Chat..." />
      <InputGroupAddon @align="block-end">
        <InputGroupButton
          @variant="outline"
          @class="rounded-full"
          @size="icon-xs"
          aria-label="Add"
        >
          <Plus />
        </InputGroupButton>
        <DropdownMenu as |d|>
          <d.Trigger>
            <InputGroupButton @variant="ghost">Auto</InputGroupButton>
          </d.Trigger>
          <d.Content
            {{! @side="top" }}
            @align="start"
            @class="[--radius:0.95rem]"
          >
            <DropdownMenuItem>Auto</DropdownMenuItem>
            <DropdownMenuItem>Agent</DropdownMenuItem>
            <DropdownMenuItem>Manual</DropdownMenuItem>
          </d.Content>
        </DropdownMenu>
        <InputGroupText @class="ml-auto">52% used</InputGroupText>
        <Separator @orientation="vertical" @class="!h-4" />
        <InputGroupButton
          @variant="default"
          @class="rounded-full"
          @size="icon-xs"
        >
          <ArrowUp />
          <span class="sr-only">Send</span>
        </InputGroupButton>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="shadcn" />
      <InputGroupAddon @align="inline-end">
        <div
          class="bg-primary text-foreground flex size-4 items-center justify-center rounded-full"
        >
          <Check class="size-3 text-white" />
        </div>
      </InputGroupAddon>
    </InputGroup>
  </div>
</template>
