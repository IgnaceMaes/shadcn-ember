import { Marker, MarkerContent, MarkerIcon } from '@/components/ui/marker';

import FileTextIcon from '~icons/lucide/file-text';
import GitBranchIcon from '~icons/lucide/git-branch';
import SearchIcon from '~icons/lucide/search';

<template>
  <div class="flex w-full max-w-sm flex-col gap-3 py-12">
    <Marker @variant="border">
      <MarkerIcon>
        <GitBranchIcon />
      </MarkerIcon>
      <MarkerContent>Switched to release-candidate</MarkerContent>
    </Marker>
    <Marker @variant="border">
      <MarkerIcon>
        <SearchIcon />
      </MarkerIcon>
      <MarkerContent>Reviewed 8 related files</MarkerContent>
    </Marker>
    <Marker @variant="border">
      <MarkerIcon>
        <FileTextIcon />
      </MarkerIcon>
      <MarkerContent>Opened implementation notes</MarkerContent>
    </Marker>
  </div>
</template>
