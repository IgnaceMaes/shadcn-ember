import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { DropdownMenu, DropdownMenuItem } from '@/components/ui/dropdown-menu';
import {
  Item,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from '@/components/ui/item';
import { array } from '@ember/helper';
import ChevronDownIcon from '~icons/lucide/chevron-down';

const people = [
  {
    username: 'shadcn',
    avatar: 'https://github.com/shadcn.png',
    email: 'shadcn@vercel.com',
  },
  {
    username: 'maxleiter',
    avatar: 'https://github.com/maxleiter.png',
    email: 'maxleiter@vercel.com',
  },
  {
    username: 'evilrabbit',
    avatar: 'https://github.com/evilrabbit.png',
    email: 'evilrabbit@vercel.com',
  },
];

<template>
  {{! template-lint-disable no-potential-path-strings }}
  <div class="flex min-h-64 w-full max-w-md flex-col items-center gap-6">
    <DropdownMenu as |dm|>
      <dm.Trigger @asChild={{true}}>
        <Button @variant="outline" @size="sm" @class="w-fit">
          Select
          <ChevronDownIcon />
        </Button>
      </dm.Trigger>
      <dm.Content @class="w-72 [--radius:0.65rem]">
        {{#each (array people) as |persons|}}
          {{#each persons as |person|}}
            <DropdownMenuItem @class="p-0">
              <Item @size="sm" @class="w-full p-2">
                <ItemMedia>
                  <Avatar @class="size-8">
                    <AvatarImage @src={{person.avatar}} @class="grayscale" />
                    <AvatarFallback>{{person.username}}</AvatarFallback>
                  </Avatar>
                </ItemMedia>
                <ItemContent @class="gap-0.5">
                  <ItemTitle>{{person.username}}</ItemTitle>
                  <ItemDescription>{{person.email}}</ItemDescription>
                </ItemContent>
              </Item>
            </DropdownMenuItem>
          {{/each}}
        {{/each}}
      </dm.Content>
    </DropdownMenu>
  </div>
</template>
