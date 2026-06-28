import {
  Attachment,
  AttachmentAction,
  AttachmentActions,
  AttachmentContent,
  AttachmentDescription,
  AttachmentGroup,
  AttachmentMedia,
  AttachmentTitle,
} from '@/components/ui/attachment';

import type { ComponentLike } from '@glint/template';

import FileCodeIcon from '~icons/lucide/file-code';
import FileTextIcon from '~icons/lucide/file-text';
import TableIcon from '~icons/lucide/table';
import XIcon from '~icons/lucide/x';

const items = [
  {
    name: 'briefing-notes.pdf',
    meta: 'PDF · 1.4 MB',
    icon: FileTextIcon as ComponentLike,
  },
  {
    name: 'workspace.png',
    meta: 'PNG · 820 KB',
    src: 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=900&auto=format&fit=crop&q=80',
  },
  {
    name: 'customers.csv',
    meta: 'CSV · 18 KB',
    icon: TableIcon as ComponentLike,
  },
  {
    name: 'renderer.tsx',
    meta: 'TSX · 12 KB',
    icon: FileCodeIcon as ComponentLike,
  },
];

<template>
  {{! template-lint-disable no-potential-path-strings }}
  <div class="mx-auto w-full max-w-sm py-12">
    <AttachmentGroup @class="w-full">
      {{#each items as |item|}}
        <Attachment @class="w-64">
          {{#if item.src}}
            <AttachmentMedia @variant="image">
              <img alt={{item.name}} src={{item.src}} />
            </AttachmentMedia>
          {{else if item.icon}}
            <AttachmentMedia>
              <item.icon />
            </AttachmentMedia>
          {{/if}}
          <AttachmentContent>
            <AttachmentTitle>{{item.name}}</AttachmentTitle>
            <AttachmentDescription>{{item.meta}}</AttachmentDescription>
          </AttachmentContent>
          <AttachmentActions>
            <AttachmentAction aria-label="Remove {{item.name}}">
              <XIcon />
            </AttachmentAction>
          </AttachmentActions>
        </Attachment>
      {{/each}}
    </AttachmentGroup>
  </div>
</template>
