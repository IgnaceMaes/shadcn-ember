import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

interface TableSignature {
  Element: HTMLTableElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const Table: TOC<TableSignature> = <template>
  <div data-slot="table-container" class="relative w-full overflow-x-auto">
    <table
      data-slot="table"
      class={{cn "w-full caption-bottom text-sm" @class}}
      ...attributes
    >
      {{yield}}
    </table>
  </div>
</template>;

interface TableHeaderSignature {
  Element: HTMLTableSectionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableHeader: TOC<TableHeaderSignature> = <template>
  <thead
    data-slot="table-header"
    class={{cn "[&_tr]:border-b" @class}}
    ...attributes
  >
    {{yield}}
  </thead>
</template>;

// TableBody Component
interface TableBodySignature {
  Element: HTMLTableSectionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableBody: TOC<TableBodySignature> = <template>
  <tbody
    data-slot="table-body"
    class={{cn "[&_tr:last-child]:border-0" @class}}
    ...attributes
  >
    {{yield}}
  </tbody>
</template>;

interface TableFooterSignature {
  Element: HTMLTableSectionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableFooter: TOC<TableFooterSignature> = <template>
  <tfoot
    data-slot="table-footer"
    class={{cn
      "bg-muted/50 border-t font-medium [&>tr]:last:border-b-0"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </tfoot>
</template>;

// TableRow Component
interface TableRowSignature {
  Element: HTMLTableRowElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableRow: TOC<TableRowSignature> = <template>
  <tr
    data-slot="table-row"
    class={{cn
      "hover:bg-muted/50 data-[state=selected]:bg-muted border-b transition-colors"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </tr>
</template>;

interface TableHeadSignature {
  Element: HTMLTableCellElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableHead: TOC<TableHeadSignature> = <template>
  <th
    data-slot="table-head"
    class={{cn
      "text-foreground h-10 px-2 text-left align-middle font-medium whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </th>
</template>;

interface TableCellSignature {
  Element: HTMLTableCellElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableCell: TOC<TableCellSignature> = <template>
  <td
    data-slot="table-cell"
    class={{cn
      "p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </td>
</template>;

interface TableCaptionSignature {
  Element: HTMLTableCaptionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

const TableCaption: TOC<TableCaptionSignature> = <template>
  <caption
    data-slot="table-caption"
    class={{cn "text-muted-foreground mt-4 text-sm" @class}}
    ...attributes
  >
    {{yield}}
  </caption>
</template>;

export {
  Table,
  TableHeader,
  TableBody,
  TableFooter,
  TableRow,
  TableHead,
  TableCell,
  TableCaption,
};
