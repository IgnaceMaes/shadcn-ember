import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';
import ChevronLeft from '~icons/lucide/chevron-left';
import ChevronRight from '~icons/lucide/chevron-right';
import Button from './button.gts';

// Note: This is a simplified placeholder for the Carousel component
// Full implementation would require embla-carousel or similar library

// Carousel Root Component
interface CarouselSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
    orientation?: 'horizontal' | 'vertical';
  };
  Blocks: {
    default: [];
  };
}

export const Carousel: TOC<CarouselSignature> = <template>
  <div class={{cn "relative" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

// CarouselContent Component
interface CarouselContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const CarouselContent: TOC<CarouselContentSignature> = <template>
  <div class="overflow-hidden">
    <div class={{cn "flex" @class}} ...attributes>
      {{yield}}
    </div>
  </div>
</template>;

// CarouselItem Component
interface CarouselItemSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const CarouselItem: TOC<CarouselItemSignature> = <template>
  <div class={{cn "min-w-0 shrink-0 grow-0 basis-full" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

// CarouselPrevious Component
interface CarouselPreviousSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const CarouselPrevious: TOC<CarouselPreviousSignature> = <template>
  <Button
    @variant="outline"
    @size="icon"
    class={{cn
      "absolute h-8 w-8 rounded-full left-4 top-1/2 -translate-y-1/2"
      @class
    }}
    ...attributes
  >
    <ChevronLeft class="size-4" />
    <span class="sr-only">Previous slide</span>
  </Button>
</template>;

// CarouselNext Component
interface CarouselNextSignature {
  Element: HTMLButtonElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const CarouselNext: TOC<CarouselNextSignature> = <template>
  <Button
    @variant="outline"
    @size="icon"
    class={{cn
      "absolute h-8 w-8 rounded-full right-4 top-1/2 -translate-y-1/2"
      @class
    }}
    ...attributes
  >
    <ChevronRight class="size-4" />
    <span class="sr-only">Next slide</span>
  </Button>
</template>;

export default Carousel;
