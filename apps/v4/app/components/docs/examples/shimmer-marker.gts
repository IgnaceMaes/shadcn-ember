import { Marker, MarkerContent, MarkerIcon } from '@/components/ui/marker';
import { Spinner } from '@/components/ui/spinner';

<template>
  <div class="flex w-full max-w-sm flex-col gap-4">
    <Marker role="status">
      <MarkerIcon>
        <Spinner />
      </MarkerIcon>
      <MarkerContent class="shimmer">Thinking…</MarkerContent>
    </Marker>
    <Marker @variant="separator" role="status">
      <MarkerContent class="shimmer">Reading 4 files</MarkerContent>
    </Marker>
  </div>
</template>
