import {
  Attachment,
  AttachmentAction,
  AttachmentActions,
  AttachmentContent,
  AttachmentDescription,
  AttachmentMedia,
  AttachmentTitle,
} from '@/components/ui/attachment';
import { Spinner } from '@/components/ui/spinner';

import CheckIcon from '~icons/lucide/check';
import ClockIcon from '~icons/lucide/clock';
import FileTextIcon from '~icons/lucide/file-text';
import FileWarningIcon from '~icons/lucide/file-warning';
import RefreshCwIcon from '~icons/lucide/refresh-cw';
import XIcon from '~icons/lucide/x';

<template>
  <div class="mx-auto flex w-full max-w-sm flex-col gap-2 py-12">
    <Attachment @class="w-full" @state="idle">
      <AttachmentMedia>
        <ClockIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>selected-file.pdf</AttachmentTitle>
        <AttachmentDescription>Ready to upload</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Remove selected-file.pdf">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment @class="w-full" @state="uploading">
      <AttachmentMedia>
        <Spinner />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>design-system.zip</AttachmentTitle>
        <AttachmentDescription>Uploading · 64%</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Cancel upload">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment @class="w-full" @state="processing">
      <AttachmentMedia>
        <FileTextIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>market-research.pdf</AttachmentTitle>
        <AttachmentDescription>Processing document</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Remove market-research.pdf">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment @class="w-full" @state="error">
      <AttachmentMedia>
        <FileWarningIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>financial-model.xlsx</AttachmentTitle>
        <AttachmentDescription>
          Upload failed. Try again.
        </AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Retry upload">
          <RefreshCwIcon />
        </AttachmentAction>
        <AttachmentAction aria-label="Remove financial-model.xlsx">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment @class="w-full" @state="done">
      <AttachmentMedia>
        <CheckIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>uploaded-report.pdf</AttachmentTitle>
        <AttachmentDescription>Uploaded · 1.8 MB</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Remove uploaded-report.pdf">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
  </div>
</template>
