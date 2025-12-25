import { AspectRatio } from '@/components/ui/aspect-ratio';

const ratio = 16 / 9;

<template>
  <div class="w-full max-w-xl">
    <AspectRatio @ratio={{ratio}} class="bg-muted rounded-lg overflow-hidden">
      <img
        src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80"
        alt="Decorative by Drew Beamer"
        class="h-full w-full rounded-lg object-cover"
      />
    </AspectRatio>
  </div>
</template>
