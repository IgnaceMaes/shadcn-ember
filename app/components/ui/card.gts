import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface CardSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Card: TOC<CardSignature> = <template>
  <div
    data-slot="card"
    class={{cn
      "bg-card text-card-foreground flex flex-col gap-6 rounded-xl border py-6 shadow-sm"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CardHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardHeader: TOC<CardHeaderSignature> = <template>
  <div
    data-slot="card-header"
    class={{cn
      "@container/card-header grid auto-rows-min grid-rows-[auto_auto] items-start gap-2 px-6 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CardTitleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardTitle: TOC<CardTitleSignature> = <template>
  <div
    data-slot="card-title"
    class={{cn "leading-none font-semibold" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CardDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardDescription: TOC<CardDescriptionSignature> = <template>
  <div
    data-slot="card-description"
    class={{cn "text-muted-foreground text-sm" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CardActionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardAction: TOC<CardActionSignature> = <template>
  <div
    data-slot="card-action"
    class={{cn
      "col-start-2 row-span-2 row-start-1 self-start justify-self-end"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

interface CardContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardContent: TOC<CardContentSignature> = <template>
  <div data-slot="card-content" class={{cn "px-6" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

interface CardFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const CardFooter: TOC<CardFooterSignature> = <template>
  <div
    data-slot="card-footer"
    class={{cn "flex items-center px-6 [.border-t]:pt-6" @class}}
    ...attributes
  >
    {{yield}}
  </div>
</template>;

export {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardAction,
  CardContent,
  CardFooter,
};
