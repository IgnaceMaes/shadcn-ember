/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import {
  DocPage,
  DocHeader,
  DocContent,
  DocHeading,
  ComponentPreview,
  CodeBlockThemed,
} from '@/components/docs';
import CheckboxDemo from '@/components/docs/examples/checkbox-demo';
import checkboxDemoCode from '@/components/docs/examples/checkbox-demo.gts?raw';

const installationCode = `pnpm dlx shadcn@latest add checkbox`;

const usageCode = `import Checkbox from '@/components/ui/checkbox';`;

const usageExample = `<Checkbox />`;

// Main Documentation Component
class CheckboxDocs extends Component {
  <template>
    <DocPage>
      <div class="flex flex-col gap-2">
        <div class="flex flex-col gap-2">
          <DocHeader
            @title="Checkbox"
            @description="A control that allows the user to toggle between checked and not checked."
          />
        </div>
      </div>

      <DocContent>
        <ComponentPreview
          @component={{CheckboxDemo}}
          @code={{checkboxDemoCode}}
        />

        <DocHeading @id="installation">Installation</DocHeading>
        <CodeBlockThemed @language="bash" @code={{installationCode}} />

        <DocHeading @id="usage">Usage</DocHeading>
        <CodeBlockThemed @language="gts" @code={{usageCode}} />
        <CodeBlockThemed @language="gts" @code={{usageExample}} />
      </DocContent>
    </DocPage>
  </template>
}

export default CheckboxDocs;
