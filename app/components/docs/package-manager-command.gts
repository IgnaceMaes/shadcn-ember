import Component from '@glimmer/component';
import { service } from '@ember/service';
import { CodeBlock } from 'ember-shiki';
import { Tabs } from '@/components/ui/tabs';
import Terminal from '~icons/lucide/terminal';
import type ThemeService from '@/services/theme';

interface PackageManagerCommandSignature {
  Args: {
    /**
     * The npm command to render (e.g., "npm install foo")
     */
    command: string;
  };
}

export default class PackageManagerCommand extends Component<PackageManagerCommandSignature> {
  @service declare theme: ThemeService;

  /**
   * Convert npm command to other package managers
   */
  private convertCommand(manager: 'pnpm' | 'npm' | 'yarn' | 'bun'): string {
    const cmd = this.args.command.trim();

    // If it's already using a specific package manager, return as is
    if (!cmd.startsWith('npm ') && !cmd.startsWith('npx ')) {
      return cmd;
    }

    if (cmd.startsWith('npx ')) {
      const rest = cmd.slice(4); // Remove "npx "
      switch (manager) {
        case 'pnpm':
          return `pnpm dlx ${rest}`;
        case 'npm':
          return `npx ${rest}`;
        case 'yarn':
          return `npx ${rest}`;
        case 'bun':
          return `bunx --bun ${rest}`;
      }
    }

    if (cmd.startsWith('npm install') || cmd.startsWith('npm i ')) {
      const isShort = cmd.startsWith('npm i ');
      const rest = isShort ? cmd.slice(6) : cmd.slice(11); // Remove "npm i " or "npm install"

      switch (manager) {
        case 'pnpm':
          return `pnpm install${rest}`;
        case 'npm':
          return `npm install${rest}`;
        case 'yarn':
          return `yarn add${rest}`;
        case 'bun':
          return `bun add${rest}`;
      }
    }

    // For other npm commands
    const rest = cmd.slice(4); // Remove "npm "
    switch (manager) {
      case 'pnpm':
        return `pnpm ${rest}`;
      case 'npm':
        return `npm ${rest}`;
      case 'yarn':
        return `yarn ${rest}`;
      case 'bun':
        return `bun ${rest}`;
    }
  }

  get pnpmCommand() {
    return this.convertCommand('pnpm');
  }

  get npmCommand() {
    return this.convertCommand('npm');
  }

  get yarnCommand() {
    return this.convertCommand('yarn');
  }

  get bunCommand() {
    return this.convertCommand('bun');
  }

  <template>
    {{! template-lint-disable no-inline-styles }}
    <div
      class="overflow-hidden rounded-lg [&_pre]:max-h-none [&_pre]:m-0! [&_pre]:rounded-none!"
      style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
    >
      <Tabs @defaultValue="pnpm" as |pkgTabs|>
        <div
          class="border-border/50 flex items-center gap-2 border-b px-3 py-1"
        >
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
  </template>
}
