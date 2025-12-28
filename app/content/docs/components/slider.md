---
title: Slider
description: An input where the user selects a value from within a given range.
---

<ComponentPreview name="slider-demo" />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add slider
```

### Manual

**Copy and paste the slider component into your project:**

<ComponentSource name="slider" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import { Slider } from '@/components/ui/slider';
```

```hbs showLineNumbers
<Slider @defaultValue={{array 33}} @max={{100}} @step={{1}} />
```
