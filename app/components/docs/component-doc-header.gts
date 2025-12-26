import type { TOC } from '@ember/component/template-only';
import Separator from '@/components/ui/separator';
import { or } from 'ember-truth-helpers';

interface Signature {
  Args: {
    title: string;
    description: string;
    docsUrl?: string;
    apiUrl?: string;
  };
}

export default <template>
  <div>
    {{! Breadcrumb }}
    <div class="mb-4 flex items-center space-x-1 text-sm text-muted-foreground">
      <div class="overflow-hidden text-ellipsis whitespace-nowrap">Docs</div>
      <div class="overflow-hidden text-ellipsis whitespace-nowrap">/</div>
      <div
        class="overflow-hidden text-ellipsis whitespace-nowrap"
      >Components</div>
    </div>

    {{! Title }}
    <div class="space-y-2">
      <h1 class="scroll-m-20 text-4xl font-bold tracking-tight">{{@title}}</h1>
      <p class="text-lg text-muted-foreground">
        {{@description}}
      </p>
    </div>

    {{#if (or @docsUrl @apiUrl)}}
      <div class="flex items-center gap-2 pt-2">
        {{#if @docsUrl}}
          <a
            href={{@docsUrl}}
            target="_blank"
            rel="noopener noreferrer"
            class="text-sm underline underline-offset-4"
          >
            Docs
          </a>
        {{/if}}
        {{#if @apiUrl}}
          <a
            href={{@apiUrl}}
            target="_blank"
            rel="noopener noreferrer"
            class="text-sm underline underline-offset-4"
          >
            API Reference
          </a>
        {{/if}}
      </div>
    {{/if}}

    <Separator class="my-6" />
  </div>
</template> satisfies TOC<Signature>;
