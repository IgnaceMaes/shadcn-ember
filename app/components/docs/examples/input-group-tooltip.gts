import HelpCircle from '~icons/lucide/help-circle';
import Info from '~icons/lucide/info';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from '@/components/ui/input-group';
import { Tooltip } from '@/components/ui/tooltip';

<template>
  <div class="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroupInput placeholder="Enter password" type="password" />
      <InputGroupAddon @align="inline-end">
        <Tooltip as |t|>
          <t.Trigger>
            <InputGroupButton
              @variant="ghost"
              aria-label="Info"
              @size="icon-xs"
            >
              <Info />
            </InputGroupButton>
          </t.Trigger>
          <t.Content>
            <p>Password must be at least 8 characters</p>
          </t.Content>
        </Tooltip>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Your email address" />
      <InputGroupAddon @align="inline-end">
        <Tooltip as |t|>
          <t.Trigger>
            <InputGroupButton
              @variant="ghost"
              aria-label="Help"
              @size="icon-xs"
            >
              <HelpCircle />
            </InputGroupButton>
          </t.Trigger>
          <t.Content>
            <p>We'll use this to send you notifications</p>
          </t.Content>
        </Tooltip>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Enter API key" />
      <Tooltip @placement="left" as |t|>
        <t.Trigger>
          <InputGroupAddon>
            <InputGroupButton
              @variant="ghost"
              aria-label="Help"
              @size="icon-xs"
            >
              <HelpCircle />
            </InputGroupButton>
          </InputGroupAddon>
        </t.Trigger>
        <t.Content>
          <p>Click for help with API keys</p>
        </t.Content>
      </Tooltip>
    </InputGroup>
  </div>
</template>
