import BadgeCheck from '~icons/lucide/badge-check';
import ChevronRight from '~icons/lucide/chevron-right';
import { Button } from '@/components/ui/button';
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from '@/components/ui/item';

<template>
  <div class="flex w-full max-w-md flex-col gap-6">
    <Item @variant="outline">
      <ItemContent>
        <ItemTitle>Two-factor authentication</ItemTitle>
        <ItemDescription @class="text-pretty xl:hidden 2xl:block">
          Verify via email or phone number.
        </ItemDescription>
      </ItemContent>
      <ItemActions>
        <Button @size="sm">Enable</Button>
      </ItemActions>
    </Item>
    <Item @variant="outline" @size="sm" @asChild={{true}} as |item|>
      <a
        href="#"
        data-slot={{item.slot}}
        data-variant={{item.variant}}
        data-size={{item.size}}
        class={{item.class}}
      >
        <ItemMedia>
          <BadgeCheck class="size-5" />
        </ItemMedia>
        <ItemContent>
          <ItemTitle>Your profile has been verified.</ItemTitle>
        </ItemContent>
        <ItemActions>
          <ChevronRight class="size-4" />
        </ItemActions>
      </a>
    </Item>
  </div>
</template>
