import type { TOC } from '@ember/component/template-only';
import { cn } from '@/lib/utils';

// Table Root Component
interface TableSignature {
  Element: HTMLTableElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const Table: TOC<TableSignature> = <template>
  <div class="relative w-full overflow-auto">
    <table class={{cn "w-full caption-bottom text-sm" @class}} ...attributes>
      {{yield}}
    </table>
  </div>
</template>;

// TableHeader Component
interface TableHeaderSignature {
  Element: HTMLTableSectionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const TableHeader: TOC<TableHeaderSignature> = <template>
  <thead class={{cn "[&_tr]:border-b" @class}} ...attributes>
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

export const TableBody: TOC<TableBodySignature> = <template>
  <tbody class={{cn "[&_tr:last-child]:border-0" @class}} ...attributes>
    {{yield}}
  </tbody>
</template>;

// TableFooter Component
interface TableFooterSignature {
  Element: HTMLTableSectionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const TableFooter: TOC<TableFooterSignature> = <template>
  <tfoot
    class={{cn
      "border-t bg-muted/50 font-medium [&>tr]:last:border-b-0"
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

export const TableRow: TOC<TableRowSignature> = <template>
  <tr
    class={{cn
      "border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </tr>
</template>;

// TableHead Component
interface TableHeadSignature {
  Element: HTMLTableCellElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const TableHead: TOC<TableHeadSignature> = <template>
  <th
    class={{cn
      "h-10 px-2 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </th>
</template>;

// TableCell Component
interface TableCellSignature {
  Element: HTMLTableCellElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const TableCell: TOC<TableCellSignature> = <template>
  <td
    class={{cn
      "p-2 align-middle [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]"
      @class
    }}
    ...attributes
  >
    {{yield}}
  </td>
</template>;

// TableCaption Component
interface TableCaptionSignature {
  Element: HTMLTableCaptionElement;
  Args: {
    class?: string;
  };
  Blocks: {
    default: [];
  };
}

export const TableCaption: TOC<TableCaptionSignature> = <template>
  <caption
    class={{cn "mt-4 text-sm text-muted-foreground" @class}}
    ...attributes
  >
    {{yield}}
  </caption>
</template>;

export default Table;
