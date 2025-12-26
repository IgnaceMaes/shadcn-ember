import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';

<template>
  {{! template-lint-disable no-potential-path-strings }}
  <div class="flex flex-row flex-wrap items-center gap-12">
    <Avatar>
      <AvatarImage @src="https://github.com/shadcn.png" @alt="@shadcn" />
      <AvatarFallback>CN</AvatarFallback>
    </Avatar>
    <Avatar @class="rounded-lg">
      <AvatarImage
        @src="https://github.com/evilrabbit.png"
        @alt="@evilrabbit"
      />
      <AvatarFallback>ER</AvatarFallback>
    </Avatar>
    <div
      class="*:data-[slot=avatar]:ring-background flex -space-x-2 *:data-[slot=avatar]:ring-2 *:data-[slot=avatar]:grayscale"
    >
      <Avatar>
        <AvatarImage @src="https://github.com/shadcn.png" @alt="@shadcn" />
        <AvatarFallback>CN</AvatarFallback>
      </Avatar>
      <Avatar>
        <AvatarImage
          @src="https://github.com/maxleiter.png"
          @alt="@maxleiter"
        />
        <AvatarFallback>LR</AvatarFallback>
      </Avatar>
      <Avatar>
        <AvatarImage
          @src="https://github.com/evilrabbit.png"
          @alt="@evilrabbit"
        />
        <AvatarFallback>ER</AvatarFallback>
      </Avatar>
    </div>
  </div>
</template>
