import { Button } from '@/components/ui/button';
import { Dialog } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

<template>
  <Dialog as |d|>
    <d.Trigger>
      <Button @variant="outline">Share</Button>
    </d.Trigger>
    <d.Content @class="sm:max-w-md">
      <d.Header>
        <d.Title>Share link</d.Title>
        <d.Description>
          Anyone who has this link will be able to view this.
        </d.Description>
      </d.Header>
      <div class="flex items-center gap-2">
        <div class="grid flex-1 gap-2">
          <Label @for="link" @class="sr-only">
            Link
          </Label>
          <Input
            id="link"
            value="https://ui.shadcn.com/docs/installation"
            readonly
          />
        </div>
      </div>
      <d.Footer @class="sm:justify-start">
        <d.Close>
          <Button type="button" @variant="secondary">
            Close
          </Button>
        </d.Close>
      </d.Footer>
    </d.Content>
  </Dialog>
</template>
