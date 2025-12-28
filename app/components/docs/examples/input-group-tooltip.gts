import HelpCircle from '~icons/lucide/help-circle';
import Info from '~icons/lucide/info';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from '@/components/ui/input-group';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';

<template>
  <div class="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroupInput placeholder="Enter password" type="password" />
      <InputGroupAddon @align="inline-end">
        <Tooltip>
          <TooltipTrigger>
            <InputGroupButton
              @variant="ghost"
              aria-label="Info"
              @size="icon-xs"
            >
              <Info />
            </InputGroupButton>
          </TooltipTrigger>
          <TooltipContent>
            <p>Password must be at least 8 characters</p>
          </TooltipContent>
        </Tooltip>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Your email address" />
      <InputGroupAddon @align="inline-end">
        <Tooltip>
          <TooltipTrigger>
            <InputGroupButton
              @variant="ghost"
              aria-label="Help"
              @size="icon-xs"
            >
              <HelpCircle />
            </InputGroupButton>
          </TooltipTrigger>
          <TooltipContent>
            <p>We'll use this to send you notifications</p>
          </TooltipContent>
        </Tooltip>
      </InputGroupAddon>
    </InputGroup>

    <InputGroup>
      <InputGroupInput placeholder="Enter API key" />
      <Tooltip @placement="left">
        <TooltipTrigger>
          <InputGroupAddon>
            <InputGroupButton
              @variant="ghost"
              aria-label="Help"
              @size="icon-xs"
            >
              <HelpCircle />
            </InputGroupButton>
          </InputGroupAddon>
        </TooltipTrigger>
        <TooltipContent>
          <p>Click for help with API keys</p>
        </TooltipContent>
      </Tooltip>
    </InputGroup>
  </div>
</template>
