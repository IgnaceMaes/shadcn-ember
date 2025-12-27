import Bookmark from '~icons/lucide/bookmark';
import { Toggle } from '@/components/ui/toggle';

<template>
  <Toggle
    aria-label="Toggle bookmark"
    @size="sm"
    @variant="outline"
    @class="data-[state=on]:bg-transparent [&[data-state=on]_svg_*]:fill-blue-500 [&[data-state=on]_svg_*]:stroke-blue-500"
  >
    <Bookmark />
    Bookmark
  </Toggle>
</template>
