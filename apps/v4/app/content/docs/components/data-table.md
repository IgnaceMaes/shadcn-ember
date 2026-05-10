---
title: Data Table
description: Powerful table and datagrids built using TanStack Table.
---

<ComponentPreview name="data-table-demo" description="A data table component with sorting, filtering, pagination, and row selection." />

## Introduction

Every data table or datagrid I've created has been unique. They all behave differently, have specific sorting and filtering requirements, and work with different data sources.

It doesn't make sense to combine all of these variations into a single component. If we do that, we'll lose the flexibility that [headless UI](https://tanstack.com/table/v8/docs/introduction#what-is-headless-ui) provides.

So instead of a data-table component, I thought it would be more helpful to provide a guide on how to build your own.

We'll start with the basic `<Table />` component and build a complex data table from scratch.

> **Tip:** If you find yourself using the same table in multiple places in your app, you can always extract it into a reusable component.

## Table of Contents

This guide will show you how to use [TanStack Table](https://tanstack.com/table) and the `<Table />` component to build your own custom data table. We'll cover the following topics:

- [Basic Table](#basic-table)
- [Row Actions](#row-actions)
- [Pagination](#pagination)
- [Sorting](#sorting)
- [Filtering](#filtering)
- [Visibility](#visibility)
- [Row Selection](#row-selection)

## Installation

1. Add the `<Table />` component to your project:

```bash
npx shadcn-ember@latest add table
```

2. Add `@tanstack/table-core` dependency:

```bash
pnpm add @tanstack/table-core
```

## Prerequisites

We are going to build a table to show recent payments. Here's what our data looks like:

```ts showLineNumbers
type Payment = {
  id: string
  amount: number
  status: 'pending' | 'processing' | 'success' | 'failed'
  email: string
}

const payments: Payment[] = [
  {
    id: '728ed52f',
    amount: 100,
    status: 'pending',
    email: 'm@example.com',
  },
  {
    id: '489e1d42',
    amount: 125,
    status: 'processing',
    email: 'example@gmail.com',
  },
  // ...
]
```

## Project Structure

Start by creating the following file structure:

```txt
app
└── components
    └── payments-table.gts
```

In Ember, we'll build the data table as a single Glimmer component that handles column definitions, table state, and rendering.

## TanStack Table in Ember

Since TanStack Table is framework-agnostic at its core, we use `@tanstack/table-core` directly with Glimmer's `@tracked` for reactivity. The key pattern is:

1. Store table state in `@tracked` properties
2. Use a `@cached` getter to create the table instance
3. Handle state updates through TanStack Table's callback options

```gts showLineNumbers
import { cached, tracked } from '@glimmer/tracking';
import {
  createTable,
  getCoreRowModel,
  type SortingState,
  type Updater,
} from '@tanstack/table-core';

function applyUpdater<T>(updater: Updater<T>, old: T): T {
  return typeof updater === 'function'
    ? (updater as (old: T) => T)(old)
    : updater;
}

class MyTable extends Component {
  @tracked sorting: SortingState = [];

  @cached
  get table() {
    const options = {
      data: this.data,
      columns: this.columns,
      state: { sorting: this.sorting },
      onSortingChange: (updater) => {
        this.sorting = applyUpdater(updater, this.sorting);
      },
      getCoreRowModel: getCoreRowModel(),
      onStateChange: () => {},
      renderFallbackValue: '',
    };

    const table = createTable(options);

    // Merge initialState with our tracked state — this is what
    // framework adapters (useReactTable, etc.) do internally.
    table.setOptions((prev) => ({
      ...prev,
      ...options,
      state: {
        ...table.initialState,
        ...options.state,
      },
    }));

    return table;
  }
}
```

> **Note:** We use `@cached` to memoize the table instance per render cycle. The `table.setOptions` call merges `table.initialState` (which includes defaults for all features like column pinning) with our tracked state. The `onStateChange` and `renderFallbackValue` options are required by `createTable` but can be set to no-ops when using individual state handlers.

## Calling TanStack Table Methods in Templates

TanStack Table exposes methods like `cell.getValue()`, `row.getIsSelected()`, and `row.getVisibleCells()` on its objects. Since Glimmer templates can't call methods directly with parentheses, we use a simple `call` helper:

```gts showLineNumbers
const call = <T>(fn: () => T): T => fn();
```

Then in templates:

```hbs showLineNumbers
{{! Call a method on a TanStack Table object }}
{{call cell.getValue}}

{{! Use in sub-expressions }}
{{#each (call row.getVisibleCells) as |cell|}}
  ...
{{/each}}

{{! Use in conditionals }}
{{#if (call row.getIsSelected)}}
  ...
{{/if}}
```

This works because TanStack Table methods are arrow functions (closures) stored as properties, so they retain their context when accessed without parentheses.

## Basic Table

Let's start by building a basic table.

### Column Definitions

First, we'll define our columns using TanStack Table's `ColumnDef` type:

```gts showLineNumbers
import { type ColumnDef } from '@tanstack/table-core';

type Payment = {
  id: string
  amount: number
  status: 'pending' | 'processing' | 'success' | 'failed'
  email: string
}

const columns: ColumnDef<Payment, unknown>[] = [
  {
    accessorKey: 'status',
    header: 'Status',
  },
  {
    accessorKey: 'email',
    header: 'Email',
  },
  {
    accessorKey: 'amount',
    header: 'Amount',
  },
];
```

> **Note:** Columns are where you define the core of what your table will look like. They define the data that will be displayed, how it will be formatted, sorted and filtered.

### Building the Component

Next, we'll create a Glimmer component with the table instance and render it:

```gts showLineNumbers
import Component from '@glimmer/component';
import { cached } from '@glimmer/tracking';
import {
  createTable,
  getCoreRowModel,
  type ColumnDef,
} from '@tanstack/table-core';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';

const eq = (a: unknown, b: unknown) => a === b;
const call = <T>(fn: () => T): T => fn();

class PaymentsTable extends Component {
  columns: ColumnDef<Payment, unknown>[] = [
    { accessorKey: 'status', header: 'Status' },
    { accessorKey: 'email', header: 'Email' },
    { accessorKey: 'amount', header: 'Amount' },
  ];

  @cached
  get table() {
    const options = {
      data,
      columns: this.columns,
      getCoreRowModel: getCoreRowModel(),
      onStateChange: () => {},
      renderFallbackValue: '',
      state: {},
    };

    const table = createTable<Payment>(options);

    table.setOptions((prev) => ({
      ...prev,
      ...options,
      state: {
        ...table.initialState,
        ...options.state,
      },
    }));

    return table;
  }

  get headerGroups() {
    return this.table.getHeaderGroups();
  }

  get rows() {
    return this.table.getRowModel().rows;
  }

  <template>
    <div class="overflow-hidden rounded-md border">
      <Table>
        <TableHeader>
          {{#each this.headerGroups as |headerGroup|}}
            <TableRow>
              {{#each headerGroup.headers as |header|}}
                <TableHead>
                  {{#unless header.isPlaceholder}}
                    {{header.column.columnDef.header}}
                  {{/unless}}
                </TableHead>
              {{/each}}
            </TableRow>
          {{/each}}
        </TableHeader>
        <TableBody>
          {{#if this.rows.length}}
            {{#each this.rows as |row|}}
              <TableRow>
                {{#each (call row.getVisibleCells) as |cell|}}
                  <TableCell>
                    {{call cell.getValue}}
                  </TableCell>
                {{/each}}
              </TableRow>
            {{/each}}
          {{else}}
            <TableRow>
              <TableCell
                colspan={{this.columns.length}}
                @class="h-24 text-center"
              >
                No results.
              </TableCell>
            </TableRow>
          {{/if}}
        </TableBody>
      </Table>
    </div>
  </template>
}
```

> **Tip:** If you find yourself using this table in multiple places, you can extract it into a reusable component.

## Cell Formatting

Let's format the amount cell to display the dollar amount. We'll also align the cell to the right.

### Update the template

Use conditional rendering based on `cell.column.id` to format specific cells:

```gts showLineNumbers
function formatCurrency(value: number): string {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(value);
}

// In the template:
{{#each (call row.getVisibleCells) as |cell|}}
  <TableCell>
    {{#if (eq cell.column.id "amount")}}
      <div class="text-right font-medium">
        {{formatCurrency (call cell.getValue)}}
      </div>
    {{else}}
      {{call cell.getValue}}
    {{/if}}
  </TableCell>
{{/each}}
```

You can use the same approach to format other cells and headers.

## Row Actions

Let's add row actions to our table using a `<DropdownMenu />` component.

### Update column definitions and template

Add an `actions` column to your columns array and render a dropdown in the template:

```gts showLineNumbers
import { fn } from '@ember/helper';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Button } from '@/components/ui/button';
import Ellipsis from '~icons/lucide/ellipsis';

// Add to columns:
const columns: ColumnDef<Payment, unknown>[] = [
  // ...other columns
  {
    id: 'actions',
    enableHiding: false,
  },
];

// Add handler:
copyPaymentId = (id: string) => {
  void navigator.clipboard.writeText(id);
};

// In the template, inside the cell loop:
{{#if (eq cell.column.id "actions")}}
  <DropdownMenu>
    <DropdownMenuTrigger @asChild={{true}} as |trigger|>
      <Button @variant="ghost" @class="h-8 w-8 p-0" {{trigger.modifiers}}>
        <span class="sr-only">Open menu</span>
        <Ellipsis class="h-4 w-4" />
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent @align="end">
      <DropdownMenuLabel>Actions</DropdownMenuLabel>
      <DropdownMenuItem
        @onSelect={{fn this.copyPaymentId row.original.id}}
      >
        Copy payment ID
      </DropdownMenuItem>
      <DropdownMenuSeparator />
      <DropdownMenuItem>View customer</DropdownMenuItem>
      <DropdownMenuItem>View payment details</DropdownMenuItem>
    </DropdownMenuContent>
  </DropdownMenu>
{{/if}}
```

You can access the row data using `row.original` in the template to handle actions for your row.

## Pagination

Next, we'll add pagination to our table.

### Update the table instance

```gts showLineNumbers
import {
  createTable,
  getCoreRowModel,
  getPaginationRowModel,
} from '@tanstack/table-core';

@cached
get table() {
  return createTable<Payment>({
    data,
    columns: this.columns,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    onStateChange: () => {},
    renderFallbackValue: '',
    state: {},
  });
}
```

This will automatically paginate your rows into pages of 10. See the [pagination docs](https://tanstack.com/table/v8/docs/api/features/pagination) for more information on customizing page size.

### Add pagination controls

```hbs showLineNumbers
<div class="flex items-center justify-end space-x-2 py-4">
  <Button
    @variant="outline"
    @size="sm"
    @disabled={{not this.canPreviousPage}}
    {{on "click" this.previousPage}}
  >
    Previous
  </Button>
  <Button
    @variant="outline"
    @size="sm"
    @disabled={{not this.canNextPage}}
    {{on "click" this.nextPage}}
  >
    Next
  </Button>
</div>
```

```gts showLineNumbers
// In the component class:
const not = (a: unknown) => !a;

get canPreviousPage() {
  return this.table.getCanPreviousPage();
}

get canNextPage() {
  return this.table.getCanNextPage();
}

previousPage = () => {
  this.table.previousPage();
};

nextPage = () => {
  this.table.nextPage();
};
```

## Sorting

Let's make the email column sortable.

### Update the table instance

```gts showLineNumbers
import {
  createTable,
  getCoreRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  type SortingState,
} from '@tanstack/table-core';

class PaymentsTable extends Component {
  @tracked sorting: SortingState = [];

  @cached
  get table() {
    return createTable<Payment>({
      data,
      columns: this.columns,
      state: { sorting: this.sorting },
      onSortingChange: (updater) => {
        this.sorting = applyUpdater(updater, this.sorting);
      },
      getCoreRowModel: getCoreRowModel(),
      getPaginationRowModel: getPaginationRowModel(),
      getSortedRowModel: getSortedRowModel(),
      onStateChange: () => {},
      renderFallbackValue: '',
    });
  }
}
```

### Make header cell sortable

Add a button with a sort icon to the email header:

```gts showLineNumbers
import ArrowUpDown from '~icons/lucide/arrow-up-down';

// In the component class:
toggleEmailSorting = () => {
  const column = this.table.getColumn('email');
  column?.toggleSorting(column.getIsSorted() === 'asc');
};

// In the template header:
{{#if (eq header.column.id "email")}}
  <Button @variant="ghost" {{on "click" this.toggleEmailSorting}}>
    Email
    <ArrowUpDown class="ml-2 h-4 w-4" />
  </Button>
{{/if}}
```

This will automatically sort the table (asc and desc) when the user clicks on the header cell.

## Filtering

Let's add a search input to filter emails in our table.

### Update the table instance

```gts showLineNumbers
import {
  type ColumnFiltersState,
  getFilteredRowModel,
} from '@tanstack/table-core';
import { Input } from '@/components/ui/input';

class PaymentsTable extends Component {
  @tracked sorting: SortingState = [];
  @tracked columnFilters: ColumnFiltersState = [];

  @cached
  get table() {
    return createTable<Payment>({
      data,
      columns: this.columns,
      state: {
        sorting: this.sorting,
        columnFilters: this.columnFilters,
      },
      onSortingChange: (updater) => {
        this.sorting = applyUpdater(updater, this.sorting);
      },
      onColumnFiltersChange: (updater) => {
        this.columnFilters = applyUpdater(updater, this.columnFilters);
      },
      getCoreRowModel: getCoreRowModel(),
      getPaginationRowModel: getPaginationRowModel(),
      getSortedRowModel: getSortedRowModel(),
      getFilteredRowModel: getFilteredRowModel(),
      onStateChange: () => {},
      renderFallbackValue: '',
    });
  }

  get emailFilterValue(): string {
    return (
      (this.table.getColumn('email')?.getFilterValue() as string) ?? ''
    );
  }

  updateEmailFilter = (event: Event) => {
    const value = (event.target as HTMLInputElement).value;
    this.table.getColumn('email')?.setFilterValue(value);
  };
}
```

### Add filter input

```hbs showLineNumbers
<div class="flex items-center py-4">
  <Input
    placeholder="Filter emails..."
    value={{this.emailFilterValue}}
    @class="max-w-sm"
    {{on "input" this.updateEmailFilter}}
  />
</div>
```

Filtering is now enabled for the `email` column. You can add filters to other columns as well. See the [filtering docs](https://tanstack.com/table/v8/docs/guide/filters) for more information.

## Visibility

Adding column visibility is fairly simple using `@tanstack/table-core`'s visibility API.

### Update the table instance

```gts showLineNumbers
import { type VisibilityState } from '@tanstack/table-core';
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

class PaymentsTable extends Component {
  @tracked columnVisibility: VisibilityState = {};

  @cached
  get table() {
    return createTable<Payment>({
      // ...previous options
      state: {
        // ...previous state
        columnVisibility: this.columnVisibility,
      },
      onColumnVisibilityChange: (updater) => {
        this.columnVisibility = applyUpdater(
          updater,
          this.columnVisibility,
        );
      },
    });
  }

  get hidableColumns() {
    return this.table
      .getAllColumns()
      .filter((column) => column.getCanHide());
  }

  toggleColumnVisibility = (columnId: string, value: boolean) => {
    this.table.getColumn(columnId)?.toggleVisibility(value);
  };
}
```

### Add column visibility toggle

```hbs showLineNumbers
<DropdownMenu>
  <DropdownMenuTrigger @asChild={{true}} as |trigger|>
    <Button @variant="outline" @class="ml-auto" {{trigger.modifiers}}>
      Columns
      <ChevronDown class="ml-2 h-4 w-4" />
    </Button>
  </DropdownMenuTrigger>
  <DropdownMenuContent @align="end">
    {{#each this.hidableColumns as |column|}}
      <DropdownMenuCheckboxItem
        @checked={{call column.getIsVisible}}
        @onCheckedChange={{fn this.toggleColumnVisibility column.id}}
        @class="capitalize"
      >
        {{column.id}}
      </DropdownMenuCheckboxItem>
    {{/each}}
  </DropdownMenuContent>
</DropdownMenu>
```

This adds a dropdown menu that you can use to toggle column visibility.

## Row Selection

Next, we're going to add row selection to our table.

### Update column definitions

Add a `select` column with checkboxes:

```gts showLineNumbers
import { Checkbox } from '@/components/ui/checkbox';

const columns: ColumnDef<Payment, unknown>[] = [
  {
    id: 'select',
    enableSorting: false,
    enableHiding: false,
  },
  // ...other columns
];
```

### Update the table instance

```gts showLineNumbers
import { type RowSelectionState } from '@tanstack/table-core';

class PaymentsTable extends Component {
  @tracked rowSelection: RowSelectionState = {};

  @cached
  get table() {
    return createTable<Payment>({
      // ...previous options
      enableRowSelection: true,
      state: {
        // ...previous state
        rowSelection: this.rowSelection,
      },
      onRowSelectionChange: (updater) => {
        this.rowSelection = applyUpdater(updater, this.rowSelection);
      },
    });
  }

  get isAllPageRowsSelected() {
    return this.table.getIsAllPageRowsSelected();
  }

  toggleAllPageRowsSelected = (value: boolean) => {
    this.table.toggleAllPageRowsSelected(value);
  };

  toggleRow = (_row: unknown, value: boolean) => {
    const row = _row as ReturnType<
      typeof this.table.getRowModel
    >['rows'][number];
    row.toggleSelected(value);
  };
}
```

### Render checkboxes in the template

```hbs showLineNumbers
{{! Header checkbox }}
{{#if (eq header.column.id "select")}}
  <Checkbox
    @checked={{this.isAllPageRowsSelected}}
    @onCheckedChange={{this.toggleAllPageRowsSelected}}
    aria-label="Select all"
  />
{{/if}}

{{! Row checkbox }}
{{#if (eq cell.column.id "select")}}
  <Checkbox
    @checked={{call row.getIsSelected}}
    @onCheckedChange={{fn this.toggleRow row}}
    aria-label="Select row"
  />
{{/if}}
```

### Show selected rows

You can show the number of selected rows:

```hbs showLineNumbers
<div class="flex-1 text-sm text-muted-foreground">
  {{this.selectedRowCount}} of {{this.totalRowCount}} row(s) selected.
</div>
```

```gts showLineNumbers
get selectedRowCount() {
  return this.table.getFilteredSelectedRowModel().rows.length;
}

get totalRowCount() {
  return this.table.getFilteredRowModel().rows.length;
}
```
