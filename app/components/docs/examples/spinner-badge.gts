import type { TOC } from '@ember/component/template-only';
import { Badge } from '@/components/ui/badge';
import { Spinner } from '@/components/ui/spinner';

const SpinnerBadge: TOC<{ Element: HTMLDivElement }> = <template>
  <div class="flex items-center gap-2">
    <Badge>
      <Spinner />
      Syncing
    </Badge>
    <Badge @variant="secondary">
      <Spinner />
      Updating
    </Badge>
    <Badge @variant="outline">
      <Spinner />
      Loading
    </Badge>
  </div>
</template>;

export default SpinnerBadge;
