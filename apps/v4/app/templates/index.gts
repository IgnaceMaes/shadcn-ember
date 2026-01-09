import { service } from '@ember/service';
import Component from '@glimmer/component';

import DocLinkTo from '@/components/docs/doc-link-to';
import AppearanceSettings from '@/components/docs/examples/appearance-settings';
import ButtonGroupDemo from '@/components/docs/examples/button-group-demo';
import ButtonGroupNested from '@/components/docs/examples/button-group-nested';
import ButtonGroupPopover from '@/components/docs/examples/button-group-popover';
import FieldCheckboxDemo from '@/components/docs/examples/field-checkbox-demo';
import FieldDemo from '@/components/docs/examples/field-demo';
import FieldHear from '@/components/docs/examples/field-hear';
import FieldSlider from '@/components/docs/examples/field-slider';
import InputGroupButtonHome from '@/components/docs/examples/input-group-button-home';
import InputGroupDemo from '@/components/docs/examples/input-group-demo';
import ItemDemo from '@/components/docs/examples/item-demo';
import NotionPromptForm from '@/components/docs/examples/notion-prompt-form';
import SpinnerBadge from '@/components/docs/examples/spinner-badge';
import SpinnerEmpty from '@/components/docs/examples/spinner-empty';
import ThemeSelector from '@/components/theme-selector';
import { Button } from '@/components/ui/button';
import ButtonGroupInputGroup from 'shadcn-ember/components/docs/examples/button-group-input-group';
import EmptyAvatarGroup from 'shadcn-ember/components/docs/examples/empty-avatar-group';
import { ExamplesNav } from 'shadcn-ember/components/examples-nav';
import { PageNav } from 'shadcn-ember/components/page-nav';
import { FieldSeparator } from 'shadcn-ember/components/ui/field';

import type ThemeService from '@/services/theme';

import ArrowRight from '~icons/lucide/arrow-right';

class IndexRoute extends Component {
  @service declare theme: ThemeService;

  <template>
    <div class="min-h-screen bg-background">
      <main>
        {{! Hero Section }}
        <section class="relative">
          <div class="container relative px-4 mx-auto">
            <div
              class="container flex flex-col items-center gap-2 py-8 text-center md:py-16 lg:py-20 xl:gap-4"
            >
              <DocLinkTo @route="docs.changelog">
                <Button
                  @class="rounded-full border border-transparent px-2 py-0.5 h-auto text-xs font-medium gap-1 hover:bg-secondary/90 bg-transparent [&>svg]:size-3"
                  @variant="ghost"
                >
                  <span
                    class="flex size-2 rounded-full bg-[#E04E39]"
                    title="New"
                  ></span>
                  shadcn/ui for Ember.js
                  <ArrowRight />
                </Button>
              </DocLinkTo>
              <h1
                class="text-primary leading-tighter text-4xl font-semibold tracking-tight text-balance lg:leading-[1.1] lg:font-semibold xl:text-5xl xl:tracking-tight max-w-4xl"
              >
                The Foundation for your Design System
              </h1>
              <p
                class="text-foreground max-w-3xl text-base text-balance sm:text-lg"
              >
                A set of beautifully designed components that you can customize,
                extend, and build on. Start here then make it your own. Open
                Source. Open Code.
              </p>
              <div
                class="flex flex-wrap items-center justify-center gap-4 pt-4"
              >
                <DocLinkTo @route="docs.installation">
                  <Button>
                    Get Started
                  </Button>
                </DocLinkTo>
                <DocLinkTo @route="docs.components">
                  <Button @variant="ghost">
                    View Components
                  </Button>
                </DocLinkTo>
              </div>
            </div>
          </div>
        </section>

        <PageNav @class="hidden md:flex">
          <ExamplesNav
            @class="[&>a:first-child]:text-primary flex-1 overflow-hidden"
          />
          <ThemeSelector class="mr-4 hidden md:flex" />
        </PageNav>

        {{! Component Examples }}
        <section class="container-wrapper section-soft flex-1 pb-6">
          <div class="container mx-auto px-4">
            {{! Masonry layout - manually balanced columns }}
            <div
              class="theme-container mx-auto grid gap-8 py-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-6 2xl:gap-8"
              data-theme={{this.theme.currentColorTheme}}
            >

              {{! Column 1 }}
              <div
                class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full"
              >
                {{! Field Demo }}
                <FieldDemo />
              </div>

              {{! Column 2 }}
              <div
                class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full"
              >
                <EmptyAvatarGroup />
                <SpinnerBadge />
                <ButtonGroupInputGroup />
                <FieldSlider />
                <InputGroupDemo />
              </div>

              {{! Column 3 }}
              <div
                class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full"
              >
                <InputGroupButtonHome />
                <ItemDemo />
                <FieldSeparator @class="my-4">Appearance Settings</FieldSeparator>
                <AppearanceSettings />
              </div>

              {{! Column 4 }}
              <div
                class="flex flex-col gap-6 *:[div]:w-full *:[div]:max-w-full"
              >
                <NotionPromptForm />
                <ButtonGroupDemo />
                <FieldCheckboxDemo />
                <div class="flex justify-between gap-4">
                  <ButtonGroupNested />
                  <ButtonGroupPopover />
                </div>
                <FieldHear />
                <SpinnerEmpty />
              </div>

            </div>
          </div>
        </section>
      </main>
    </div>
  </template>
}

export default IndexRoute;
