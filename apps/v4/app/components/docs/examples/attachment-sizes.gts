import {
  Attachment,
  AttachmentContent,
  AttachmentDescription,
  AttachmentMedia,
  AttachmentTitle,
} from '@/components/ui/attachment';

import FileTextIcon from '~icons/lucide/file-text';

<template>
  <div class="mx-auto flex w-full max-w-sm flex-col gap-3 py-12">
    <Attachment @class="w-full" @size="default">
      <AttachmentMedia>
        <FileTextIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>Default attachment</AttachmentTitle>
        <AttachmentDescription>PDF · 2.4 MB</AttachmentDescription>
      </AttachmentContent>
    </Attachment>
    <Attachment @class="w-full" @size="sm">
      <AttachmentMedia>
        <FileTextIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>Small attachment</AttachmentTitle>
        <AttachmentDescription>PDF · 2.4 MB</AttachmentDescription>
      </AttachmentContent>
    </Attachment>
    <Attachment @class="w-full" @size="xs">
      <AttachmentMedia>
        <FileTextIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>Extra small attachment</AttachmentTitle>
      </AttachmentContent>
    </Attachment>
  </div>
</template>
