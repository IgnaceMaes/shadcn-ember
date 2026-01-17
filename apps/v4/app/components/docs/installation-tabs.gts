import { service } from '@ember/service';
import Component from '@glimmer/component';

import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';

import MarkdownNodes from './markdown-nodes';

import type InstallationMethodService from '@/services/installation-method';
import type { InstallationMethod } from '@/services/installation-method';

interface ProcessedNode {
  type: string;
  content?: string;
  children?: ProcessedNode[];
  [key: string]: unknown;
}

interface InstallationTabsSignature {
  Args: {
    cliNodes: ProcessedNode[];
    manualNodes: ProcessedNode[];
  };
  Element: HTMLDivElement;
}

export default class InstallationTabs extends Component<InstallationTabsSignature> {
  @service declare installationMethod: InstallationMethodService;

  handleTabChange = (value: string) => {
    this.installationMethod.setMethod(value as InstallationMethod);
  };

  <template>
    <Tabs
      @class="relative mt-6 w-full"
      @onValueChange={{this.handleTabChange}}
      @value={{this.installationMethod.selectedMethod}}
    >
      <TabsList
        @class="h-9 w-fit justify-start gap-4 rounded-none bg-transparent p-0"
      >
        <TabsTrigger
          @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:text-muted-foreground inline-flex h-[calc(100%-1px)] items-center justify-center gap-1.5 py-1 font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 text-muted-foreground data-[state=active]:text-foreground data-[state=active]:border-primary dark:data-[state=active]:border-primary hover:text-primary rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base data-[state=active]:bg-transparent data-[state=active]:shadow-none dark:data-[state=active]:bg-transparent"
          @value="cli"
        >
          CLI
        </TabsTrigger>
        <TabsTrigger
          @class="dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:text-muted-foreground inline-flex h-[calc(100%-1px)] items-center justify-center gap-1.5 py-1 font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 text-muted-foreground data-[state=active]:text-foreground data-[state=active]:border-primary dark:data-[state=active]:border-primary hover:text-primary rounded-none border-0 border-b-2 border-transparent bg-transparent px-0 pb-3 text-base data-[state=active]:bg-transparent data-[state=active]:shadow-none dark:data-[state=active]:bg-transparent"
          @value="manual"
        >
          Manual
        </TabsTrigger>
      </TabsList>
      <TabsContent
        @class="relative [&_h3.font-heading]:text-base [&_h3.font-heading]:mt-8"
        @value="cli"
      >
        <MarkdownNodes @nodes={{@cliNodes}} />
      </TabsContent>
      <TabsContent
        @class="relative [&_h3.font-heading]:text-base [&_h3.font-heading]:mt-8"
        @value="manual"
      >
        <MarkdownNodes @nodes={{@manualNodes}} />
      </TabsContent>
    </Tabs>
  </template>
}
