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

export const Card: TOC<CardSignature> = <template>
  <div
    class={{cn "rounded-xl border bg-card text-card-foreground shadow" @class}}
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

export const CardHeader: TOC<CardHeaderSignature> = <template>
  <div class={{cn "flex flex-col space-y-1.5 p-6" @class}} ...attributes>
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

export const CardTitle: TOC<CardTitleSignature> = <template>
  <div
    class={{cn "font-semibold leading-none tracking-tight" @class}}
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

export const CardDescription: TOC<CardDescriptionSignature> = <template>
  <div class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
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

export const CardContent: TOC<CardContentSignature> = <template>
  <div class={{cn "p-6 pt-0" @class}} ...attributes>
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

export const CardFooter: TOC<CardFooterSignature> = <template>
  <div class={{cn "flex items-center p-6 pt-0" @class}} ...attributes>
    {{yield}}
  </div>
</template>;

export default Card;
