import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import type ThemeService from '@/services/theme';

interface ComponentPreviewSignature {
  Args: {
    code: string;
    showLineNumbers?: boolean;
    align?: 'start' | 'center' | 'end';
  };
  Blocks: {
    default: [];
  };
}

export default class ComponentPreview extends Component<ComponentPreviewSignature> {
  @service declare theme: ThemeService;

  get showLineNumbers() {
    return this.args.showLineNumbers ?? true;
  }

  get align() {
    return this.args.align ?? 'center';
  }

  <template>
    <div class="group relative mt-4 mb-12 flex flex-col rounded-lg border overflow-hidden">
      <div data-slot="preview">
        <div
          data-align={{this.align}}
          class="preview flex w-full justify-center data-[align=center]:items-center data-[align=end]:items-end data-[align=start]:items-start h-[450px] p-10"
        >
          {{yield}}
        </div>
      </div>
      <div
        data-slot="code"
        class="border-t"
      >
        <div class="relative [&_pre]:max-h-[400px] [&_pre]:!m-0 [&_pre]:!rounded-none">
          <CodeBlock
            @language="gts"
            @code={{@code}}
            @showLineNumbers={{this.showLineNumbers}}
            @theme={{this.theme.codeBlockTheme}}
            style="--ember-shiki-padding-x: 1rem; --ember-shiki-padding-y: 0.875rem; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.6; --ember-shiki-font-size: 0.875rem; background-color: transparent; --shiki-light-bg: #fff; --shiki-dark-bg: #0d1117;"
          />
        </div>
      </div>
    </div>
  </template>
}
