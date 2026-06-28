const items = Array.from({ length: 8 }, (_, index) => index + 1);

<template>
  <div class="mx-auto flex w-full max-w-xs min-w-0 flex-col gap-6">
    <div class="flex flex-col gap-3">
      <div class="overflow-hidden rounded-2xl border">
        <div class="h-48 scroll-fade scrollbar-none overflow-y-auto">
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
      <p class="text-center font-mono text-xs text-muted-foreground">
        scroll-fade
      </p>
    </div>
    <div class="flex flex-col gap-3">
      <div class="overflow-hidden rounded-2xl border">
        <div
          class="h-48 scroll-fade scrollbar-none overflow-y-auto scroll-fade-none"
        >
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
      <p class="text-center font-mono text-xs text-muted-foreground">
        scroll-fade scroll-fade-none
      </p>
    </div>
  </div>
</template>
