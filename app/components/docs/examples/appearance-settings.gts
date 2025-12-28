import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Minus from '~icons/lucide/minus';
import Plus from '~icons/lucide/plus';
import { Button } from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import {
  Field,
  FieldContent,
  FieldDescription,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSeparator,
  FieldSet,
  FieldTitle,
} from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import { RadioGroup } from '@/components/ui/radio-group';
import { Switch } from '@/components/ui/switch';

export default class AppearanceSettings extends Component {
  @tracked gpuCount = 8;

  handleGpuAdjustment = (adjustment: number) => {
    this.gpuCount = Math.max(1, Math.min(99, this.gpuCount + adjustment));
  };

  handleGpuInputChange = (event: Event) => {
    const value = parseInt((event.target as HTMLInputElement).value, 10);
    if (!isNaN(value) && value >= 1 && value <= 99) {
      this.gpuCount = value;
    }
  };

  get isMinGpu() {
    return this.gpuCount <= 1;
  }

  get isMaxGpu() {
    return this.gpuCount >= 99;
  }

  <template>
    <FieldSet>
      <FieldGroup>
        <FieldSet>
          <FieldLegend>Compute Environment</FieldLegend>
          <FieldDescription>
            Select the compute environment for your cluster.
          </FieldDescription>
          <RadioGroup @defaultValue="kubernetes" as |rg|>
            <FieldLabel @for="kubernetes-r2h">
              <Field @orientation="horizontal">
                <FieldContent>
                  <FieldTitle>Kubernetes</FieldTitle>
                  <FieldDescription>
                    Run GPU workloads on a K8s configured cluster. This is the
                    default.
                  </FieldDescription>
                </FieldContent>
                <rg.Item
                  @value="kubernetes"
                  id="kubernetes-r2h"
                  aria-label="Kubernetes"
                />
              </Field>
            </FieldLabel>
            <FieldLabel @for="vm-z4k">
              <Field @orientation="horizontal">
                <FieldContent>
                  <FieldTitle>Virtual Machine</FieldTitle>
                  <FieldDescription>
                    Access a VM configured cluster to run workloads. (Coming
                    soon)
                  </FieldDescription>
                </FieldContent>
                <rg.Item @value="vm" id="vm-z4k" aria-label="Virtual Machine" />
              </Field>
            </FieldLabel>
          </RadioGroup>
        </FieldSet>
        <FieldSeparator />
        <Field @orientation="horizontal">
          <FieldContent>
            <FieldLabel @for="number-of-gpus-f6l">Number of GPUs</FieldLabel>
            <FieldDescription>You can add more later.</FieldDescription>
          </FieldContent>
          <ButtonGroup>
            <Input
              id="number-of-gpus-f6l"
              value={{this.gpuCount}}
              {{on "input" this.handleGpuInputChange}}
              size="3"
              @class="h-8 !w-14 font-mono"
              maxlength="3"
            />
            <Button
              @variant="outline"
              @size="icon-sm"
              type="button"
              aria-label="Decrement"
              @disabled={{this.isMinGpu}}
              {{on "click" (fn this.handleGpuAdjustment -1)}}
            >
              <Minus />
            </Button>
            <Button
              @variant="outline"
              @size="icon-sm"
              type="button"
              aria-label="Increment"
              @disabled={{this.isMaxGpu}}
              {{on "click" (fn this.handleGpuAdjustment 1)}}
            >
              <Plus />
            </Button>
          </ButtonGroup>
        </Field>
        <FieldSeparator />
        <Field @orientation="horizontal">
          <FieldContent>
            <FieldLabel @for="tinting">Wallpaper Tinting</FieldLabel>
            <FieldDescription>
              Allow the wallpaper to be tinted.
            </FieldDescription>
          </FieldContent>
          <Switch id="tinting" @checked={{true}} />
        </Field>
      </FieldGroup>
    </FieldSet>
  </template>
}
