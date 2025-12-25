/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from '@glimmer/component';
import {
  DocPage,
  DocHeader,
  DocContent,
  ComponentDocSection,
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
      <DocHeader
        @title="Checkbox"
        @description="A control that allows the user to toggle between checked and not checked."
      />

      <DocContent>
        <section>
          <ComponentPreview @component={{CheckboxDemo}} @code={{checkboxDemoCode}} />
        </section>

        <div class="space-y-8 pt-8">
          <ComponentDocSection @title="Installation">
            <CodeBlockThemed @language="bash" @code={{installationCode}} />
          </ComponentDocSection>

          <ComponentDocSection @title="Usage">
            <CodeBlockThemed @language="gts" @code={{usageCode}} />
            <CodeBlockThemed @language="gts" @code={{usageExample}} />
          </ComponentDocSection>
        </div>
      </DocContent>
    </DocPage>
  </template>
}

export default CheckboxDocs;
