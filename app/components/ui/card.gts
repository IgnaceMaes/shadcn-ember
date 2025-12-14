/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
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

export class Card extends Component<CardSignature> {
  <template>
    <div
      class={{cn "rounded-xl border bg-card text-card-foreground shadow" @class}}
      ...attributes
    >
      {{yield}}
    </div>
  </template>
}

interface CardHeaderSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CardHeader extends Component<CardHeaderSignature> {
  <template>
    <div class={{cn "flex flex-col space-y-1.5 p-6" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

interface CardTitleSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CardTitle extends Component<CardTitleSignature> {
  <template>
    <div class={{cn "font-semibold leading-none tracking-tight" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

interface CardDescriptionSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CardDescription extends Component<CardDescriptionSignature> {
  <template>
    <div class={{cn "text-sm text-muted-foreground" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

interface CardContentSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CardContent extends Component<CardContentSignature> {
  <template>
    <div class={{cn "p-6 pt-0" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

interface CardFooterSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export class CardFooter extends Component<CardFooterSignature> {
  <template>
    <div class={{cn "flex items-center p-6 pt-0" @class}} ...attributes>
      {{yield}}
    </div>
  </template>
}

export default Card;
