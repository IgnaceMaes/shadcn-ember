import { Marker, MarkerContent, MarkerIcon } from '@/components/ui/marker';

import BookOpenCheckIcon from '~icons/lucide/book-open-check';
import GitBranchIcon from '~icons/lucide/git-branch';
import SearchIcon from '~icons/lucide/search';

<template>
  <div class="flex w-full max-w-sm flex-col gap-12 py-12">
    <Marker>
      <MarkerIcon>
        <GitBranchIcon />
      </MarkerIcon>
      <MarkerContent>Switched to a new branch</MarkerContent>
    </Marker>
    <Marker @variant="separator">
      <MarkerIcon>
        <SearchIcon />
      </MarkerIcon>
      <MarkerContent>Explored 4 files</MarkerContent>
    </Marker>
    <Marker class="flex-col">
      <MarkerIcon>
        <BookOpenCheckIcon />
      </MarkerIcon>
      <MarkerContent>Syncing completed</MarkerContent>
    </Marker>
  </div>
</template>
