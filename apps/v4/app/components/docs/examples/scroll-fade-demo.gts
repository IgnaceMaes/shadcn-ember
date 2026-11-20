const items = Array.from({ length: 12 }, (_, index) => index + 1);

<template>
  <div class="mx-auto w-full max-w-xs overflow-hidden rounded-2xl border">
    <div class="h-72 scroll-fade scrollbar-none overflow-y-auto">
      <div class="flex flex-col gap-1.5 p-1.5">
        {{#each items as |item|}}
          <div class="rounded-lg bg-muted px-3 py-2.5 text-sm">
            Item
            {{item}}
          </div>
        {{/each}}
      </div>
    </div>
  </div>
</template>
