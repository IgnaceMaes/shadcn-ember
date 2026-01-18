---
title: Input OTP
description: Accessible one-time password component with copy paste functionality.
---

<ComponentPreview name="input-otp-demo" description="A 6 digit input OTP." />

## Installation

### CLI

```bash
npx shadcn-ember@latest add input-otp
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-provide-consume-context
```

**Copy and paste the input-otp component into your project:**

<ComponentSource name="input-otp" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  InputOTP,
  InputOTPGroup,
  InputOTPSeparator,
  InputOTPSlot,
} from '@/components/ui/input-otp';
```

```hbs showLineNumbers
<InputOTP @maxLength={{6}}>
  <InputOTPGroup>
    <InputOTPSlot @index={{0}} />
    <InputOTPSlot @index={{1}} />
    <InputOTPSlot @index={{2}} />
  </InputOTPGroup>
  <InputOTPSeparator />
  <InputOTPGroup>
    <InputOTPSlot @index={{3}} />
    <InputOTPSlot @index={{4}} />
    <InputOTPSlot @index={{5}} />
  </InputOTPGroup>
</InputOTP>
```

## Examples

### Pattern

Use a custom pattern to validate the OTP input.

<ComponentPreview
  name="input-otp-pattern"
  description="An input OTP with alphanumeric pattern."
/>

The component uses a built-in pattern that only allows alphanumeric characters (letters and numbers).

### Separator

You can use the `<InputOTPSeparator />` component to add a separator between the input groups.

<ComponentPreview
  name="input-otp-separator"
  description="An input OTP with custom separator."
/>

```gts showLineNumbers {4,15}
import {
  InputOTP,
  InputOTPGroup,
  InputOTPSeparator,
  InputOTPSlot,
} from '@/components/ui/input-otp';

<template>
  <InputOTP @maxLength={{4}}>
    <InputOTPGroup>
      <InputOTPSlot @index={{0}} />
      <InputOTPSlot @index={{1}} />
    </InputOTPGroup>
    <InputOTPSeparator />
    <InputOTPGroup>
      <InputOTPSlot @index={{2}} />
      <InputOTPSlot @index={{3}} />
    </InputOTPGroup>
  </InputOTP>
</template>
```

### Controlled

You can use the `@value` and `@onValueChange` arguments to control the input value.

<ComponentPreview name="input-otp-controlled" />

### Form

<ComponentPreview name="input-otp-form" />
