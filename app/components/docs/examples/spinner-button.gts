import type { TOC } from '@ember/component/template-only';
import { Button } from '@/components/ui/button';
import { Spinner } from '@/components/ui/spinner';

const SpinnerButton: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex flex-col items-center gap-4">
    <Button @disabled={{true}} @size="sm">
      <Spinner />
      Loading...
    </Button>
    <Button @variant="outline" @disabled={{true}} @size="sm">
      <Spinner />
      Please wait
    </Button>
    <Button @variant="secondary" @disabled={{true}} @size="sm">
      <Spinner />
      Processing
    </Button>
  </div>
</template>;

export default SpinnerButton;
