import { service } from '@ember/service';
import Component from '@glimmer/component';
import { CodeBlock } from 'ember-shiki';

import CopyButton from '@/components/docs/copy-button';
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';

import type PackageManagerService from '@/services/package-manager';
import type { PackageManager } from '@/services/package-manager';
import type ThemeService from '@/services/theme';

import Terminal from '~icons/lucide/terminal';

interface PackageManagerCommandSignature {
  Args: {
    /**
     * The npm command to render (e.g., "npm install foo")
     */
    command: string;
  };
}

export default class PackageManagerCommand extends Component<PackageManagerCommandSignature> {
  @service declare packageManager: PackageManagerService;
  @service declare theme: ThemeService;

  handleTabChange = (value: string) => {
    this.packageManager.setPackageManager(
      value as PackageManager
    );
  };

  get currentCommand(): string {
    switch (this.packageManager.selectedManager) {
      case 'pnpm':
        return this.pnpmCommand;
      case 'npm':
        return this.npmCommand;
      case 'yarn':
        return this.yarnCommand;
      case 'bun':
        return this.bunCommand;
      default:
        return this.pnpmCommand;
    }
  }

  convertCommand(manager: 'pnpm' | 'npm' | 'yarn' | 'bun'): string {
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
      class="relative overflow-hidden rounded-lg [&_pre]:max-h-none [&_pre]:m-0! [&_pre]:rounded-none! mt-4"
      style="--shiki-dark: #e1e4e8; --shiki-light: #1f2328; --shiki-dark-bg: #24292e; --shiki-light-bg: var(--surface); background-color: var(--surface);"
    >
      <CopyButton @class="!top-1.5 !right-2" @value={{this.currentCommand}} />
      <Tabs
        @onValueChange={{this.handleTabChange}}
        @value={{this.packageManager.selectedManager}}
      >
        <div
          class="border-border/50 flex items-center gap-2 border-b px-3 py-1"
        >
          <div
            class="bg-foreground flex size-4 items-center justify-center rounded-[1px] opacity-70"
          >
            <Terminal class="size-3 text-white dark:text-black" />
          </div>
          <TabsList
            @class="text-muted-foreground inline-flex h-9 w-fit items-center justify-center rounded-none bg-transparent p-0"
          >
            <TabsTrigger
              @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
              @value="pnpm"
            >
              pnpm
            </TabsTrigger>
            <TabsTrigger
              @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
              @value="npm"
            >
              npm
            </TabsTrigger>
            <TabsTrigger
              @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
              @value="yarn"
            >
              yarn
            </TabsTrigger>
            <TabsTrigger
              @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex flex-1 items-center justify-center gap-1.5 rounded-md px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 data-[state=active]:bg-accent data-[state=active]:border-input h-7 border border-transparent pt-0.5 data-[state=active]:shadow-none"
              @value="bun"
            >
              bun
            </TabsTrigger>
          </TabsList>
        </div>
        <div class="no-scrollbar overflow-x-auto">
          <TabsContent
            @class="flex-1 outline-none mt-0 px-4 py-3.5"
            @value="pnpm"
          >
            <CodeBlock
              @code={{this.pnpmCommand}}
              @language="bash"
              @showCopyButton={{false}}
              @showLineNumbers={{false}}
              @theme={{this.theme.codeBlockTheme}}
              style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
            />
          </TabsContent>
          <TabsContent
            @class="flex-1 outline-none mt-0 px-4 py-3.5"
            @value="npm"
          >
            <CodeBlock
              @code={{this.npmCommand}}
              @language="bash"
              @showCopyButton={{false}}
              @showLineNumbers={{false}}
              @theme={{this.theme.codeBlockTheme}}
              style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
            />
          </TabsContent>
          <TabsContent
            @class="flex-1 outline-none mt-0 px-4 py-3.5"
            @value="yarn"
          >
            <CodeBlock
              @code={{this.yarnCommand}}
              @language="bash"
              @showCopyButton={{false}}
              @showLineNumbers={{false}}
              @theme={{this.theme.codeBlockTheme}}
              style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
            />
          </TabsContent>
          <TabsContent
            @class="flex-1 outline-none mt-0 px-4 py-3.5"
            @value="bun"
          >
            <CodeBlock
              @code={{this.bunCommand}}
              @language="bash"
              @showCopyButton={{false}}
              @showLineNumbers={{false}}
              @theme={{this.theme.codeBlockTheme}}
              style="--ember-shiki-padding-x: 0; --ember-shiki-padding-y: 0; --ember-shiki-border-radius: 0; --ember-shiki-background-color: transparent; --ember-shiki-line-height: 1.5; --ember-shiki-font-size: 0.875rem;"
            />
          </TabsContent>
        </div>
      </Tabs>
    </div>
  </template>
}
