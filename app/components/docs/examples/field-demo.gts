import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  Field,
  FieldDescription,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSeparator,
  FieldSet,
} from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import { Select } from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';

class FieldDemoState {
  @tracked cardName = '';
  @tracked cardNumber = '';
  @tracked cvv = '';
  @tracked expMonth = '';
  @tracked expYear = '';
  @tracked sameAsShipping = true;
  @tracked comments = '';

  updateCardName = (event: Event) => {
    this.cardName = (event.target as HTMLInputElement).value;
  };

  updateCardNumber = (event: Event) => {
    this.cardNumber = (event.target as HTMLInputElement).value;
  };

  updateCvv = (event: Event) => {
    this.cvv = (event.target as HTMLInputElement).value;
  };

  updateComments = (event: Event) => {
    this.comments = (event.target as HTMLTextAreaElement).value;
  };

  selectMonth = (value: string) => {
    this.expMonth = value;
  };

  selectYear = (value: string) => {
    this.expYear = value;
  };

  toggleSameAsShipping = (checked: boolean) => {
    this.sameAsShipping = checked;
  };

  handleSubmit = (event: Event) => {
    event.preventDefault();
    console.log('Form submitted');
  };
}

const state = new FieldDemoState();

<template>
  <div class="w-full rounded-lg border p-6">
    <form {{on "submit" state.handleSubmit}}>
      <FieldGroup>
        <FieldSet>
          <FieldLegend>Payment Method</FieldLegend>
          <FieldDescription>
            All transactions are secure and encrypted
          </FieldDescription>
          <FieldGroup>
            <Field>
              <FieldLabel @for="checkout-card-name">
                Name on Card
              </FieldLabel>
              <Input
                id="checkout-card-name"
                placeholder="John Doe"
                value={{state.cardName}}
                {{on "input" state.updateCardName}}
                required
              />
            </Field>
            <div class="grid grid-cols-3 gap-4">
              <Field @class="col-span-2">
                <FieldLabel @for="checkout-card-number">
                  Card Number
                </FieldLabel>
                <Input
                  id="checkout-card-number"
                  placeholder="1234 5678 9012 3456"
                  value={{state.cardNumber}}
                  {{on "input" state.updateCardNumber}}
                  required
                />
                <FieldDescription>
                  Enter your 16-digit number.
                </FieldDescription>
              </Field>
              <Field @class="col-span-1">
                <FieldLabel @for="checkout-cvv">CVV</FieldLabel>
                <Input
                  id="checkout-cvv"
                  placeholder="123"
                  value={{state.cvv}}
                  {{on "input" state.updateCvv}}
                  required
                />
              </Field>
            </div>
            <div class="grid grid-cols-2 gap-4">
              <Field>
                <FieldLabel @for="checkout-exp-month">
                  Month
                </FieldLabel>
                <Select @onValueChange={{state.selectMonth}} as |s|>
                  <s.Trigger id="checkout-exp-month">
                    <s.Value @placeholder="MM">
                      {{#if state.expMonth}}
                        {{state.expMonth}}
                      {{/if}}
                    </s.Value>
                  </s.Trigger>
                  <s.Content as |c|>
                    <c.Item @value="01">01</c.Item>
                    <c.Item @value="02">02</c.Item>
                    <c.Item @value="03">03</c.Item>
                    <c.Item @value="04">04</c.Item>
                    <c.Item @value="05">05</c.Item>
                    <c.Item @value="06">06</c.Item>
                    <c.Item @value="07">07</c.Item>
                    <c.Item @value="08">08</c.Item>
                    <c.Item @value="09">09</c.Item>
                    <c.Item @value="10">10</c.Item>
                    <c.Item @value="11">11</c.Item>
                    <c.Item @value="12">12</c.Item>
                  </s.Content>
                </Select>
              </Field>
              <Field>
                <FieldLabel @for="checkout-exp-year">
                  Year
                </FieldLabel>
                <Select @onValueChange={{state.selectYear}} as |s|>
                  <s.Trigger id="checkout-exp-year">
                    <s.Value @placeholder="YYYY">
                      {{#if state.expYear}}
                        {{state.expYear}}
                      {{/if}}
                    </s.Value>
                  </s.Trigger>
                  <s.Content as |c|>
                    <c.Item @value="2024">2024</c.Item>
                    <c.Item @value="2025">2025</c.Item>
                    <c.Item @value="2026">2026</c.Item>
                    <c.Item @value="2027">2027</c.Item>
                    <c.Item @value="2028">2028</c.Item>
                    <c.Item @value="2029">2029</c.Item>
                  </s.Content>
                </Select>
              </Field>
            </div>
          </FieldGroup>
        </FieldSet>
        <FieldSeparator />
        <FieldSet>
          <FieldLegend>Billing Address</FieldLegend>
          <FieldDescription>
            The billing address associated with your payment method
          </FieldDescription>
          <FieldGroup>
            <Field @orientation="horizontal">
              <Checkbox
                id="checkout-same-as-shipping"
                @checked={{state.sameAsShipping}}
                @onCheckedChange={{state.toggleSameAsShipping}}
              />
              <FieldLabel @for="checkout-same-as-shipping" @class="font-normal">
                Same as shipping address
              </FieldLabel>
            </Field>
          </FieldGroup>
        </FieldSet>
        <FieldSeparator />
        <FieldSet>
          <FieldGroup>
            <Field>
              <FieldLabel @for="checkout-optional-comments">
                Comments
              </FieldLabel>
              <Textarea
                id="checkout-optional-comments"
                placeholder="Add any additional comments"
                value={{state.comments}}
                {{on "input" state.updateComments}}
              />
            </Field>
          </FieldGroup>
        </FieldSet>
        <Field @orientation="horizontal">
          <Button type="submit">Submit</Button>
          <Button @variant="outline" type="button">
            Cancel
          </Button>
        </Field>
      </FieldGroup>
    </form>
  </div>
</template>
