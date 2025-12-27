import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '@/components/ui/button';
import { ButtonGroup } from '@/components/ui/button-group';
import Input from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
} from '@/components/ui/select';
import ArrowRightIcon from '~icons/lucide/arrow-right';

const CURRENCIES = [
  {
    value: '$',
    label: 'US Dollar',
  },
  {
    value: '€',
    label: 'Euro',
  },
  {
    value: '£',
    label: 'British Pound',
  },
];

export default class ButtonGroupSelect extends Component {
  @tracked currency = '$';

  handleCurrencyChange = (value: string) => {
    this.currency = value;
  };

  <template>
    <ButtonGroup>
      <ButtonGroup>
        <Select
          @value={{this.currency}}
          @onValueChange={{this.handleCurrencyChange}}
        >
          <SelectTrigger class="font-mono">{{this.currency}}</SelectTrigger>
          <SelectContent @class="min-w-24">
            {{#each CURRENCIES as |currency|}}
              <SelectItem @value={{currency.value}}>
                {{currency.value}}
                <span class="text-muted-foreground">{{currency.label}}</span>
              </SelectItem>
            {{/each}}
          </SelectContent>
        </Select>
        <Input placeholder="10.00" pattern="[0-9]*" />
      </ButtonGroup>
      <ButtonGroup>
        <Button aria-label="Send" @size="icon" @variant="outline">
          <ArrowRightIcon />
        </Button>
      </ButtonGroup>
    </ButtonGroup>
  </template>
}
