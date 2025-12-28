import type { TOC } from '@ember/component/template-only';
import { Button } from '@/components/ui/button';
import {
  Empty,
  EmptyContent,
  EmptyDescription,
  EmptyHeader,
  EmptyMedia,
  EmptyTitle,
} from '@/components/ui/empty';
import { Spinner } from '@/components/ui/spinner';

const SpinnerEmpty: TOC<{ Element: HTMLDivElement }> = <template>
  <Empty @class="w-full border md:p-6">
    <EmptyHeader>
      <EmptyMedia @variant="icon">
        <Spinner />
      </EmptyMedia>
      <EmptyTitle>Processing your request</EmptyTitle>
      <EmptyDescription>
        Please wait while we process your request. Do not refresh the page.
      </EmptyDescription>
    </EmptyHeader>
    <EmptyContent>
      <Button @variant="outline" @size="sm">
        Cancel
      </Button>
    </EmptyContent>
  </Empty>
</template>;

export default SpinnerEmpty;
