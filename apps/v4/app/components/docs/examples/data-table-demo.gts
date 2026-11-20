import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { cached, tracked } from '@glimmer/tracking';
import {
  createTable,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  type ColumnDef,
  type ColumnFiltersState,
  type RowSelectionState,
  type SortingState,
  type Updater,
  type VisibilityState,
} from '@tanstack/table-core';

import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';

import ArrowUpDown from '~icons/lucide/arrow-up-down';
import ChevronDown from '~icons/lucide/chevron-down';
import Ellipsis from '~icons/lucide/ellipsis';

type Payment = {
  id: string;
  amount: number;
  status: 'pending' | 'processing' | 'success' | 'failed';
  email: string;
};

const data: Payment[] = [
  {
    id: 'm5gr84i9',
    amount: 316,
    status: 'success',
    email: 'ken99@example.com',
  },
  {
    id: '3u1reuv4',
    amount: 242,
    status: 'success',
    email: 'Abe45@example.com',
  },
  {
    id: 'derv1ws0',
    amount: 837,
    status: 'processing',
    email: 'Monserrat44@example.com',
  },
  {
    id: '5kma53ae',
    amount: 874,
    status: 'success',
    email: 'Silas22@example.com',
  },
  {
    id: 'bhqecj4p',
    amount: 721,
    status: 'failed',
    email: 'carmella@example.com',
  },
];

// Template helpers
const eq = (a: unknown, b: unknown) => a === b;
const not = (a: unknown) => !a;

// Typed helpers to bridge TanStack Table API with Glimmer templates
interface TableCellRef {
  id: string;
  column: { id: string };
  getValue: () => unknown;
}

const cellValue = (cell: TableCellRef): string => cell.getValue() as string;

const cellAmount = (cell: TableCellRef): string =>
  new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(Number(cell.getValue()));

const rowSelected = (row: { getIsSelected: () => boolean }): boolean =>
  row.getIsSelected();

const rowCells = (row: {
  getVisibleCells: () => TableCellRef[];
}): TableCellRef[] => row.getVisibleCells();

const colVisible = (col: { getIsVisible: () => boolean }): boolean =>
  col.getIsVisible();

const headerLabel = (header: {
  column: { columnDef: { header?: unknown } };
}): string => (header.column.columnDef.header as string) ?? '';

function applyUpdater<T>(updater: Updater<T>, old: T): T {
  return typeof updater === 'function'
    ? (updater as (old: T) => T)(old)
    : updater;
}

class DataTableDemo extends Component {
  @tracked sorting: SortingState = [];
  @tracked columnFilters: ColumnFiltersState = [];
  @tracked columnVisibility: VisibilityState = {};
  @tracked rowSelection: RowSelectionState = {};

  columns: ColumnDef<Payment, unknown>[] = [
    {
      id: 'select',
      enableSorting: false,
      enableHiding: false,
    },
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
    {
      id: 'actions',
      enableHiding: false,
    },
  ];

  handleSortingChange = (updater: Updater<SortingState>) => {
    this.sorting = applyUpdater(updater, this.sorting);
  };

  handleColumnFiltersChange = (updater: Updater<ColumnFiltersState>) => {
    this.columnFilters = applyUpdater(updater, this.columnFilters);
  };

  handleColumnVisibilityChange = (updater: Updater<VisibilityState>) => {
    this.columnVisibility = applyUpdater(updater, this.columnVisibility);
  };

  handleRowSelectionChange = (updater: Updater<RowSelectionState>) => {
    this.rowSelection = applyUpdater(updater, this.rowSelection);
  };

  @cached
  get table() {
    const options = {
      data,
      columns: this.columns,
      state: {
        sorting: this.sorting,
        columnFilters: this.columnFilters,
        columnVisibility: this.columnVisibility,
        rowSelection: this.rowSelection,
      },
      enableRowSelection: true,
      onSortingChange: this.handleSortingChange,
      onColumnFiltersChange: this.handleColumnFiltersChange,
      onColumnVisibilityChange: this.handleColumnVisibilityChange,
      onRowSelectionChange: this.handleRowSelectionChange,
      getCoreRowModel: getCoreRowModel(),
      getFilteredRowModel: getFilteredRowModel(),
      getPaginationRowModel: getPaginationRowModel(),
      getSortedRowModel: getSortedRowModel(),
      onStateChange: () => {},
      renderFallbackValue: '',
    };

    const table = createTable<Payment>(options);

    // Merge initialState (which includes defaults for all features like
    // column pinning) with our tracked state — this is what framework
    // adapters (useReactTable, createSolidTable, etc.) do internally.
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

  get emailFilterValue(): string {
    return (this.table.getColumn('email')?.getFilterValue() as string) ?? '';
  }

  get headerGroups() {
    return this.table.getHeaderGroups();
  }

  get rows() {
    return this.table.getRowModel().rows;
  }

  get hasRows() {
    return this.rows.length > 0;
  }

  get columnCount() {
    return this.columns.length;
  }

  get selectedRowCount() {
    return this.table.getFilteredSelectedRowModel().rows.length;
  }

  get totalRowCount() {
    return this.table.getFilteredRowModel().rows.length;
  }

  get canPreviousPage() {
    return this.table.getCanPreviousPage();
  }

  get canNextPage() {
    return this.table.getCanNextPage();
  }

  get hidableColumns() {
    return this.table.getAllColumns().filter((column) => column.getCanHide());
  }

  get isAllPageRowsSelected() {
    return this.table.getIsAllPageRowsSelected();
  }

  updateEmailFilter = (event: Event) => {
    const value = (event.target as HTMLInputElement).value;
    this.table.getColumn('email')?.setFilterValue(value);
  };

  toggleEmailSorting = () => {
    const column = this.table.getColumn('email');
    column?.toggleSorting(column.getIsSorted() === 'asc');
  };

  toggleAllPageRowsSelected = (value: boolean) => {
    this.table.toggleAllPageRowsSelected(value);
  };

  toggleRow = (_row: unknown, value: boolean) => {
    const row = _row as ReturnType<
      typeof this.table.getRowModel
    >['rows'][number];
    row.toggleSelected(value);
  };

  previousPage = () => {
    this.table.previousPage();
  };

  nextPage = () => {
    this.table.nextPage();
  };

  toggleColumnVisibility = (columnId: string, value: boolean) => {
    this.table.getColumn(columnId)?.toggleVisibility(value);
  };

  copyPaymentId = (id: string) => {
    void navigator.clipboard.writeText(id);
  };

  <template>
    <div class="w-full">
      <div class="flex items-center py-4">
        <Input
          @class="max-w-sm"
          placeholder="Filter emails..."
          value={{this.emailFilterValue}}
          {{on "input" this.updateEmailFilter}}
        />
        <DropdownMenu>
          <DropdownMenuTrigger @asChild={{true}} as |trigger|>
            <Button @class="ml-auto" @variant="outline" {{trigger.modifiers}}>
              Columns
              <ChevronDown class="ml-2 h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent @align="end">
            {{#each this.hidableColumns as |column|}}
              <DropdownMenuCheckboxItem
                @checked={{colVisible column}}
                @class="capitalize"
                @onCheckedChange={{fn this.toggleColumnVisibility column.id}}
              >
                {{column.id}}
              </DropdownMenuCheckboxItem>
            {{/each}}
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
      <div class="overflow-hidden rounded-md border">
        <Table>
          <TableHeader>
            {{#each this.headerGroups as |headerGroup|}}
              <TableRow>
                {{#each headerGroup.headers as |header|}}
                  <TableHead>
                    {{#unless header.isPlaceholder}}
                      {{#if (eq header.column.id "select")}}
                        <Checkbox
                          @checked={{this.isAllPageRowsSelected}}
                          @onCheckedChange={{this.toggleAllPageRowsSelected}}
                          aria-label="Select all"
                        />
                      {{else if (eq header.column.id "email")}}
                        <Button
                          @variant="ghost"
                          {{on "click" this.toggleEmailSorting}}
                        >
                          Email
                          <ArrowUpDown class="ml-2 h-4 w-4" />
                        </Button>
                      {{else if (eq header.column.id "amount")}}
                        <div class="text-right">Amount</div>
                      {{else if (eq header.column.id "actions")}}
                        {{! empty header for actions }}
                      {{else}}
                        {{headerLabel header}}
                      {{/if}}
                    {{/unless}}
                  </TableHead>
                {{/each}}
              </TableRow>
            {{/each}}
          </TableHeader>
          <TableBody>
            {{#if this.hasRows}}
              {{#each this.rows as |row|}}
                <TableRow data-state={{if (rowSelected row) "selected"}}>
                  {{#each (rowCells row) as |cell|}}
                    <TableCell>
                      {{#if (eq cell.column.id "select")}}
                        <Checkbox
                          @checked={{rowSelected row}}
                          @onCheckedChange={{fn this.toggleRow row}}
                          aria-label="Select row"
                        />
                      {{else if (eq cell.column.id "status")}}
                        <div class="capitalize">{{cellValue cell}}</div>
                      {{else if (eq cell.column.id "email")}}
                        <div class="lowercase">{{cellValue cell}}</div>
                      {{else if (eq cell.column.id "amount")}}
                        <div class="text-right font-medium">
                          {{cellAmount cell}}
                        </div>
                      {{else if (eq cell.column.id "actions")}}
                        <DropdownMenu>
                          <DropdownMenuTrigger @asChild={{true}} as |trigger|>
                            <Button
                              @class="h-8 w-8 p-0"
                              @variant="ghost"
                              {{trigger.modifiers}}
                            >
                              <span class="sr-only">Open menu</span>
                              <Ellipsis class="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent @align="end">
                            <DropdownMenuLabel>Actions</DropdownMenuLabel>
                            <DropdownMenuItem
                              @onSelect={{fn
                                this.copyPaymentId
                                row.original.id
                              }}
                            >
                              Copy payment ID
                            </DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem>
                              View customer
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                              View payment details
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      {{/if}}
                    </TableCell>
                  {{/each}}
                </TableRow>
              {{/each}}
            {{else}}
              <TableRow>
                <TableCell
                  @class="h-24 text-center"
                  colspan={{this.columnCount}}
                >
                  No results.
                </TableCell>
              </TableRow>
            {{/if}}
          </TableBody>
        </Table>
      </div>
      <div class="flex items-center justify-end space-x-2 py-4">
        <div class="flex-1 text-sm text-muted-foreground">
          {{this.selectedRowCount}}
          of
          {{this.totalRowCount}}
          row(s) selected.
        </div>
        <div class="space-x-2">
          <Button
            @disabled={{not this.canPreviousPage}}
            @size="sm"
            @variant="outline"
            {{on "click" this.previousPage}}
          >
            Previous
          </Button>
          <Button
            @disabled={{not this.canNextPage}}
            @size="sm"
            @variant="outline"
            {{on "click" this.nextPage}}
          >
            Next
          </Button>
        </div>
      </div>
    </div>
  </template>
}

export default DataTableDemo;
