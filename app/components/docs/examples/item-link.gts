import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemTitle,
} from '@/components/ui/item';
import ChevronRightIcon from '~icons/lucide/chevron-right';
import ExternalLinkIcon from '~icons/lucide/external-link';

<template>
  <div class="flex w-full max-w-md flex-col gap-4">
    <Item>
      <a href="#">
        <ItemContent>
          <ItemTitle>Visit our documentation</ItemTitle>
          <ItemDescription>
            Learn how to get started with our components.
          </ItemDescription>
        </ItemContent>
        <ItemActions>
          <ChevronRightIcon class="size-4" />
        </ItemActions>
      </a>
    </Item>
    <Item @variant="outline">
      <a href="#" target="_blank" rel="noopener noreferrer">
        <ItemContent>
          <ItemTitle>External resource</ItemTitle>
          <ItemDescription>
            Opens in a new tab with security attributes.
          </ItemDescription>
        </ItemContent>
        <ItemActions>
          <ExternalLinkIcon class="size-4" />
        </ItemActions>
      </a>
    </Item>
  </div>
</template>
