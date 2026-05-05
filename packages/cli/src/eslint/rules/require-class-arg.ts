import type { Rule } from 'eslint'

const ERROR_MESSAGE =
  'Pass `@class` instead of `class` to component `{{componentName}}`. Using `class` passes it as a splattribute and bypasses class merging via `cn()`/`cva()`.'

/**
 * Known shadcn-ember component names that accept `@class`.
 */
const SHADCN_COMPONENTS = new Set([
  // accordion
  'Accordion', 'AccordionItem', 'AccordionTrigger', 'AccordionContent',
  // alert-dialog
  'AlertDialog', 'AlertDialogTrigger', 'AlertDialogOverlay', 'AlertDialogContent', 'AlertDialogHeader', 'AlertDialogFooter', 'AlertDialogTitle', 'AlertDialogDescription', 'AlertDialogAction', 'AlertDialogCancel',
  // alert
  'Alert', 'AlertTitle', 'AlertDescription',
  // aspect-ratio
  'AspectRatio',
  // avatar
  'Avatar', 'AvatarImage', 'AvatarFallback',
  // badge
  'Badge',
  // breadcrumb
  'Breadcrumb', 'BreadcrumbList', 'BreadcrumbItem', 'BreadcrumbLink', 'BreadcrumbPage', 'BreadcrumbSeparator', 'BreadcrumbEllipsis',
  // button-group
  'ButtonGroup', 'ButtonGroupText', 'ButtonGroupSeparator',
  // button
  'Button',
  // card
  'Card', 'CardHeader', 'CardTitle', 'CardDescription', 'CardAction', 'CardContent', 'CardFooter',
  // checkbox
  'Checkbox',
  // collapsible
  'CollapsibleTrigger', 'CollapsibleContent',
  // command
  'Command', 'CommandDialog', 'CommandInput', 'CommandList', 'CommandEmpty', 'CommandGroup', 'CommandItem', 'CommandShortcut', 'CommandSeparator',
  // context-menu
  'ContextMenuTrigger', 'ContextMenuGroup', 'ContextMenuRadioGroup', 'ContextMenuSubTrigger', 'ContextMenuSubContent', 'ContextMenuContent', 'ContextMenuItem', 'ContextMenuCheckboxItem', 'ContextMenuRadioItem', 'ContextMenuLabel', 'ContextMenuSeparator', 'ContextMenuShortcut',
  // dialog
  'Dialog', 'DialogTrigger', 'DialogOverlay', 'DialogContent', 'DialogHeader', 'DialogFooter', 'DialogTitle', 'DialogDescription', 'DialogClose',
  // dropdown-menu
  'DropdownMenuTrigger', 'DropdownMenuGroup', 'DropdownMenuRadioGroup', 'DropdownMenuSubTrigger', 'DropdownMenuSubContent', 'DropdownMenuContent', 'DropdownMenuItem', 'DropdownMenuCheckboxItem', 'DropdownMenuRadioItem', 'DropdownMenuLabel', 'DropdownMenuSeparator', 'DropdownMenuShortcut',
  // empty
  'Empty', 'EmptyHeader', 'EmptyMedia', 'EmptyTitle', 'EmptyDescription', 'EmptyContent',
  // field
  'FieldSet', 'FieldLegend', 'Field', 'FieldGroup', 'FieldContent', 'FieldLabel', 'FieldDescription', 'FieldSeparator', 'FieldError', 'FieldTitle',
  // hover-card
  'HoverCardTrigger', 'HoverCardContent',
  // input-group
  'InputGroup', 'InputGroupAddon', 'InputGroupButton', 'InputGroupText', 'InputGroupInput', 'InputGroupTextarea',
  // input-otp
  'InputOTP', 'InputOTPGroup', 'InputOTPSlot', 'InputOTPSeparator',
  // input
  'Input',
  // item
  'Item', 'ItemMedia', 'ItemContent', 'ItemActions', 'ItemGroup', 'ItemSeparator', 'ItemTitle', 'ItemDescription', 'ItemHeader', 'ItemFooter',
  // kbd
  'Kbd', 'KbdGroup',
  // label
  'Label',
  // native-select
  'NativeSelect', 'NativeSelectOptGroup',
  // pagination
  'Pagination', 'PaginationContent', 'PaginationItem', 'PaginationLink', 'PaginationPrevious', 'PaginationNext', 'PaginationEllipsis',
  // popover
  'PopoverTrigger', 'PopoverContent', 'PopoverAnchor',
  // progress
  'Progress',
  // radio-group
  'RadioGroup', 'RadioGroupItem',
  // scroll-area
  'ScrollArea', 'ScrollBar',
  // select
  'SelectTrigger', 'SelectValue', 'SelectContent', 'SelectGroup', 'SelectLabel', 'SelectItem', 'SelectSeparator', 'SelectScrollUpButton', 'SelectScrollDownButton',
  // separator
  'Separator',
  // sheet
  'SheetTrigger', 'SheetClose', 'SheetOverlay', 'SheetContent', 'SheetHeader', 'SheetFooter', 'SheetTitle', 'SheetDescription',
  // sidebar
  'SidebarProvider', 'Sidebar', 'SidebarTrigger', 'SidebarRail', 'SidebarInset', 'SidebarInput', 'SidebarHeader', 'SidebarFooter', 'SidebarSeparator', 'SidebarContent', 'SidebarGroup', 'SidebarGroupLabel', 'SidebarGroupAction', 'SidebarGroupContent', 'SidebarMenu', 'SidebarMenuItem', 'SidebarMenuButton', 'SidebarMenuAction', 'SidebarMenuBadge', 'SidebarMenuSkeleton', 'SidebarMenuSub', 'SidebarMenuSubItem', 'SidebarMenuSubButton',
  // skeleton
  'Skeleton',
  // slider
  'Slider',
  // sonner
  'Toaster',
  // spinner
  'Spinner',
  // switch
  'Switch',
  // table
  'Table', 'TableHeader', 'TableBody', 'TableFooter', 'TableRow', 'TableHead', 'TableCell', 'TableCaption',
  // tabs
  'Tabs', 'TabsList', 'TabsTrigger', 'TabsContent',
  // textarea
  'Textarea',
  // toggle-group
  'ToggleGroup', 'ToggleGroupItem',
  // toggle
  'Toggle',
  // tooltip
  'TooltipTrigger', 'TooltipContent',
])

function isShadcnComponent(tag: string): boolean {
  return SHADCN_COMPONENTS.has(tag)
}

const rule: Rule.RuleModule = {
  meta: {
    type: 'problem',
    docs: {
      description:
        'require using `@class` instead of `class` on component invocations to ensure proper class merging',
      category: 'Best Practices',
      url: 'https://github.com/IgnaceMaes/shadcn-ember/blob/main/packages/cli/docs/rules/require-class-arg.md',
    },
    fixable: 'code',
    schema: [],
    messages: {
      requireClassArg: ERROR_MESSAGE,
    },
  },

  create(context) {
    return {
      GlimmerElementNode(node: Rule.Node & { tag: string; attributes: Array<{ name: string; range: [number, number] }> }) {
        if (!isShadcnComponent(node.tag)) {
          return
        }

        for (const attr of node.attributes ?? []) {
          if (attr.name === 'class') {
            context.report({
              node: attr as unknown as Rule.Node,
              messageId: 'requireClassArg',
              data: { componentName: node.tag },
              fix(fixer) {
                // Replace 'class' with '@class' in the attribute name
                // The attribute range starts at the attribute name
                const sourceCode = context.sourceCode
                const attrText = sourceCode.getText(attr as unknown as Rule.Node)
                const newText = attrText.replace(/^class/, '@class')
                return fixer.replaceTextRange(attr.range, newText)
              },
            })
          }
        }
      },
    }
  },
}

export default rule
