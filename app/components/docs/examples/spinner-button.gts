import { Button } from '@/components/ui/button';
import { Spinner } from '@/components/ui/spinner';

import type { TOC } from '@ember/component/template-only';

const SpinnerButton: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex flex-col items-center gap-4">
    <Button @disabled={{true}} @size="sm">
      <Spinner />
      Loading...
    </Button>
    <Button @disabled={{true}} @size="sm" @variant="outline">
      <Spinner />
      Please wait
    </Button>
    <Button @disabled={{true}} @size="sm" @variant="secondary">
      <Spinner />
      Processing
    </Button>
  </div>
</template>;

export default SpinnerButton;
