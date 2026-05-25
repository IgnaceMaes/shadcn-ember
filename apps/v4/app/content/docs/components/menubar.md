---
title: Menubar
description: A visually persistent menu common in desktop applications that provides quick access to a consistent set of commands.
---

<ComponentPreview name="menubar-demo" />

## Installation

### CLI

```bash
npx shadcn-ember@latest add menubar
```

### Manual

**Install the following dependencies:**

```bash
pnpm add @floating-ui/dom ember-click-outside ember-provide-consume-context
```

**Copy and paste the menubar component into your project:**

<ComponentSource name="menubar" />

**Update the import paths to match your project setup.**

## Usage

```gts showLineNumbers
import {
  Menubar,
  MenubarContent,
  MenubarGroup,
  MenubarItem,
  MenubarMenu,
  MenubarSeparator,
  MenubarShortcut,
  MenubarTrigger,
} from '@/components/ui/menubar';
```

```hbs showLineNumbers
<Menubar>
  <MenubarMenu>
    <MenubarTrigger>File</MenubarTrigger>
    <MenubarContent>
      <MenubarGroup>
        <MenubarItem>
          New Tab
          <MenubarShortcut>⌘T</MenubarShortcut>
        </MenubarItem>
        <MenubarItem>New Window</MenubarItem>
      </MenubarGroup>
      <MenubarSeparator />
      <MenubarGroup>
        <MenubarItem>Share</MenubarItem>
        <MenubarItem>Print</MenubarItem>
      </MenubarGroup>
    </MenubarContent>
  </MenubarMenu>
</Menubar>
```

## Composition

Use the following composition to build a Menubar:

```
Menubar
├── MenubarMenu
│   ├── MenubarTrigger
│   └── MenubarContent
│       ├── MenubarGroup
│       │   ├── MenubarLabel
│       │   ├── MenubarItem
│       │   └── MenubarItem
│       ├── MenubarSeparator
│       ├── MenubarGroup
│       │   ├── MenubarLabel
│       │   ├── MenubarCheckboxItem
│       │   └── MenubarCheckboxItem
│       ├── MenubarSeparator
│       ├── MenubarGroup
│       │   ├── MenubarLabel
│       │   └── MenubarRadioGroup
│       │       ├── MenubarRadioItem
│       │       └── MenubarRadioItem
│       └── MenubarSub
│           ├── MenubarSubTrigger
│           └── MenubarSubContent
│               └── MenubarGroup
│                   ├── MenubarLabel
│                   ├── MenubarItem
│                   └── MenubarItem
└── MenubarMenu
    ├── MenubarTrigger
    └── MenubarContent
        └── MenubarGroup
            ├── MenubarLabel
            ├── MenubarItem
            └── MenubarItem
```

## Examples

### Checkbox

Use `MenubarCheckboxItem` for toggleable options.

<ComponentPreview name="menubar-checkbox" />

### Radio

Use `MenubarRadioGroup` and `MenubarRadioItem` for single-select options.

<ComponentPreview name="menubar-radio" />

### Submenu

Use `MenubarSub`, `MenubarSubTrigger`, and `MenubarSubContent` for nested menus.

<ComponentPreview name="menubar-submenu" />

### With Icons

<ComponentPreview name="menubar-icons" />
