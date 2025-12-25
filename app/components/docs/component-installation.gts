import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import Tabs from '@/components/ui/tabs';
import Terminal from '~icons/lucide/terminal';
import type ThemeService from '@/services/theme';
import type { ComponentLike } from '@glint/template';

// Load all UI components and their raw source code
const uiComponents = import.meta.glob<{ default: ComponentLike }>(
  '../ui/*.gts',
  { eager: true }
);
const uiRawSources = import.meta.glob('../ui/*.gts', {
  query: '?raw',
  eager: true,
  import: 'default',
});

interface ComponentInstallationSignature {
  Args: {
    /**
     * The name of the component (e.g., "checkbox", "button")
     */
    name: string;
    /**
     * Optional: The component class for extracting source code
     */
    component?: ComponentLike;
  };
}

export default class ComponentInstallation extends Component<ComponentInstallationSignature> {
  @service declare theme: ThemeService;

  get pnpmCommand() {
    return `pnpm dlx shadcn@latest add ${this.args.name}`;
  }

  get npmCommand() {
    return `npx shadcn@latest add ${this.args.name}`;
  }

  get yarnCommand() {
    return `npx shadcn@latest add ${this.args.name}`;
  }

  get bunCommand() {
    return `bunx --bun shadcn@latest add ${this.args.name}`;
  }

  get componentPath() {
    return `app/components/ui/${this.args.name}.gts`;
  }

  get rawSourceCode(): string {
    if (!this.args.component) {
      // Try to find by name
      for (const path in uiComponents) {
        if (path.includes(`/${this.args.name}.gts`)) {
          return (uiRawSources[path] as string) ?? '// Component source not found';
        }
      }
      return '// Component source not found';
    }

    // Find the matching source code for the component
    for (const path in uiComponents) {
      const module = uiComponents[path];
      if (module?.default === this.args.component) {
        return (uiRawSources[path] as string) ?? '// Component source not found';
      }
    }
    return '// Component source not found';
  }

  <template>
    <Tabs @defaultValue="cli" @class="relative mt-6 w-full" as |tabs|>
      <tabs.List
        @class="text-muted-foreground inline-flex h-9 w-fit items-center p-[3px] justify-start gap-4 rounded-none bg-transparent px-0"
      >
        <tabs.Trigger
          @value="cli"
          @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 py-1 font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 text-muted-foreground data-[state=active]:text-foreground data-[state=active]:border-primary dark:data-[state=active]:border-primary hover:text-primary rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base data-[state=active]:bg-transparent data-[state=active]:shadow-none dark:data-[state=active]:bg-transparent"
        >
          CLI
        </tabs.Trigger>
        <tabs.Trigger
          @value="manual"
          @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 py-1 font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 text-muted-foreground data-[state=active]:text-foreground data-[state=active]:border-primary dark:data-[state=active]:border-primary hover:text-primary rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base data-[state=active]:bg-transparent data-[state=active]:shadow-none dark:data-[state=active]:bg-transparent"
        >
          Manual
        </tabs.Trigger>
      </tabs.List>

      <tabs.Content @value="cli" @class="flex-1 outline-none relative mt-2">
        <div
          class="overflow-hidden rounded-lg [&_pre]:max-h-none [&_pre]:m-0! [&_pre]:rounded-none!"
          style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
        >
          <Tabs @defaultValue="pnpm" as |pkgTabs|>
            <div class="border-border/50 flex items-center gap-2 border-b px-3 py-1">
              <div
                class="bg-foreground flex size-4 items-center justify-center rounded-[1px] opacity-70"
              >
                <Terminal class="size-3 text-white dark:text-black" />
              </div>
              <pkgTabs.List
                @class="text-muted-foreground inline-flex h-9 w-fit items-center justify-center rounded-none bg-transparent p-0"
              >
                <pkgTabs.Trigger
                  @value="pnpm"
                  @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
                >
                  pnpm
                </pkgTabs.Trigger>
                <pkgTabs.Trigger
                  @value="npm"
                  @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
                >
                  npm
                </pkgTabs.Trigger>
                <pkgTabs.Trigger
                  @value="yarn"
                  @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
                >
                  yarn
                </pkgTabs.Trigger>
                <pkgTabs.Trigger
                  @value="bun"
                  @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
                >
                  bun
                </pkgTabs.Trigger>
              </pkgTabs.List>
            </div>
            <div class="no-scrollbar overflow-x-auto">
              <pkgTabs.Content
                @value="pnpm"
                @class="flex-1 outline-none mt-0 px-4 py-3.5"
              >
                <CodeBlock
                  @language="bash"
                  @code={{this.pnpmCommand}}
                  @showLineNumbers={{false}}
                  @theme={{this.theme.codeBlockTheme}}
                  style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
                />
              </pkgTabs.Content>
              <pkgTabs.Content
                @value="npm"
                @class="flex-1 outline-none mt-0 px-4 py-3.5"
              >
                <CodeBlock
                  @language="bash"
                  @code={{this.npmCommand}}
                  @showLineNumbers={{false}}
                  @theme={{this.theme.codeBlockTheme}}
                  style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
                />
              </pkgTabs.Content>
              <pkgTabs.Content
                @value="yarn"
                @class="flex-1 outline-none mt-0 px-4 py-3.5"
              >
                <CodeBlock
                  @language="bash"
                  @code={{this.yarnCommand}}
                  @showLineNumbers={{false}}
                  @theme={{this.theme.codeBlockTheme}}
                  style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
                />
              </pkgTabs.Content>
              <pkgTabs.Content
                @value="bun"
                @class="flex-1 outline-none mt-0 px-4 py-3.5"
              >
                <CodeBlock
                  @language="bash"
                  @code={{this.bunCommand}}
                  @showLineNumbers={{false}}
                  @theme={{this.theme.codeBlockTheme}}
                  style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
                />
              </pkgTabs.Content>
            </div>
          </Tabs>
        </div>
      </tabs.Content>

      <tabs.Content @value="manual" @class="flex-1 outline-none relative mt-2">
        <div class="space-y-4">
          <p class="text-muted-foreground">
            Copy and paste the following code into your project.
          </p>
          <div
            class="relative overflow-hidden rounded-lg border [&_pre]:max-h-100 [&_pre]:m-0! [&_pre]:rounded-none!"
            style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
          >
            <div class="border-border/50 flex items-center gap-2 border-b px-3 py-3">
              <span class="text-muted-foreground">
                {{this.componentPath}}
              </span>
            </div>
            <CodeBlock
              @language="typescript"
              @code={{this.rawSourceCode}}
              @showLineNumbers={{true}}
              @theme={{this.theme.codeBlockTheme}}
              style="--ember-shiki-padding-x: 1rem; --ember-shiki-padding-y: 0.875rem; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.6; --ember-shiki-font-size: 0.875rem;"
            />
          </div>
          <p class="text-muted-foreground">
            Update the import paths to match your project setup.
          </p>
        </div>
      </tabs.Content>
    </Tabs>
  </template>
}
