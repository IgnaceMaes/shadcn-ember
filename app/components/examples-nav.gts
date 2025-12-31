import Component from '@glimmer/component';
import type { TOC } from '@ember/component/template-only';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { hash } from '@ember/helper';
import { cn } from '@/lib/utils';
import { ScrollArea, ScrollBar } from '@/components/ui/scroll-area';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';

interface Example {
  name: string;
  href: string;
  code: string;
  hidden: boolean;
  notImplemented?: boolean;
}

const examples: Example[] = [
  {
    name: 'Dashboard',
    href: '/examples/dashboard',
    code: 'https://github.com/shadcn/ui/tree/main/apps/v4/app/(app)/examples/dashboard',
    hidden: false,
  },
  {
    name: 'Tasks',
    href: '/examples/tasks',
    code: 'https://github.com/shadcn/ui/tree/main/apps/v4/app/(app)/examples/tasks',
    hidden: false,
  },
  {
    name: 'Playground',
    href: '/examples/playground',
    code: 'https://github.com/shadcn/ui/tree/main/apps/v4/app/(app)/examples/playground',
    hidden: false,
  },
  {
    name: 'Authentication',
    href: '/examples/authentication',
    code: 'https://github.com/shadcn/ui/tree/main/apps/v4/app/(app)/examples/authentication',
    hidden: false,
  },
].map((example) => ({ ...example, notImplemented: true }));

interface ExamplesNavSignature {
  Element: HTMLDivElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

class ExamplesNav extends Component<ExamplesNavSignature> {
  @service declare router: RouterService;

  get currentPath() {
    return this.router.currentURL || '/';
  }

  isActive = (href: string) => {
    if (href === '/') {
      return this.currentPath === '/';
    }
    return this.currentPath.startsWith(href);
  };

  <template>
    <div class={{cn "flex items-center" @class}} ...attributes>
      <ScrollArea @class="max-w-[96%] md:max-w-[600px] lg:max-w-none">
        <div class="flex items-center">
          <ExampleLink
            @example={{hash code="" hidden=false href="/" name="Examples"}}
            @isActive={{this.isActive "/"}}
          />
          {{#each examples as |example|}}
            <ExampleLink
              @example={{example}}
              @isActive={{this.isActive example.href}}
            />
          {{/each}}
        </div>
        <ScrollBar @class="invisible" @orientation="horizontal" />
      </ScrollArea>
    </div>
  </template>
}

interface ExampleLinkSignature {
  Element: HTMLAnchorElement;
  Args: {
    example: Example;
    isActive: boolean;
  };
  Blocks: {
    default: [];
  };
}

const ExampleLink: TOC<ExampleLinkSignature> = <template>
  {{#unless @example.hidden}}
    {{#if @example.notImplemented}}
      <Tooltip>
        <TooltipTrigger>
          <span
            class="text-muted-foreground hover:text-primary data-[active=true]:text-primary flex h-7 cursor-not-allowed items-center justify-center px-4 text-center text-base font-medium opacity-60 transition-colors"
            data-active={{if @isActive "true" "false"}}
            ...attributes
          >
            {{@example.name}}
          </span>
        </TooltipTrigger>
        <TooltipContent>
          Not yet implemented. Contributions welcome.
        </TooltipContent>
      </Tooltip>
    {{else}}
      <a
        class="text-muted-foreground hover:text-primary data-[active=true]:text-primary flex h-7 items-center justify-center px-4 text-center text-base font-medium transition-colors"
        data-active={{if @isActive "true" "false"}}
        href={{@example.href}}
        ...attributes
      >
        {{@example.name}}
      </a>
    {{/if}}
  {{/unless}}
</template>;

export { ExamplesNav };
