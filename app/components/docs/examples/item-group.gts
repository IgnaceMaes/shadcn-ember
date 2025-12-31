import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemGroup,
  ItemMedia,
  ItemSeparator,
  ItemTitle,
} from '@/components/ui/item';
import { array } from '@ember/helper';
import { lt } from 'ember-truth-helpers';
import PlusIcon from '~icons/lucide/plus';

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
  <div class="flex w-full max-w-md flex-col gap-6">
    <ItemGroup>
      {{#each (array people) as |persons|}}
        {{#each persons as |person index|}}
          <Item>
            <ItemMedia>
              <Avatar>
                <AvatarImage @class="grayscale" @src={{person.avatar}} />
                <AvatarFallback>{{person.username}}</AvatarFallback>
              </Avatar>
            </ItemMedia>
            <ItemContent @class="gap-1">
              <ItemTitle>{{person.username}}</ItemTitle>
              <ItemDescription>{{person.email}}</ItemDescription>
            </ItemContent>
            <ItemActions>
              <Button @class="rounded-full" @size="icon" @variant="ghost">
                <PlusIcon />
              </Button>
            </ItemActions>
          </Item>
          {{#if (lt index 2)}}
            <ItemSeparator />
          {{/if}}
        {{/each}}
      {{/each}}
    </ItemGroup>
  </div>
</template>
