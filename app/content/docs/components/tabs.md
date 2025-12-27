---
title: Tabs
description: A set of layered sections of content—known as tab panels—that are displayed one at a time.
---

<ComponentPreview name="tabs-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add tabs
```

### Manual

**Copy and paste the tabs component into your project:**

<ComponentSource name="tabs" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';
```

```hbs showLineNumbers
<Tabs @defaultValue="account" @class="w-[400px]" as |t|>
  <t.List>
    <t.Trigger @value="account">Account</t.Trigger>
    <t.Trigger @value="password">Password</t.Trigger>
  </t.List>
  <t.Content @value="account">Make changes to your account here.</t.Content>
  <t.Content @value="password">Change your password here.</t.Content>
</Tabs>
```
