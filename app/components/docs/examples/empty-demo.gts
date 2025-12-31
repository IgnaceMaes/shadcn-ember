import { Button } from '@/components/ui/button';
import {
  Empty,
  EmptyContent,
  EmptyDescription,
  EmptyHeader,
  EmptyMedia,
  EmptyTitle,
} from '@/components/ui/empty';
import ArrowUpRight from '~icons/lucide/arrow-up-right';
import FolderCode from '~icons/lucide/folder-code';

<template>
  <Empty>
    <EmptyHeader>
      <EmptyMedia @variant="icon">
        <FolderCode />
      </EmptyMedia>
      <EmptyTitle>No Projects Yet</EmptyTitle>
      <EmptyDescription>
        You haven't created any projects yet. Get started by creating your first
        project.
      </EmptyDescription>
    </EmptyHeader>
    <EmptyContent>
      <div class="flex gap-2">
        <Button>Create Project</Button>
        <Button @variant="outline">Import Project</Button>
      </div>
    </EmptyContent>
    <Button
      @asChild={{true}}
      @class="text-muted-foreground"
      @size="sm"
      @variant="link"
      as |classes|
    >
      <a class={{classes}} href="#">
        Learn More
        <ArrowUpRight />
      </a>
    </Button>
  </Empty>
</template>
