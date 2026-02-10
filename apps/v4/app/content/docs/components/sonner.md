---
title: Sonner
description: An opinionated toast component for Ember.
---

<ComponentPreview name="sonner-demo" />

## About

The Sonner component uses [ember-cli-flash](https://github.com/poteto/ember-cli-flash) to manage flash messages and renders them as styled toasts.

## Installation

### CLI

```bash
npx shadcn-ember@latest add sonner
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-cli-flash
```

**Copy and paste the sonner component into your project:**

<ComponentSource name="sonner" />

**Update the import paths to match your project setup.**

The installation also includes a custom `flash-messages` service that overrides the default flash message type from `"info"` to `"default"`. This ensures that `flashMessages.add()` creates plain toasts without icons, matching the original sonner behavior where only `toast.success()`, `toast.info()`, etc. show icons.

**Add the Toaster component to your application template:**

```gts showLineNumbers title="app/templates/application.gts" {1,5}
import { Toaster } from '@/components/ui/sonner';

<template>
  {{outlet}}
  <Toaster />
</template>
```

## Usage

```gts showLineNumbers
import { Toaster } from '@/components/ui/sonner';
```

```hbs showLineNumbers
<Toaster />
```

To show a toast, inject the `flashMessages` service and call one of its methods:

```gts showLineNumbers
import { service } from '@ember/service';
import type { FlashMessagesService } from 'ember-cli-flash';

class MyComponent extends Component {
  @service declare flashMessages: FlashMessagesService;

  showToast = () => {
    this.flashMessages.add({
      message: 'Event has been created.',
    });
  };
}
```

## Examples

### Types

<ComponentPreview name="sonner-types" />

### Description

<ComponentPreview name="sonner-description" />

### Position

Use the `@position` arg to change the position of the toaster.

<ComponentPreview name="sonner-position" />

## API Reference

| Arg           | Type                                                                                              | Default          | Description                                              |
| ------------- | ------------------------------------------------------------------------------------------------- | ---------------- | -------------------------------------------------------- |
| `@position`   | `'top-left' \| 'top-center' \| 'top-right' \| 'bottom-left' \| 'bottom-center' \| 'bottom-right'` | `'bottom-right'` | Position of the toaster on the screen.                   |
| `@richColors` | `boolean`                                                                                         | `false`          | When `true`, applies colored backgrounds per toast type. |
| `@class`      | `string`                                                                                          | —                | Additional CSS classes for the toaster container.        |
