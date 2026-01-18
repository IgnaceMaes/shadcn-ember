---
title: Tabs
description: A set of layered sections of content—known as tab panels—that are displayed one at a time.
---

<ComponentPreview name="tabs-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add tabs
```

### Manual

**Install the following dependencies:**

```bash
pnpm add ember-provide-consume-context
```

**Copy and paste the tabs component into your project:**

<ComponentSource name="tabs" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';
```

```hbs showLineNumbers
<Tabs @defaultValue="account" @class="w-[400px]">
  <TabsList>
    <TabsTrigger @value="account">Account</TabsTrigger>
    <TabsTrigger @value="password">Password</TabsTrigger>
  </TabsList>
  <TabsContent @value="account">Make changes to your account here.</TabsContent>
  <TabsContent @value="password">Change your password here.</TabsContent>
</Tabs>
```
