import { Item, ItemContent, ItemMedia, ItemTitle } from '@/components/ui/item';
import { Spinner } from '@/components/ui/spinner';

import type { TOC } from '@ember/component/template-only';

const SpinnerDemo: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex w-full max-w-xs flex-col gap-4 [--radius:1rem]">
    <Item @variant="muted">
      <ItemMedia>
        <Spinner />
      </ItemMedia>
      <ItemContent>
        <ItemTitle class="line-clamp-1">Processing payment...</ItemTitle>
      </ItemContent>
      <ItemContent class="flex-none justify-end">
        <span class="text-sm tabular-nums">$100.00</span>
      </ItemContent>
    </Item>
  </div>
</template>;

export default SpinnerDemo;
