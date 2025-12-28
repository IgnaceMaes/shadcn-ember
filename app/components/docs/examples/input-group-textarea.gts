import Copy from '~icons/lucide/copy';
import CornerDownLeft from '~icons/lucide/corner-down-left';
import Refresh from '~icons/lucide/refresh-cw';
import FileCode from '~icons/lucide/file-code-2';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupText,
  InputGroupTextarea,
} from '@/components/ui/input-group';

<template>
  <div class="grid w-full max-w-md gap-4">
    <InputGroup>
      <InputGroupTextarea
        @placeholder="console.log('Hello, world!');"
        @class="min-h-[200px]"
      />
      <InputGroupAddon @align="block-end" @class="border-t">
        <InputGroupText>Line 1, Column 1</InputGroupText>
        <InputGroupButton @size="sm" @class="ml-auto" @variant="default">
          Run
          <CornerDownLeft />
        </InputGroupButton>
      </InputGroupAddon>
      <InputGroupAddon @align="block-start" @class="border-b">
        <InputGroupText @class="font-mono font-medium">
          <FileCode />
          script.js
        </InputGroupText>
        <InputGroupButton @class="ml-auto" @size="icon-xs">
          <Refresh />
        </InputGroupButton>
        <InputGroupButton @variant="ghost" @size="icon-xs">
          <Copy />
        </InputGroupButton>
      </InputGroupAddon>
    </InputGroup>
  </div>
</template>
