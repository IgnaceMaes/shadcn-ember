import { click, find, getRootElement, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import {
  AlertDialog,
  AlertDialogContent,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import {
  ContextMenu,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuTrigger,
} from '@/components/ui/context-menu';
import {
  Dialog,
  DialogContent,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';
import { Drawer, DrawerContent, DrawerTitle } from '@/components/ui/drawer';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from '@/components/ui/hover-card';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from '@/components/ui/popover';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Sheet, SheetContent, SheetTitle } from '@/components/ui/sheet';
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from '@/components/ui/tooltip';
import { setupRenderingTest } from 'shadcn-ember-docs/tests/helpers';

module('Integration | portals', function (hooks) {
  setupRenderingTest(hooks);

  function assertInRoot(assert: Assert, selector: string) {
    const element = find(selector);

    assert.ok(element, `${selector} is found with test helpers`);
    assert.ok(
      getRootElement().contains(element),
      `${selector} is portaled into the application root element`
    );
  }

  test('dialog content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Dialog>
          <DialogTrigger>Open</DialogTrigger>
          <DialogContent>
            <DialogTitle>Title</DialogTitle>
            <button data-test-action type="button">Action</button>
          </DialogContent>
        </Dialog>
      </template>
    );

    assert.dom('[data-slot="dialog-content"]').doesNotExist();

    await click('[data-slot="dialog-trigger"]');

    assertInRoot(assert, '[data-slot="dialog-content"]');
    assert.dom('[data-slot="dialog-title"]').hasText('Title');

    await click('[data-test-action]');
  });

  test('alert dialog content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <AlertDialog @open={{true}}>
          <AlertDialogContent>
            <AlertDialogTitle>Title</AlertDialogTitle>
          </AlertDialogContent>
        </AlertDialog>
      </template>
    );

    assertInRoot(assert, '[data-slot="alert-dialog-content"]');
  });

  test('sheet content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Sheet @open={{true}}>
          <SheetContent>
            <SheetTitle>Title</SheetTitle>
          </SheetContent>
        </Sheet>
      </template>
    );

    assertInRoot(assert, '[data-slot="sheet-content"]');
  });

  test('drawer content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Drawer @open={{true}}>
          <DrawerContent>
            <DrawerTitle>Title</DrawerTitle>
          </DrawerContent>
        </Drawer>
      </template>
    );

    assertInRoot(assert, '[data-slot="drawer-content"]');
  });

  test('popover content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Popover @open={{true}}>
          <PopoverTrigger>Open</PopoverTrigger>
          <PopoverContent>Content</PopoverContent>
        </Popover>
      </template>
    );

    assertInRoot(assert, '[data-slot="popover-content"]');
  });

  test('hover card content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <HoverCard @open={{true}}>
          <HoverCardTrigger>Hover</HoverCardTrigger>
          <HoverCardContent>Content</HoverCardContent>
        </HoverCard>
      </template>
    );

    assertInRoot(assert, '[data-slot="hover-card-content"]');
  });

  test('tooltip content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Tooltip @open={{true}}>
          <TooltipTrigger>Hover</TooltipTrigger>
          <TooltipContent>Content</TooltipContent>
        </Tooltip>
      </template>
    );

    assertInRoot(assert, '[data-slot="tooltip-content"]');
  });

  test('dropdown menu content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <DropdownMenu @open={{true}}>
          <DropdownMenuTrigger>Open</DropdownMenuTrigger>
          <DropdownMenuContent>
            <DropdownMenuItem>Item</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </template>
    );

    assertInRoot(assert, '[data-slot="dropdown-menu-content"]');
  });

  test('context menu content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <ContextMenu @open={{true}}>
          <ContextMenuTrigger>Right click</ContextMenuTrigger>
          <ContextMenuContent>
            <ContextMenuItem>Item</ContextMenuItem>
          </ContextMenuContent>
        </ContextMenu>
      </template>
    );

    assertInRoot(assert, '[data-slot="context-menu-content"]');
  });

  test('select content is rendered inside the root element', async function (assert) {
    await render(
      <template>
        <Select>
          <SelectTrigger>
            <SelectValue @placeholder="Select a fruit" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem @value="apple">Apple</SelectItem>
            <SelectItem @value="banana">Banana</SelectItem>
          </SelectContent>
        </Select>
      </template>
    );

    await click('[data-slot="select-trigger"]');

    assertInRoot(assert, '[data-slot="select-content"]');

    await click('[data-slot="select-item"]:nth-of-type(2)');

    assert.dom('[data-slot="select-value"]').hasText('Banana');
  });
});
