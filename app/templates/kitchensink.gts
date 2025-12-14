import { tracked } from '@glimmer/tracking';
import Component from '@glimmer/component';
import { fn, get, array } from '@ember/helper';
import { on } from '@ember/modifier';
import Button from '@/components/ui/button';
import {
  ButtonGroup,
  ButtonGroupSeparator,
  ButtonGroupText,
} from '@/components/ui/button-group';
import Switch from '@/components/ui/switch';
import Checkbox from '@/components/ui/checkbox';
import Label from '@/components/ui/label';
import Input from '@/components/ui/input';
import Textarea from '@/components/ui/textarea';
import Badge from '@/components/ui/badge';
import { Alert, AlertTitle, AlertDescription } from '@/components/ui/alert';
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectSeparator,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { Tabs } from '@/components/ui/tabs';
import Separator from '@/components/ui/separator';
import {
  Field,
  FieldLabel,
  FieldDescription,
  FieldError,
  FieldGroup,
  FieldContent,
  FieldSeparator,
} from '@/components/ui/field';
import {
  Accordion,
  AccordionItem,
  AccordionTrigger,
  AccordionContent,
} from '@/components/ui/accordion';
import { AspectRatio } from '@/components/ui/aspect-ratio';
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar';
import {
  Breadcrumb,
  BreadcrumbList,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbSeparator,
  BreadcrumbPage,
} from '@/components/ui/breadcrumb';
import {
  Collapsible,
  CollapsibleTrigger,
  CollapsibleContent,
} from '@/components/ui/collapsible';
import {
  Empty,
  EmptyHeader,
  EmptyTitle,
  EmptyDescription,
  EmptyMedia,
} from '@/components/ui/empty';
import { Kbd, KbdGroup } from '@/components/ui/kbd';
import { Progress } from '@/components/ui/progress';
import { Skeleton } from '@/components/ui/skeleton';
import { Spinner } from '@/components/ui/spinner';
import { Slider } from '@/components/ui/slider';
import Toggle from '@/components/ui/toggle';
import { ToggleGroup, ToggleGroupItem } from '@/components/ui/toggle-group';
import {
  Tooltip,
  TooltipTrigger,
  TooltipContent,
  TooltipProvider,
} from '@/components/ui/tooltip';
import {
  Popover,
  PopoverTrigger,
  PopoverContent,
} from '@/components/ui/popover';
import {
  HoverCard,
  HoverCardTrigger,
  HoverCardContent,
} from '@/components/ui/hover-card';
import {
  AlertDialog,
  AlertDialogTrigger,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogAction,
  AlertDialogCancel,
} from '@/components/ui/alert-dialog';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { ScrollArea } from '@/components/ui/scroll-area';
import {
  Sheet,
  SheetTrigger,
  SheetContent,
  SheetHeader,
  SheetTitle,
  SheetDescription,
} from '@/components/ui/sheet';
import {
  Table,
  TableHeader,
  TableBody,
  TableFooter,
  TableHead,
  TableRow,
  TableCell,
  TableCaption,
} from '@/components/ui/table';
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';
import {
  ContextMenu,
  ContextMenuTrigger,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuSeparator,
} from '@/components/ui/context-menu';
import {
  Menubar,
  MenubarMenu,
  MenubarTrigger,
  MenubarContent,
  MenubarItem,
  MenubarSeparator,
} from '@/components/ui/menubar';
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationPrevious,
  PaginationNext,
  PaginationEllipsis,
} from '@/components/ui/pagination';
// import PhHeart from 'ember-phosphor-icons/components/ph-heart';
// import PhTextB from 'ember-phosphor-icons/components/ph-text-b';
// import PhTextItalic from 'ember-phosphor-icons/components/ph-text-italic';
// import PhTextUnderline from 'ember-phosphor-icons/components/ph-text-underline';
// import PhInfo from 'ember-phosphor-icons/components/ph-info';
// import PhWarning from 'ember-phosphor-icons/components/ph-warning';
// import PhPlus from 'ember-phosphor-icons/components/ph-plus';
// import PhTrash from 'ember-phosphor-icons/components/ph-trash';
// import PhMinus from 'ember-phosphor-icons/components/ph-minus';
// import PhX from 'ember-phosphor-icons/components/ph-x';
import Heart from '~icons/lucide/heart';
import Bold from '~icons/lucide/bold';
import Italic from '~icons/lucide/italic';
import Underline from '~icons/lucide/underline';
import Info from '~icons/lucide/info';
import TriangleAlert from '~icons/lucide/triangle-alert';
import Plus from '~icons/lucide/plus';
import Trash2 from '~icons/lucide/trash-2';
import Minus from '~icons/lucide/minus';
import X from '~icons/lucide/x';

class UiExamples extends Component {
  @tracked selectValue = 'apple';
  @tracked selectValue2 = '';
  @tracked switchChecked = false;
  @tracked switchChecked2 = true;
  @tracked switchChecked3 = false;
  @tracked checkboxChecked = false;
  @tracked checkboxChecked2 = true;
  @tracked checkboxChecked3 = false;
  @tracked inputValue = '';
  @tracked emailValue = '';
  @tracked textareaValue = '';
  @tracked passwordValue = '';
  @tracked dialogOpen = false;
  @tracked tabValue = 'account';
  @tracked accordionValue = 'item-1';
  @tracked collapsibleOpen = false;
  @tracked sliderValue = [50];
  @tracked togglePressed = false;
  @tracked toggleGroupValue = 'center';
  @tracked tooltipOpen = false;
  @tracked popoverOpen = false;
  @tracked hoverCardOpen = false;
  @tracked alertDialogOpen = false;
  @tracked radioValue = 'default';
  @tracked sheetOpen = false;
  @tracked progressValue = 60;

  handleSelectChange = (value: string) => {
    this.selectValue = value;
    console.log('Selected:', value);
  };

  handleSelect2Change = (value: string) => {
    this.selectValue2 = value;
  };

  handleSwitchChange = (checked: boolean) => {
    this.switchChecked = checked;
    console.log('Switch 1 changed:', checked);
  };

  handleSwitch2Change = (checked: boolean) => {
    this.switchChecked2 = checked;
  };

  handleSwitch3Change = (checked: boolean) => {
    this.switchChecked3 = checked;
  };

  handleCheckboxChange = (checked: boolean) => {
    this.checkboxChecked = checked;
    console.log('Checkbox 1 changed:', checked);
  };

  handleCheckbox2Change = (checked: boolean) => {
    this.checkboxChecked2 = checked;
  };

  handleCheckbox3Change = (checked: boolean) => {
    this.checkboxChecked3 = checked;
  };

  handleDialogChange = (open: boolean) => {
    this.dialogOpen = open;
    console.log('Dialog open:', open);
  };

  handleTabChange = (value: string) => {
    this.tabValue = value;
    console.log('Tab changed:', value);
  };

  decreaseProgress = () => {
    this.progressValue = Math.max(0, this.progressValue - 10);
  };

  increaseProgress = () => {
    this.progressValue = Math.min(100, this.progressValue + 10);
  };

  handleAccordionChange = (value: string | string[]) => {
    if (typeof value === 'string') {
      this.accordionValue = value;
    }
  };

  handleToggleGroupChange = (value: string | string[]) => {
    if (typeof value === 'string') {
      this.toggleGroupValue = value;
    }
  };

  <template>
    {{! template-lint-disable no-bare-strings }}
    {{! template-lint-disable no-builtin-form-components }}
    {{! template-lint-disable require-input-label }}
    {{! template-lint-disable builtin-component-arguments }}
    <div class="container mx-auto space-y-12 p-8">
      <div>
        <h1 class="mb-2 text-3xl font-bold">UI Components</h1>
        <p class="text-muted-foreground">Examples of UI component variants and
          usage</p>
      </div>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Input</h2>
        <div class="space-y-6">
          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Basic Input</label>
            <Input
              @type="text"
              placeholder="Enter text..."
              value={{this.inputValue}}
            />
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Email Input</label>
            <Input
              @type="email"
              placeholder="Email"
              value={{this.emailValue}}
            />
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Password Input</label>
            <Input
              @type="password"
              placeholder="Password"
              value={{this.passwordValue}}
            />
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Disabled Input</label>
            <Input @type="text" placeholder="Disabled" disabled />
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">With File Upload</label>
            <Input @type="file" />
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Field Group</h2>
        <div class="space-y-6">
          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Basic Field</h3>
            <Field>
              <FieldLabel @for="username">Username</FieldLabel>
              <Input @type="text" id="username" placeholder="Enter username" />
            </Field>
          </div>

          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Field with Description</h3>
            <Field>
              <FieldLabel @for="email-field">Email</FieldLabel>
              <Input
                @type="email"
                id="email-field"
                placeholder="you@example.com"
              />
              <FieldDescription>
                We'll never share your email with anyone else.
              </FieldDescription>
            </Field>
          </div>

          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Field with Error</h3>
            <Field>
              <FieldLabel @for="password-field">Password</FieldLabel>
              <Input
                @type="password"
                id="password-field"
                placeholder="Enter password"
              />
              <FieldError>
                Password must be at least 8 characters
              </FieldError>
            </Field>
          </div>

          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Horizontal Field</h3>
            <Field @orientation="horizontal">
              <FieldLabel @for="agree">Accept terms</FieldLabel>
              <FieldContent>
                <Checkbox id="agree" @checked={{false}} />
                <FieldDescription>
                  You agree to our Terms of Service and Privacy Policy.
                </FieldDescription>
              </FieldContent>
            </Field>
          </div>

          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Field Group with Multiple Fields</h3>
            <FieldGroup>
              <Field>
                <FieldLabel @for="first-name">First Name</FieldLabel>
                <Input @type="text" id="first-name" placeholder="John" />
              </Field>

              <FieldSeparator />

              <Field>
                <FieldLabel @for="last-name">Last Name</FieldLabel>
                <Input @type="text" id="last-name" placeholder="Doe" />
              </Field>

              <FieldSeparator>Contact Information</FieldSeparator>

              <Field>
                <FieldLabel @for="phone">Phone</FieldLabel>
                <Input @type="tel" id="phone" placeholder="+1 (555) 000-0000" />
                <FieldDescription>
                  Include your country code
                </FieldDescription>
              </Field>
            </FieldGroup>
          </div>

          <div class="max-w-md space-y-2">
            <h3 class="text-xl font-medium">Field with Custom Error Content</h3>
            <Field>
              <FieldLabel @for="complex-password">Password</FieldLabel>
              <Input
                @type="password"
                id="complex-password"
                placeholder="Enter password"
              />
              <FieldError>
                <ul class="ml-4 flex list-disc flex-col gap-1">
                  <li>Password must be at least 8 characters</li>
                  <li>Password must contain at least one number</li>
                  <li>Password must contain at least one special character</li>
                </ul>
              </FieldError>
            </Field>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Textarea</h2>
        <div class="space-y-6">
          <div class="max-w-md space-y-2">
            <label class="text-sm font-medium">Basic Textarea</label>
            <Textarea
              placeholder="Type your message here..."
              value={{this.textareaValue}}
            />
          </div>

          <div class="max-w-md space-y-2">
            <label class="text-sm font-medium">With Rows</label>
            <Textarea placeholder="This textarea has 10 rows" rows="10" />
          </div>

          <div class="max-w-md space-y-2">
            <label class="text-sm font-medium">Disabled Textarea</label>
            <Textarea placeholder="This textarea is disabled" disabled />
          </div>

          <div class="max-w-md space-y-2">
            <label class="text-sm font-medium">With Custom Height</label>
            <Textarea
              class="min-h-[120px]"
              placeholder="Custom minimum height"
            />
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Badge</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Variants</h3>
            <div class="flex flex-wrap gap-4">
              <Badge @variant="default">Default</Badge>
              <Badge @variant="secondary">Secondary</Badge>
              <Badge @variant="destructive">Destructive</Badge>
              <Badge @variant="outline">Outline</Badge>
            </div>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">With Custom Classes</h3>
            <div class="flex flex-wrap gap-4">
              <Badge
                @variant="default"
                @class="text-base px-4 py-1"
              >Larger</Badge>
              <Badge @variant="secondary" @class="rounded-full">Rounded</Badge>
              <Badge @variant="outline" @class="border-2 border-blue-500">Custom
                Border</Badge>
            </div>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Use Cases</h3>
            <div class="flex flex-col gap-4">
              <div class="flex items-center gap-2">
                <span class="text-sm">Status:</span>
                <Badge @variant="default">Active</Badge>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-sm">Notifications:</span>
                <Badge @variant="destructive">5</Badge>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-sm">Version:</span>
                <Badge @variant="secondary">v2.1.0</Badge>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-sm">Tags:</span>
                <Badge @variant="outline">TypeScript</Badge>
                <Badge @variant="outline">Ember</Badge>
                <Badge @variant="outline">Tailwind</Badge>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Alert</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Default Alert</h3>
            <Alert>
              <Info class="h-4 w-4" />
              <AlertTitle>Heads up!</AlertTitle>
              <AlertDescription>
                You can add components to your app using the cli.
              </AlertDescription>
            </Alert>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Destructive Alert</h3>
            <Alert @variant="destructive">
              <TriangleAlert class="h-4 w-4" />
              <AlertTitle>Error</AlertTitle>
              <AlertDescription>
                Your session has expired. Please log in again.
              </AlertDescription>
            </Alert>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Alert without Icon</h3>
            <Alert>
              <AlertTitle>Update Available</AlertTitle>
              <AlertDescription>
                A new version of the application is available. Please refresh
                your page to get the latest features.
              </AlertDescription>
            </Alert>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Alert with Custom Class</h3>
            <Alert @class="border-blue-500">
              <Info class="h-4 w-4" />
              <AlertTitle>Pro Tip</AlertTitle>
              <AlertDescription>
                You can use custom classes to style your alerts according to
                your needs.
              </AlertDescription>
            </Alert>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Select</h2>
        <div class="space-y-6">
          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Fruit Selection</label>
            <Select
              @value={{this.selectValue}}
              @onValueChange={{this.handleSelectChange}}
              as |select|
            >
              <SelectTrigger @toggle={{select.toggle}}>
                <SelectValue @placeholder="Select a fruit">
                  {{select.value}}
                </SelectValue>
              </SelectTrigger>
              <SelectContent @isOpen={{select.isOpen}}>
                <SelectGroup>
                  <SelectLabel>Fruits</SelectLabel>
                  <SelectItem
                    @value="apple"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Apple
                  </SelectItem>
                  <SelectItem
                    @value="banana"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Banana
                  </SelectItem>
                  <SelectItem
                    @value="orange"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Orange
                  </SelectItem>
                  <SelectItem
                    @value="grape"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Grape
                  </SelectItem>
                  <SelectItem
                    @value="mango"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Mango
                  </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <p class="text-muted-foreground text-sm">
              Selected:
              {{this.selectValue}}
            </p>
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">With Groups & Separators</label>
            <Select
              @value={{this.selectValue2}}
              @onValueChange={{this.handleSelect2Change}}
              as |select|
            >
              <SelectTrigger @toggle={{select.toggle}}>
                <SelectValue @placeholder="Select an option">
                  {{select.value}}
                </SelectValue>
              </SelectTrigger>
              <SelectContent @isOpen={{select.isOpen}}>
                <SelectGroup>
                  <SelectLabel>Fruits</SelectLabel>
                  <SelectItem
                    @value="apple"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Apple
                  </SelectItem>
                  <SelectItem
                    @value="banana"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Banana
                  </SelectItem>
                </SelectGroup>
                <SelectSeparator />
                <SelectGroup>
                  <SelectLabel>Vegetables</SelectLabel>
                  <SelectItem
                    @value="carrot"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Carrot
                  </SelectItem>
                  <SelectItem
                    @value="potato"
                    @onSelect={{select.selectValue}}
                    @selectedValue={{select.value}}
                  >
                    Potato
                  </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
            <p class="text-muted-foreground text-sm">
              Selected:
              {{if this.selectValue2 this.selectValue2 "(none)"}}
            </p>
          </div>

          <div class="max-w-xs space-y-2">
            <label class="text-sm font-medium">Disabled Select</label>
            <Select @disabled={{true}} as |select|>
              <SelectTrigger @disabled={{true}} @toggle={{select.toggle}}>
                <SelectValue @placeholder="This is disabled" />
              </SelectTrigger>
              <SelectContent @isOpen={{select.isOpen}}>
                <SelectItem @value="option1" @onSelect={{select.selectValue}}>
                  Option 1
                </SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Switch</h2>
        <div class="space-y-6">
          <div class="flex items-center space-x-4">
            <Switch
              @checked={{this.switchChecked}}
              @onCheckedChange={{this.handleSwitchChange}}
            />
            <label class="text-sm font-medium">
              Basic Switch ({{if this.switchChecked "On" "Off"}})
            </label>
          </div>

          <div class="flex items-center space-x-4">
            <Switch
              @checked={{this.switchChecked2}}
              @onCheckedChange={{this.handleSwitch2Change}}
            />
            <label class="text-sm font-medium">
              Initially On ({{if this.switchChecked2 "On" "Off"}})
            </label>
          </div>

          <div class="flex items-center space-x-4">
            <Switch @disabled={{true}} />
            <label class="text-muted-foreground text-sm font-medium">
              Disabled Switch (Off)
            </label>
          </div>

          <div class="flex items-center space-x-4">
            <Switch @checked={{true}} @disabled={{true}} />
            <label class="text-muted-foreground text-sm font-medium">
              Disabled Switch (On)
            </label>
          </div>

          <div class="max-w-xs space-y-2">
            <div
              class="flex items-center justify-between space-x-4 rounded-lg border p-4"
            >
              <div class="space-y-0.5">
                <div class="text-sm font-medium">Marketing emails</div>
                <div class="text-muted-foreground text-sm">
                  Receive emails about new products and features.
                </div>
              </div>
              <Switch
                @checked={{this.switchChecked3}}
                @onCheckedChange={{this.handleSwitch3Change}}
              />
            </div>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Label</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <Label>Basic Label</Label>
            <Input @type="text" placeholder="Enter text..." />
          </div>

          <div class="space-y-2">
            <Label @for="email-input">Email Label (with for attribute)</Label>
            <Input
              @type="email"
              id="email-input"
              placeholder="email@example.com"
            />
          </div>

          <div class="space-y-2">
            <Label @class="text-base">Custom Styled Label</Label>
            <Input @type="text" placeholder="Custom styling" />
          </div>

          <div class="flex items-center space-x-2">
            <Checkbox id="terms" />
            <Label @for="terms">
              Accept terms and conditions
            </Label>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Checkbox</h2>
        <div class="space-y-6">
          <div class="flex items-center space-x-4">
            <Checkbox
              @checked={{this.checkboxChecked}}
              @onCheckedChange={{this.handleCheckboxChange}}
              id="checkbox-1"
            />
            <Label @for="checkbox-1">
              Basic Checkbox ({{if this.checkboxChecked "Checked" "Unchecked"}})
            </Label>
          </div>

          <div class="flex items-center space-x-4">
            <Checkbox
              @checked={{this.checkboxChecked2}}
              @onCheckedChange={{this.handleCheckbox2Change}}
              id="checkbox-2"
            />
            <Label @for="checkbox-2">
              Initially Checked ({{if
                this.checkboxChecked2
                "Checked"
                "Unchecked"
              }})
            </Label>
          </div>

          <div class="flex items-center space-x-4">
            <Checkbox @disabled={{true}} id="checkbox-3" />
            <Label @for="checkbox-3" @class="text-muted-foreground">
              Disabled Checkbox (Unchecked)
            </Label>
          </div>

          <div class="flex items-center space-x-4">
            <Checkbox @checked={{true}} @disabled={{true}} id="checkbox-4" />
            <Label @for="checkbox-4" @class="text-muted-foreground">
              Disabled Checkbox (Checked)
            </Label>
          </div>

          <div class="max-w-xs space-y-2">
            <div class="rounded-lg border p-4">
              <div class="flex items-start space-x-4">
                <Checkbox
                  @checked={{this.checkboxChecked3}}
                  @onCheckedChange={{this.handleCheckbox3Change}}
                  id="checkbox-5"
                />
                <div class="space-y-0.5">
                  <Label @for="checkbox-5">Accept terms and conditions</Label>
                  <div class="text-muted-foreground text-sm">
                    You agree to our Terms of Service and Privacy Policy.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <Label
          @class="hover:bg-accent/50 flex items-start gap-3 rounded-lg border p-3 has-[[aria-checked=true]]:border-blue-600 has-[[aria-checked=true]]:bg-blue-50 dark:has-[[aria-checked=true]]:border-blue-900 dark:has-[[aria-checked=true]]:bg-blue-950"
        >
          <Checkbox
            id="toggle-2"
            @checked={{true}}
            @class="data-[state=checked]:border-blue-600 data-[state=checked]:bg-blue-600 data-[state=checked]:text-white dark:data-[state=checked]:border-blue-700 dark:data-[state=checked]:bg-blue-700"
          />
          <div class="grid gap-1.5 font-normal">
            <p class="text-sm font-medium leading-none">
              Enable notifications
            </p>
            <p class="text-muted-foreground text-sm">
              You can enable or disable notifications at any time.
            </p>
          </div>
        </Label>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Card</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Basic Card</h3>
            <Card @class="w-[350px]">
              <CardHeader>
                <CardTitle>Card Title</CardTitle>
                <CardDescription>Card Description</CardDescription>
              </CardHeader>
              <CardContent>
                <p>This is the card content area. You can put any content here.</p>
              </CardContent>
              <CardFooter>
                <Button @variant="default">Action</Button>
              </CardFooter>
            </Card>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Card with Form</h3>
            <Card @class="w-[350px]">
              <CardHeader>
                <CardTitle>Create Account</CardTitle>
                <CardDescription>Enter your information to create an account.</CardDescription>
              </CardHeader>
              <CardContent>
                <div class="grid w-full gap-4">
                  <div class="flex flex-col space-y-1.5">
                    <label for="name" class="text-sm font-medium">Name</label>
                    <Input @type="text" id="name" placeholder="John Doe" />
                  </div>
                  <div class="flex flex-col space-y-1.5">
                    <label for="email" class="text-sm font-medium">Email</label>
                    <Input
                      @type="email"
                      id="email"
                      placeholder="john@example.com"
                    />
                  </div>
                </div>
              </CardContent>
              <CardFooter @class="flex justify-between">
                <Button @variant="outline">Cancel</Button>
                <Button @variant="default">Create</Button>
              </CardFooter>
            </Card>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Simple Card</h3>
            <Card @class="w-[350px]">
              <CardHeader>
                <CardTitle>Notifications</CardTitle>
                <CardDescription>You have 3 unread messages.</CardDescription>
              </CardHeader>
              <CardContent>
                <div class="space-y-2">
                  <div class="flex items-start gap-2 rounded-md border p-3">
                    <Badge @variant="default">New</Badge>
                    <div class="flex-1">
                      <p class="text-sm font-medium">Message from John</p>
                      <p class="text-muted-foreground text-sm">Hey, how are you?</p>
                    </div>
                  </div>
                  <div class="flex items-start gap-2 rounded-md border p-3">
                    <Badge @variant="secondary">Read</Badge>
                    <div class="flex-1">
                      <p class="text-sm font-medium">Meeting reminder</p>
                      <p class="text-muted-foreground text-sm">Team standup at
                        10am</p>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Card Without Footer</h3>
            <Card @class="w-[350px]">
              <CardHeader>
                <CardTitle>Stats Overview</CardTitle>
                <CardDescription>Your account statistics for this month.</CardDescription>
              </CardHeader>
              <CardContent>
                <div class="space-y-4">
                  <div class="flex justify-between">
                    <span class="text-muted-foreground text-sm">Total Users</span>
                    <span class="font-semibold">1,234</span>
                  </div>
                  <div class="flex justify-between">
                    <span class="text-muted-foreground text-sm">Active Sessions</span>
                    <span class="font-semibold">89</span>
                  </div>
                  <div class="flex justify-between">
                    <span class="text-muted-foreground text-sm">Revenue</span>
                    <span class="font-semibold">$12,345</span>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Dialog</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Basic Dialog</h3>
            <Dialog
              @open={{this.dialogOpen}}
              @onOpenChange={{this.handleDialogChange}}
              as |isOpen setOpen|
            >
              <DialogTrigger @setOpen={{setOpen}}>
                <Button>Open Dialog</Button>
              </DialogTrigger>
              <DialogContent @open={{isOpen}} @setOpen={{setOpen}}>
                <DialogHeader>
                  <DialogTitle>Are you absolutely sure?</DialogTitle>
                  <DialogDescription>
                    This action cannot be undone. This will permanently delete
                    your account and remove your data from our servers.
                  </DialogDescription>
                </DialogHeader>
              </DialogContent>
            </Dialog>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Dialog with Footer</h3>
            <Dialog as |isOpen setOpen|>
              <DialogTrigger @setOpen={{setOpen}}>
                <Button @variant="outline">Edit Profile</Button>
              </DialogTrigger>
              <DialogContent @open={{isOpen}} @setOpen={{setOpen}}>
                <DialogHeader>
                  <DialogTitle>Edit profile</DialogTitle>
                  <DialogDescription>
                    Make changes to your profile here. Click save when you're
                    done.
                  </DialogDescription>
                </DialogHeader>
                <div class="grid gap-4 py-4">
                  <div class="grid grid-cols-4 items-center gap-4">
                    <label
                      for="name-2"
                      class="text-right text-sm font-medium"
                    >Name</label>
                    <Input
                      @type="text"
                      id="name-2"
                      value="Pedro Duarte"
                      class="col-span-3"
                    />
                  </div>
                  <div class="grid grid-cols-4 items-center gap-4">
                    <label
                      for="username-2"
                      class="text-right text-sm font-medium"
                    >Username</label>
                    <Input
                      @type="text"
                      id="username-2"
                      value="&#64;peduarte"
                      class="col-span-3"
                    />
                  </div>
                </div>
                <DialogFooter>
                  <Button type="submit">Save changes</Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Destructive Dialog</h3>
            <Dialog as |isOpen setOpen|>
              <DialogTrigger @setOpen={{setOpen}}>
                <Button @variant="destructive">Delete Account</Button>
              </DialogTrigger>
              <DialogContent @open={{isOpen}} @setOpen={{setOpen}}>
                <DialogHeader>
                  <DialogTitle>Delete Account</DialogTitle>
                  <DialogDescription>
                    Are you sure you want to delete your account? This action is
                    permanent and cannot be undone. All your data will be
                    permanently removed.
                  </DialogDescription>
                </DialogHeader>
                <DialogFooter>
                  <Button
                    @variant="outline"
                    {{on "click" (fn setOpen false)}}
                  >Cancel</Button>
                  <Button @variant="destructive">Delete Account</Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Tabs</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Basic Tabs</h3>
            <Tabs @defaultValue="account" @class="w-full max-w-md" as |tabs|>
              <tabs.List>
                <tabs.Trigger @value="account">Account</tabs.Trigger>
                <tabs.Trigger @value="password">Password</tabs.Trigger>
              </tabs.List>
              <tabs.Content @value="account">
                <Card>
                  <CardHeader>
                    <CardTitle>Account</CardTitle>
                    <CardDescription>
                      Make changes to your account here. Click save when you're
                      done.
                    </CardDescription>
                  </CardHeader>
                  <CardContent class="space-y-2">
                    <div class="space-y-1">
                      <label class="text-sm font-medium">Name</label>
                      <Input value="Pedro Duarte" />
                    </div>
                    <div class="space-y-1">
                      <label class="text-sm font-medium">Username</label>
                      <Input value="&#64;peduarte" />
                    </div>
                  </CardContent>
                  <CardFooter>
                    <Button>Save changes</Button>
                  </CardFooter>
                </Card>
              </tabs.Content>
              <tabs.Content @value="password">
                <Card>
                  <CardHeader>
                    <CardTitle>Password</CardTitle>
                    <CardDescription>
                      Change your password here. After saving, you'll be logged
                      out.
                    </CardDescription>
                  </CardHeader>
                  <CardContent class="space-y-2">
                    <div class="space-y-1">
                      <label class="text-sm font-medium">Current password</label>
                      <Input @type="password" />
                    </div>
                    <div class="space-y-1">
                      <label class="text-sm font-medium">New password</label>
                      <Input @type="password" />
                    </div>
                  </CardContent>
                  <CardFooter>
                    <Button>Save password</Button>
                  </CardFooter>
                </Card>
              </tabs.Content>
            </Tabs>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Controlled Tabs</h3>
            <div class="space-y-4">
              <div class="text-muted-foreground text-sm">Current tab:
                {{this.tabValue}}</div>
              <Tabs
                @value={{this.tabValue}}
                @onValueChange={{this.handleTabChange}}
                @class="w-full max-w-md"
                as |tabs|
              >
                <tabs.List>
                  <tabs.Trigger @value="overview">Overview</tabs.Trigger>
                  <tabs.Trigger @value="analytics">Analytics</tabs.Trigger>
                  <tabs.Trigger @value="reports">Reports</tabs.Trigger>
                  <tabs.Trigger
                    @value="notifications"
                  >Notifications</tabs.Trigger>
                </tabs.List>
                <tabs.Content @value="overview">
                  <Card>
                    <CardHeader>
                      <CardTitle>Overview</CardTitle>
                      <CardDescription>
                        Get a quick overview of your dashboard and recent
                        activity.
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <p>Overview content goes here...</p>
                    </CardContent>
                  </Card>
                </tabs.Content>
                <tabs.Content @value="analytics">
                  <Card>
                    <CardHeader>
                      <CardTitle>Analytics</CardTitle>
                      <CardDescription>
                        View detailed analytics and insights about your data.
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <p>Analytics content goes here...</p>
                    </CardContent>
                  </Card>
                </tabs.Content>
                <tabs.Content @value="reports">
                  <Card>
                    <CardHeader>
                      <CardTitle>Reports</CardTitle>
                      <CardDescription>
                        Generate and view reports for your business.
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <p>Reports content goes here...</p>
                    </CardContent>
                  </Card>
                </tabs.Content>
                <tabs.Content @value="notifications">
                  <Card>
                    <CardHeader>
                      <CardTitle>Notifications</CardTitle>
                      <CardDescription>
                        Manage your notification preferences.
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <p>Notifications content goes here...</p>
                    </CardContent>
                  </Card>
                </tabs.Content>
              </Tabs>
            </div>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Buttons</h2>
        <h3 class="text-xl font-medium">Variants</h3>
        <div class="flex flex-wrap gap-4">
          <Button @variant="default">Default</Button>
          <Button @variant="destructive">Destructive</Button>
          <Button @variant="outline">Outline</Button>
          <Button @variant="secondary">Secondary</Button>
          <Button @variant="ghost">Ghost</Button>
          <Button @variant="link">Link</Button>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">Sizes</h3>
        <div class="flex flex-wrap items-center gap-4">
          <Button @size="sm">Small</Button>
          <Button @size="default">Default</Button>
          <Button @size="lg">Large</Button>
          <Button @size="icon">+</Button>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">Disabled State</h3>
        <div class="flex flex-wrap gap-4">
          <Button @disabled={{true}}>Disabled Default</Button>
          <Button @variant="destructive" @disabled={{true}}>Disabled Destructive</Button>
          <Button @variant="outline" @disabled={{true}}>Disabled Outline</Button>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">Size x Variant Combinations</h3>
        <div class="space-y-4">
          <div>
            <h4 class="mb-2 text-lg font-medium">Small</h4>
            <div class="flex flex-wrap gap-4">
              <Button @variant="default" @size="sm">Default</Button>
              <Button @variant="destructive" @size="sm">Destructive</Button>
              <Button @variant="outline" @size="sm">Outline</Button>
              <Button @variant="secondary" @size="sm">Secondary</Button>
              <Button @variant="ghost" @size="sm">Ghost</Button>
              <Button @variant="link" @size="sm">Link</Button>
            </div>
          </div>

          <div>
            <h4 class="mb-2 text-lg font-medium">Large</h4>
            <div class="flex flex-wrap gap-4">
              <Button @variant="default" @size="lg">Default</Button>
              <Button @variant="destructive" @size="lg">Destructive</Button>
              <Button @variant="outline" @size="lg">Outline</Button>
              <Button @variant="secondary" @size="lg">Secondary</Button>
              <Button @variant="ghost" @size="lg">Ghost</Button>
              <Button @variant="link" @size="lg">Link</Button>
            </div>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">With Icons</h3>
        <div class="flex flex-wrap gap-4">
          <Button @variant="default">
            <Plus class="size-4" />
            Add Item
          </Button>
          <Button @variant="destructive">
            <Trash2 class="size-4" />
            Delete
          </Button>
          <Button @variant="outline" @size="icon">
            <Info class="size-4" />
          </Button>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">As Child (Custom Element)</h3>
        <div class="flex flex-wrap gap-4">
          <Button @asChild={{true}}>
            <a
              href="#demo"
              class="focus-visible:ring-ring bg-primary text-primary-foreground hover:bg-primary/90 inline-flex h-9 items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 py-2 text-sm font-medium shadow transition-colors focus-visible:outline-none focus-visible:ring-1 disabled:pointer-events-none disabled:opacity-50"
            >
              Link as Button
            </a>
          </Button>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Separator</h2>
        <div class="space-y-6">
          <div class="space-y-2">
            <h3 class="text-xl font-medium">Horizontal Separator</h3>
            <div class="w-full">
              <div class="space-y-1">
                <h4 class="text-sm font-medium leading-none">Radix Primitives</h4>
                <p class="text-muted-foreground text-sm">
                  An open-source UI component library.
                </p>
              </div>
              <Separator class="my-4" />
              <div class="flex h-5 items-center space-x-4 text-sm">
                <div>Blog</div>
                <Separator @orientation="vertical" />
                <div>Docs</div>
                <Separator @orientation="vertical" />
                <div>Source</div>
              </div>
            </div>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">Vertical Separator</h3>
            <div class="flex h-20 items-center space-x-4">
              <div class="text-sm">Item 1</div>
              <Separator @orientation="vertical" />
              <div class="text-sm">Item 2</div>
              <Separator @orientation="vertical" />
              <div class="text-sm">Item 3</div>
            </div>
          </div>

          <div class="space-y-2">
            <h3 class="text-xl font-medium">In Content</h3>
            <div class="max-w-md space-y-4">
              <p class="text-sm">
                This is a paragraph of text that demonstrates the separator
                component in a content context.
              </p>
              <Separator />
              <p class="text-sm">
                Here's another paragraph after the separator, showing how it can
                be used to divide content sections.
              </p>
            </div>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Button Group</h2>
        <h3 class="text-xl font-medium">Horizontal Group</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup>
            <Button @variant="outline">Left</Button>
            <Button @variant="outline">Center</Button>
            <Button @variant="outline">Right</Button>
          </ButtonGroup>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">Vertical Group</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup @orientation="vertical">
            <Button @variant="outline">Top</Button>
            <Button @variant="outline">Middle</Button>
            <Button @variant="outline">Bottom</Button>
          </ButtonGroup>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">With Separators</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup>
            <Button @variant="outline">First</Button>
            <ButtonGroupSeparator />
            <Button @variant="outline">Second</Button>
            <ButtonGroupSeparator />
            <Button @variant="outline">Third</Button>
          </ButtonGroup>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">With Text Element</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup>
            <ButtonGroupText>Actions:</ButtonGroupText>
            <Button @variant="outline">Save</Button>
            <Button @variant="outline">Cancel</Button>
          </ButtonGroup>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">With Icons</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup>
            <Button @variant="outline" @size="icon">
              <Plus class="size-4" />
            </Button>
            <Button @variant="outline" @size="icon">
              <Minus class="size-4" />
            </Button>
            <Button @variant="outline" @size="icon">
              <X class="size-4" />
            </Button>
          </ButtonGroup>
        </div>
      </section>

      <section class="space-y-4">
        <h3 class="text-xl font-medium">Different Variants in Group</h3>
        <div class="flex flex-wrap gap-4">
          <ButtonGroup>
            <Button @variant="default">Primary</Button>
            <Button @variant="secondary">Secondary</Button>
            <Button @variant="destructive">Delete</Button>
          </ButtonGroup>
        </div>
      </section>

      {{! New Components }}

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Accordion</h2>
        <div class="max-w-xl">
          <Accordion
            @type="single"
            @value={{this.accordionValue}}
            @onValueChange={{this.handleAccordionChange}}
            as |value setValue|
          >
            <AccordionItem
              @value="item-1"
              @currentValue={{value}}
              @setValue={{setValue}}
              @type="single"
              as |isOpen toggle|
            >
              <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>Is it
                accessible?</AccordionTrigger>
              <AccordionContent @isOpen={{isOpen}}>
                Yes. It adheres to the WAI-ARIA design pattern.
              </AccordionContent>
            </AccordionItem>
            <AccordionItem
              @value="item-2"
              @currentValue={{value}}
              @setValue={{setValue}}
              @type="single"
              as |isOpen toggle|
            >
              <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>Is it
                styled?</AccordionTrigger>
              <AccordionContent @isOpen={{isOpen}}>
                Yes. It comes with default styles that matches the other
                components' aesthetic.
              </AccordionContent>
            </AccordionItem>
            <AccordionItem
              @value="item-3"
              @currentValue={{value}}
              @setValue={{setValue}}
              @type="single"
              as |isOpen toggle|
            >
              <AccordionTrigger @isOpen={{isOpen}} @toggle={{toggle}}>Is it
                animated?</AccordionTrigger>
              <AccordionContent @isOpen={{isOpen}}>
                Yes. It's animated by default, but you can disable it if you
                prefer.
              </AccordionContent>
            </AccordionItem>
          </Accordion>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Avatar</h2>
        <div class="flex items-center gap-4">
          <Avatar>
            <AvatarImage @src="https://github.com/shadcn.png" @alt="shadcn" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Avatar>
            <AvatarImage @src="https://invalid-url.png" @alt="User" />
            <AvatarFallback>JD</AvatarFallback>
          </Avatar>
          <Avatar>
            <AvatarFallback>AB</AvatarFallback>
          </Avatar>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Aspect Ratio</h2>
        <div class="max-w-sm">
          <AspectRatio @ratio={{1.7778}}>
            <img
              src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80"
              alt="Mountain landscape at sunset"
              class="h-full w-full rounded-md object-cover"
            />
          </AspectRatio>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Breadcrumb</h2>
        <Breadcrumb>
          <BreadcrumbList>
            <BreadcrumbItem>
              <BreadcrumbLink @href="/">Home</BreadcrumbLink>
            </BreadcrumbItem>
            <BreadcrumbSeparator />
            <BreadcrumbItem>
              <BreadcrumbLink @href="/components">Components</BreadcrumbLink>
            </BreadcrumbItem>
            <BreadcrumbSeparator />
            <BreadcrumbItem>
              <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
            </BreadcrumbItem>
          </BreadcrumbList>
        </Breadcrumb>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Collapsible</h2>
        <Collapsible
          @open={{this.collapsibleOpen}}
          @onOpenChange={{fn (mut this.collapsibleOpen)}}
          as |open setOpen|
        >
          <div class="flex items-center justify-between space-x-4 px-4">
            <h4 class="text-sm font-semibold">
              @peduarte starred 3 repositories
            </h4>
            <CollapsibleTrigger @open={{open}} @setOpen={{setOpen}}>
              <Button @variant="ghost" @size="sm">
                {{if open "Hide" "Show"}}
              </Button>
            </CollapsibleTrigger>
          </div>
          <div class="rounded-md border px-4 py-2 font-mono text-sm">
            @radix-ui/primitives
          </div>
          <CollapsibleContent @open={{open}}>
            <div class="space-y-2">
              <div class="rounded-md border px-4 py-2 font-mono text-sm">
                @radix-ui/colors
              </div>
              <div class="rounded-md border px-4 py-2 font-mono text-sm">
                @stitches/react
              </div>
            </div>
          </CollapsibleContent>
        </Collapsible>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Empty State</h2>
        <Empty>
          <EmptyHeader>
            <EmptyMedia @variant="icon">
              <Heart class="size-6" />
            </EmptyMedia>
            <EmptyTitle>No favorites yet</EmptyTitle>
            <EmptyDescription>
              Start adding your favorite items to see them here.
            </EmptyDescription>
          </EmptyHeader>
          <Button>Add Favorite</Button>
        </Empty>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Kbd (Keyboard)</h2>
        <div class="space-y-4">
          <div>
            <p class="mb-2 text-sm">Single Key:</p>
            <Kbd>⌘</Kbd>
            <Kbd>K</Kbd>
          </div>
          <div>
            <p class="mb-2 text-sm">Key Group:</p>
            <KbdGroup>
              <Kbd>⌘</Kbd>
              <Kbd>K</Kbd>
            </KbdGroup>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Progress</h2>
        <div class="max-w-md space-y-4">
          <Progress @value={{this.progressValue}} />
          <div class="flex gap-2">
            <Button @size="sm" {{on "click" this.decreaseProgress}}>
              Decrease
            </Button>
            <Button @size="sm" {{on "click" this.increaseProgress}}>
              Increase
            </Button>
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Skeleton</h2>
        <div class="flex items-center space-x-4">
          <Skeleton class="h-12 w-12 rounded-full" />
          <div class="space-y-2">
            <Skeleton class="h-4 w-[250px]" />
            <Skeleton class="h-4 w-[200px]" />
          </div>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Spinner</h2>
        <div class="flex items-center gap-4">
          <Spinner />
          <Spinner @size={{24}} />
          <Spinner @size={{32}} />
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Slider</h2>
        <div class="max-w-md">
          <Slider
            @value={{this.sliderValue}}
            @onValueChange={{fn (mut this.sliderValue)}}
            @max={{100}}
            @step={{1}}
          />
          <p class="text-muted-foreground mt-2 text-sm">Value:
            {{get this.sliderValue 0}}</p>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Toggle</h2>
        <div class="flex gap-2">
          <Toggle
            @pressed={{this.togglePressed}}
            @onPressedChange={{fn (mut this.togglePressed)}}
          >
            <Bold class="size-4" />
          </Toggle>
          <Toggle>
            <Italic class="size-4" />
          </Toggle>
          <Toggle>
            <Underline class="size-4" />
          </Toggle>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Toggle Group</h2>
        <ToggleGroup
          @type="single"
          @value={{this.toggleGroupValue}}
          @onValueChange={{this.handleToggleGroupChange}}
        >
          <ToggleGroupItem @value="left">
            Left
          </ToggleGroupItem>
          <ToggleGroupItem @value="center">
            Center
          </ToggleGroupItem>
          <ToggleGroupItem @value="right">
            Right
          </ToggleGroupItem>
        </ToggleGroup>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Tooltip</h2>
        <TooltipProvider>
          <Tooltip
            @open={{this.tooltipOpen}}
            @onOpenChange={{fn (mut this.tooltipOpen)}}
            as |open setOpen|
          >
            <TooltipTrigger @setOpen={{setOpen}}>
              <Button @variant="outline">Hover me</Button>
            </TooltipTrigger>
            <TooltipContent @isOpen={{open}}>
              <p>Add to library</p>
            </TooltipContent>
          </Tooltip>
        </TooltipProvider>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Popover</h2>
        <Popover
          @open={{this.popoverOpen}}
          @onOpenChange={{fn (mut this.popoverOpen)}}
          as |open setOpen|
        >
          <PopoverTrigger @setOpen={{setOpen}}>
            <Button @variant="outline">Open popover</Button>
          </PopoverTrigger>
          <PopoverContent @isOpen={{open}} class="w-80">
            <div class="grid gap-4">
              <div class="space-y-2">
                <h4 class="font-medium leading-none">Dimensions</h4>
                <p class="text-muted-foreground text-sm">
                  Set the dimensions for the layer.
                </p>
              </div>
              <div class="grid gap-2">
                <div class="grid grid-cols-3 items-center gap-4">
                  <Label>Width</Label>
                  <Input @type="number" value="100" class="col-span-2 h-8" />
                </div>
                <div class="grid grid-cols-3 items-center gap-4">
                  <Label>Height</Label>
                  <Input @type="number" value="25" class="col-span-2 h-8" />
                </div>
              </div>
            </div>
          </PopoverContent>
        </Popover>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Hover Card</h2>
        <HoverCard
          @open={{this.hoverCardOpen}}
          @onOpenChange={{fn (mut this.hoverCardOpen)}}
          as |open setOpen|
        >
          <HoverCardTrigger @setOpen={{setOpen}}>
            <Button @variant="link">@nextjs</Button>
          </HoverCardTrigger>
          <HoverCardContent @isOpen={{open}} class="w-80">
            <div class="flex justify-between space-x-4">
              <Avatar>
                <AvatarImage @src="https://github.com/vercel.png" />
                <AvatarFallback>VC</AvatarFallback>
              </Avatar>
              <div class="space-y-1">
                <h4 class="text-sm font-semibold">@nextjs</h4>
                <p class="text-sm">
                  The React Framework - created and maintained by @vercel.
                </p>
                <div class="flex items-center pt-2">
                  <span class="text-muted-foreground text-xs">
                    Joined December 2021
                  </span>
                </div>
              </div>
            </div>
          </HoverCardContent>
        </HoverCard>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Alert Dialog</h2>
        <AlertDialog
          @open={{this.alertDialogOpen}}
          @onOpenChange={{fn (mut this.alertDialogOpen)}}
          as |open setOpen|
        >
          <AlertDialogTrigger @setOpen={{setOpen}}>
            <Button @variant="outline">Show Dialog</Button>
          </AlertDialogTrigger>
          <AlertDialogContent @isOpen={{open}} @setOpen={{setOpen}}>
            <AlertDialogHeader>
              <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
              <AlertDialogDescription>
                This action cannot be undone. This will permanently delete your
                account and remove your data from our servers.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel @setOpen={{setOpen}}>Cancel</AlertDialogCancel>
              <AlertDialogAction
                @setOpen={{setOpen}}
              >Continue</AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Radio Group</h2>
        <RadioGroup
          @value={{this.radioValue}}
          @onValueChange={{fn (mut this.radioValue)}}
          as |state|
        >
          <div class="flex items-center space-x-2">
            <RadioGroupItem
              @value="default"
              @currentValue={{state.value}}
              @setValue={{state.setValue}}
              id="r1"
            />
            <Label for="r1">Default</Label>
          </div>
          <div class="flex items-center space-x-2">
            <RadioGroupItem
              @value="comfortable"
              @currentValue={{state.value}}
              @setValue={{state.setValue}}
              id="r2"
            />
            <Label for="r2">Comfortable</Label>
          </div>
          <div class="flex items-center space-x-2">
            <RadioGroupItem
              @value="compact"
              @currentValue={{state.value}}
              @setValue={{state.setValue}}
              id="r3"
            />
            <Label for="r3">Compact</Label>
          </div>
        </RadioGroup>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Scroll Area</h2>
        <ScrollArea class="h-72 w-48 rounded-md border">
          <div class="p-4">
            <h4 class="mb-4 text-sm font-medium leading-none">Tags</h4>
            {{#each
              (array
                "v1.2.0-beta.1"
                "v1.2.0-beta.2"
                "v1.2.0-beta.3"
                "v1.2.0-beta.4"
                "v1.2.0-beta.5"
                "v1.2.0"
                "v1.2.1"
                "v1.3.0-beta.1"
                "v1.3.0-beta.2"
                "v1.3.0"
              )
              as |tag|
            }}
              <div class="text-sm">{{tag}}</div>
              <Separator class="my-2" />
            {{/each}}
          </div>
        </ScrollArea>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Sheet</h2>
        <Sheet
          @open={{this.sheetOpen}}
          @onOpenChange={{fn (mut this.sheetOpen)}}
          as |open setOpen|
        >
          <SheetTrigger @setOpen={{setOpen}}>
            <Button @variant="outline">Open Sheet</Button>
          </SheetTrigger>
          <SheetContent @isOpen={{open}} @setOpen={{setOpen}}>
            <SheetHeader>
              <SheetTitle>Edit profile</SheetTitle>
              <SheetDescription>
                Make changes to your profile here. Click save when you're done.
              </SheetDescription>
            </SheetHeader>
            <div class="grid gap-4 py-4">
              <div class="grid grid-cols-4 items-center gap-4">
                <Label class="text-right">Name</Label>
                <Input value="Pedro Duarte" class="col-span-3" />
              </div>
              <div class="grid grid-cols-4 items-center gap-4">
                <Label class="text-right">Username</Label>
                <Input value="peduarte" class="col-span-3" />
              </div>
            </div>
          </SheetContent>
        </Sheet>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Table</h2>
        <div class="rounded-md border">
          <Table>
            <TableCaption>A list of your recent invoices.</TableCaption>
            <TableHeader>
              <TableRow>
                <TableHead class="w-[100px]">Invoice</TableHead>
                <TableHead>Status</TableHead>
                <TableHead>Method</TableHead>
                <TableHead class="text-right">Amount</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              <TableRow>
                <TableCell class="font-medium">INV001</TableCell>
                <TableCell>Paid</TableCell>
                <TableCell>Credit Card</TableCell>
                <TableCell class="text-right">$250.00</TableCell>
              </TableRow>
              <TableRow>
                <TableCell class="font-medium">INV002</TableCell>
                <TableCell>Pending</TableCell>
                <TableCell>PayPal</TableCell>
                <TableCell class="text-right">$150.00</TableCell>
              </TableRow>
              <TableRow>
                <TableCell class="font-medium">INV003</TableCell>
                <TableCell>Unpaid</TableCell>
                <TableCell>Bank Transfer</TableCell>
                <TableCell class="text-right">$350.00</TableCell>
              </TableRow>
            </TableBody>
            <TableFooter>
              <TableRow>
                <TableCell colspan="3">Total</TableCell>
                <TableCell class="text-right">$750.00</TableCell>
              </TableRow>
            </TableFooter>
          </Table>
        </div>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Dropdown Menu</h2>
        <DropdownMenu as |isOpen setOpen|>
          <DropdownMenuTrigger @isOpen={{isOpen}} @setOpen={{setOpen}}>
            <Button @variant="outline">Open Menu</Button>
          </DropdownMenuTrigger>
          {{#if isOpen}}
            <DropdownMenuContent>
              <DropdownMenuLabel>My Account</DropdownMenuLabel>
              <DropdownMenuSeparator />
              <DropdownMenuItem>Profile</DropdownMenuItem>
              <DropdownMenuItem>Billing</DropdownMenuItem>
              <DropdownMenuItem>Settings</DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem>Log out</DropdownMenuItem>
            </DropdownMenuContent>
          {{/if}}
        </DropdownMenu>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Context Menu</h2>
        <ContextMenu as |isOpen setOpen|>
          <ContextMenuTrigger @setOpen={{setOpen}}>
            <div
              class="flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm"
            >
              Right click here
            </div>
          </ContextMenuTrigger>
          {{#if isOpen}}
            <ContextMenuContent>
              <ContextMenuItem>Back</ContextMenuItem>
              <ContextMenuItem>Forward</ContextMenuItem>
              <ContextMenuItem>Reload</ContextMenuItem>
              <ContextMenuSeparator />
              <ContextMenuItem>Save Page As...</ContextMenuItem>
            </ContextMenuContent>
          {{/if}}
        </ContextMenu>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Menubar</h2>
        <Menubar>
          <MenubarMenu as |isOpen setOpen|>
            <MenubarTrigger @isOpen={{isOpen}} @setOpen={{setOpen}}>
              File
            </MenubarTrigger>
            {{#if isOpen}}
              <MenubarContent @isOpen={{isOpen}} @setOpen={{setOpen}}>
                <MenubarItem>New File</MenubarItem>
                <MenubarItem>Open File</MenubarItem>
                <MenubarSeparator />
                <MenubarItem>Exit</MenubarItem>
              </MenubarContent>
            {{/if}}
          </MenubarMenu>
          <MenubarMenu as |isOpen setOpen|>
            <MenubarTrigger @isOpen={{isOpen}} @setOpen={{setOpen}}>
              Edit
            </MenubarTrigger>
            {{#if isOpen}}
              <MenubarContent @isOpen={{isOpen}} @setOpen={{setOpen}}>
                <MenubarItem>Undo</MenubarItem>
                <MenubarItem>Redo</MenubarItem>
              </MenubarContent>
            {{/if}}
          </MenubarMenu>
        </Menubar>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Pagination</h2>
        <Pagination>
          <PaginationContent>
            <PaginationItem>
              <PaginationPrevious href="#" />
            </PaginationItem>
            <PaginationItem>
              <PaginationLink href="#">1</PaginationLink>
            </PaginationItem>
            <PaginationItem>
              <PaginationLink href="#" @isActive={{true}}>2</PaginationLink>
            </PaginationItem>
            <PaginationItem>
              <PaginationLink href="#">3</PaginationLink>
            </PaginationItem>
            <PaginationItem>
              <PaginationEllipsis />
            </PaginationItem>
            <PaginationItem>
              <PaginationNext href="#" />
            </PaginationItem>
          </PaginationContent>
        </Pagination>
      </section>

      <section class="space-y-4">
        <h2 class="text-2xl font-semibold">Additional Components</h2>
        <div class="text-muted-foreground space-y-2 text-sm">
          <p>
            <strong>Calendar:</strong>
            Placeholder component - requires date picker library implementation
          </p>
          <p>
            <strong>Carousel:</strong>
            Image/content carousel - requires embla-carousel integration
          </p>
          <p>
            <strong>Chart:</strong>
            Data visualization - requires charting library integration
          </p>
          <p>
            <strong>Command:</strong>
            Command palette/search - requires cmdk-style implementation
          </p>
          <p>
            <strong>Form:</strong>
            Form validation wrapper - requires form library integration
          </p>
          <p>
            <strong>Input OTP:</strong>
            One-time password input - specialized input component
          </p>
          <p>
            <strong>Navigation Menu:</strong>
            Complex navigation with dropdowns - requires advanced state
            management
          </p>
          <p>
            <strong>Resizable:</strong>
            Resizable panels - requires react-resizable-panels equivalent
          </p>
          <p>
            <strong>Sonner:</strong>
            Toast notifications library - requires sonner integration
          </p>
          <p>
            <strong>Toast/Toaster:</strong>
            Toast notification system - fully implemented, use via service
          </p>
        </div>
      </section>
    </div>
  </template>
}

export default UiExamples;
