import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import { Kbd, KbdGroup } from '@/components/ui/kbd';
import { Tooltip } from '@/components/ui/tooltip';

<template>
  <div class="flex flex-wrap gap-4">
    <ButtonGroup>
      <Tooltip as |t|>
        <t.Trigger>
          <Button @size="sm" @variant="outline">
            Save
          </Button>
        </t.Trigger>
        <t.Content>
          <div class="flex items-center gap-2">
            Save Changes
            <Kbd>S</Kbd>
          </div>
        </t.Content>
      </Tooltip>
      <Tooltip as |t|>
        <t.Trigger>
          <Button @size="sm" @variant="outline">
            Print
          </Button>
        </t.Trigger>
        <t.Content>
          <div class="flex items-center gap-2">
            Print Document
            <KbdGroup>
              <Kbd>Ctrl</Kbd>
              <Kbd>P</Kbd>
            </KbdGroup>
          </div>
        </t.Content>
      </Tooltip>
    </ButtonGroup>
  </div>
</template>
