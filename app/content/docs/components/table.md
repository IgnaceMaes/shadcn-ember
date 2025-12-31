---
title: Table
description: A responsive table component.
---

<ComponentPreview name="table-demo" description="A table component." />

## Installation

### CLI

```bash
npx embercli-shadcn@latest add table
```

### Manual

**Copy and paste the table component into your project:**

<ComponentSource name="table" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
```

```hbs showLineNumbers
<Table>
  <TableCaption>A list of your recent invoices.</TableCaption>
  <TableHeader>
    <TableRow>
      <TableHead @class="w-[100px]">Invoice</TableHead>
      <TableHead>Status</TableHead>
      <TableHead>Method</TableHead>
      <TableHead @class="text-right">Amount</TableHead>
    </TableRow>
  </TableHeader>
  <TableBody>
    <TableRow>
      <TableCell @class="font-medium">INV001</TableCell>
      <TableCell>Paid</TableCell>
      <TableCell>Credit Card</TableCell>
      <TableCell @class="text-right">$250.00</TableCell>
    </TableRow>
  </TableBody>
</Table>
```
