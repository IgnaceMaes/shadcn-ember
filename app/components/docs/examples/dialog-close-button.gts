import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

<template>
  <Dialog>
    <DialogTrigger>
      <Button @variant="outline">Share</Button>
    </DialogTrigger>
    <DialogContent @class="sm:max-w-md">
      <DialogHeader>
        <DialogTitle>Share link</DialogTitle>
        <DialogDescription>
          Anyone who has this link will be able to view this.
        </DialogDescription>
      </DialogHeader>
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
      <DialogFooter @class="sm:justify-start">
        <DialogClose>
          <Button type="button" @variant="secondary">
            Close
          </Button>
        </DialogClose>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>
