/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import { cn } from '@/lib/utils';
// import PhCaretLeft from 'ember-phosphor-icons/components/ph-caret-left';
// import PhCaretRight from 'ember-phosphor-icons/components/ph-caret-right';
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

export class Carousel extends Component<CarouselSignature> {
  <template>
    <div class={{cn "relative" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

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

export class CarouselContent extends Component<CarouselContentSignature> {
  <template>
    <div class="overflow-hidden">
      <div class={{cn "flex" @class}} ...attributes>
        {{yield}}
      </div>
    </div>
  </template>
}

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

export class CarouselItem extends Component<CarouselItemSignature> {
  <template>
    <div class={{cn "min-w-0 shrink-0 grow-0 basis-full" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

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

export class CarouselPrevious extends Component<CarouselPreviousSignature> {
  <template>
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
  </template>
}

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

export class CarouselNext extends Component<CarouselNextSignature> {
  <template>
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
  </template>
}

export default Carousel;
