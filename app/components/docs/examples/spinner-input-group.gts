import type { TOC } from '@ember/component/template-only';
import ArrowUp from '~icons/lucide/arrow-up';
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
  InputGroupTextarea,
} from '@/components/ui/input-group';
import { Spinner } from '@/components/ui/spinner';

const SpinnerInputGroup: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex w-full max-w-md flex-col gap-4">
    <InputGroup>
      <InputGroupInput placeholder="Send a message..." disabled />
      <InputGroupAddon @align="inline-end">
        <Spinner />
      </InputGroupAddon>
    </InputGroup>
    <InputGroup>
      <InputGroupTextarea placeholder="Send a message..." disabled />
      <InputGroupAddon @align="block-end">
        <Spinner />
        Validating...
        <InputGroupButton class="ml-auto" @variant="default">
          <ArrowUp />
          <span class="sr-only">Send</span>
        </InputGroupButton>
      </InputGroupAddon>
    </InputGroup>
  </div>
</template>;

export default SpinnerInputGroup;
