---
title: Card
description: Displays a card with header, content, and footer.
---

<ComponentPreview name="card-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add card
```

### Manual

**Copy and paste the card component into your project:**

<ComponentSource name="card" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
```

```hbs showLineNumbers
<Card>
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card Description</CardDescription>
    <CardAction>Card Action</CardAction>
  </CardHeader>
  <CardContent>
    <p>Card Content</p>
  </CardContent>
  <CardFooter>
    <p>Card Footer</p>
  </CardFooter>
</Card>
```
