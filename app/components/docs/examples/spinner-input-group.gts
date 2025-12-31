import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
  InputGroupTextarea,
} from '@/components/ui/input-group';
import { Spinner } from '@/components/ui/spinner';

import type { TOC } from '@ember/component/template-only';

import ArrowUp from '~icons/lucide/arrow-up';

const SpinnerInputGroup: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex w-full max-w-md flex-col gap-4">
    <InputGroup>
      <InputGroupInput disabled placeholder="Send a message..." />
      <InputGroupAddon @align="inline-end">
        <Spinner />
      </InputGroupAddon>
    </InputGroup>
    <InputGroup>
      <InputGroupTextarea disabled placeholder="Send a message..." />
      <InputGroupAddon @align="block-end">
        <Spinner />
        Validating...
        <InputGroupButton @variant="default" class="ml-auto">
          <ArrowUp />
          <span class="sr-only">Send</span>
        </InputGroupButton>
      </InputGroupAddon>
    </InputGroup>
  </div>
</template>;

export default SpinnerInputGroup;
