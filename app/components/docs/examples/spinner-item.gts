import type { TOC } from '@ember/component/template-only';
import { Button } from '@/components/ui/button';
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemFooter,
  ItemMedia,
  ItemTitle,
} from '@/components/ui/item';
import { Progress } from '@/components/ui/progress';
import { Spinner } from '@/components/ui/spinner';

const SpinnerItem: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex w-full max-w-md flex-col gap-4 [--radius:1rem]">
    <Item @variant="outline">
      <ItemMedia @variant="icon">
        <Spinner />
      </ItemMedia>
      <ItemContent>
        <ItemTitle>Downloading...</ItemTitle>
        <ItemDescription>129 MB / 1000 MB</ItemDescription>
      </ItemContent>
      <ItemActions @class="hidden sm:flex">
        <Button @size="sm" @variant="outline">
          Cancel
        </Button>
      </ItemActions>
      <ItemFooter>
        <Progress @value={{75}} />
      </ItemFooter>
    </Item>
  </div>
</template>;

export default SpinnerItem;
