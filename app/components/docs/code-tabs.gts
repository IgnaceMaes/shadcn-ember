import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { hash } from '@ember/helper';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';

interface Signature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class CodeTabs extends Component<Signature> {
  @tracked selectedTab = 'cli';

  handleValueChange = (value: string) => {
    this.selectedTab = value;
  };

  <template>
    <div ...attributes>
      <Tabs
        @value={{this.selectedTab}}
        @onValueChange={{this.handleValueChange}}
      >
        {{yield
          (hash
            TabsList=TabsList TabsTrigger=TabsTrigger TabsContent=TabsContent
          )
        }}
      </Tabs>
    </div>
  </template>
}
