import {
  Field,
  FieldContent,
  FieldDescription,
  FieldGroup,
  FieldLabel,
  FieldSet,
  FieldTitle,
} from '@/components/ui/field';
import { RadioGroup } from '@/components/ui/radio-group';

<template>
  <div class="w-full max-w-md">
    <FieldGroup>
      <FieldSet>
        <FieldLabel @for="compute-environment">
          Compute Environment
        </FieldLabel>
        <FieldDescription>
          Select the compute environment for your cluster.
        </FieldDescription>
        <RadioGroup @defaultValue="kubernetes" as |r|>
          <FieldLabel @for="kubernetes-radio">
            <Field @orientation="horizontal">
              <FieldContent>
                <FieldTitle>Kubernetes</FieldTitle>
                <FieldDescription>
                  Run GPU workloads on a K8s configured cluster.
                </FieldDescription>
              </FieldContent>
              <r.Item @value="kubernetes" id="kubernetes-radio" />
            </Field>
          </FieldLabel>
          <FieldLabel @for="vm-radio">
            <Field @orientation="horizontal">
              <FieldContent>
                <FieldTitle>Virtual Machine</FieldTitle>
                <FieldDescription>
                  Access a VM configured cluster to run GPU workloads.
                </FieldDescription>
              </FieldContent>
              <r.Item @value="vm" id="vm-radio" />
            </Field>
          </FieldLabel>
        </RadioGroup>
      </FieldSet>
    </FieldGroup>
  </div>
</template>
