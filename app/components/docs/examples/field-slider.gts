import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import type Owner from '@ember/owner';
import { Field, FieldDescription, FieldTitle } from '@/components/ui/field';
import { Slider } from '@/components/ui/slider';

class FieldSlider extends Component {
  @tracked value = [200, 800];

  constructor(owner: Owner, args: object) {
    super(owner, args);
  }

  handleValueChange = (newValue: number[]) => {
    this.value = newValue;
  };

  get minValue() {
    return this.value[0];
  }

  get maxValue() {
    return this.value[1] ?? this.value[0];
  }

  <template>
    <div class="w-full max-w-md">
      <Field>
        <FieldTitle>Price Range</FieldTitle>
        <FieldDescription>
          Set your budget range ($<span
            class="font-medium tabular-nums"
          >{{this.minValue}}</span>
          -
          <span class="font-medium tabular-nums">{{this.maxValue}}</span>).
        </FieldDescription>
        <Slider
          @value={{this.value}}
          @onValueChange={{this.handleValueChange}}
          @max={{1000}}
          @min={{0}}
          @step={{10}}
          @class="mt-2 w-full"
          aria-label="Price Range"
        />
      </Field>
    </div>
  </template>
}

export default FieldSlider;
