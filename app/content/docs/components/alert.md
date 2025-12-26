---
title: Alert
description: Displays a callout for user attention.
---

<ComponentPreview name="alert-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add alert
```

### Manual

**Copy and paste the alert component into your project:**

<ComponentSource name="alert" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
```

```hbs showLineNumbers
<Alert @variant="default">
  <Terminal />
  <AlertTitle>Heads up!</AlertTitle>
  <AlertDescription>
    You can add components and dependencies to your app using the cli.
  </AlertDescription>
</Alert>
```
