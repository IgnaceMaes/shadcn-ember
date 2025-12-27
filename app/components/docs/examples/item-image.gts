import {
  Item,
  ItemContent,
  ItemDescription,
  ItemGroup,
  ItemMedia,
  ItemTitle,
} from '@/components/ui/item';
import { array } from '@ember/helper';

const music = [
  {
    title: 'Midnight City Lights',
    artist: 'Neon Dreams',
    album: 'Electric Nights',
    duration: '3:45',
  },
  {
    title: 'Coffee Shop Conversations',
    artist: 'The Morning Brew',
    album: 'Urban Stories',
    duration: '4:05',
  },
  {
    title: 'Digital Rain',
    artist: 'Cyber Symphony',
    album: 'Binary Beats',
    duration: '3:30',
  },
];

<template>
  {{! template-lint-disable no-potential-path-strings }}
  <div class="flex w-full max-w-md flex-col gap-6">
    <ItemGroup @class="gap-4">
      {{#each (array music) as |songs|}}
        {{#each songs as |song|}}
          <Item @variant="outline">
            <a href="#">
              <ItemMedia @variant="image">
                <img
                  src="https://avatar.vercel.sh/{{song.title}}"
                  alt={{song.title}}
                  width="32"
                  height="32"
                  class="object-cover grayscale"
                />
              </ItemMedia>
              <ItemContent>
                <ItemTitle @class="line-clamp-1">
                  {{song.title}}
                  -
                  <span class="text-muted-foreground">{{song.album}}</span>
                </ItemTitle>
                <ItemDescription>{{song.artist}}</ItemDescription>
              </ItemContent>
              <ItemContent @class="flex-none text-center">
                <ItemDescription>{{song.duration}}</ItemDescription>
              </ItemContent>
            </a>
          </Item>
        {{/each}}
      {{/each}}
    </ItemGroup>
  </div>
</template>
