---
title: Avatar
description: An image element with a fallback for representing the user.
order: 110
---

<ComponentPreview name="avatar-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add avatar
```

### Manual

**Copy and paste the avatar component into your project:**

<ComponentSource name="avatar" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from '@/components/ui/avatar';
```

```hbs showLineNumbers
<Avatar>
  <AvatarImage @src="https://github.com/shadcn.png" @alt="@shadcn" />
  <AvatarFallback>CN</AvatarFallback>
</Avatar>
```
