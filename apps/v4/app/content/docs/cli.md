---
title: CLI
description: Use the shadcn-ember CLI to add components to your project.
order: 22
---

## init

Use the `init` command to initialize configuration and dependencies for a new project.

The `init` command installs dependencies, adds the `cn` util and configures CSS variables for the project.

```bash
npx shadcn-ember@latest init
```

**Options**

```bash
Usage: shadcn-ember init [options] [components...]

initialize your project and install dependencies

Arguments:
  components         name, url or local path to component

Options:
  -b, --base-color <base-color>  the base color to use. (neutral, gray, zinc, stone, slate)
  -y, --yes                      skip confirmation prompt. (default: true)
  -f, --force                    force overwrite of existing configuration. (default: false)
  -c, --cwd <cwd>                the working directory. defaults to the current directory.
  -s, --silent                   mute output. (default: false)
  --css-variables                use css variables for theming. (default: true)
  --no-css-variables             do not use css variables for theming.
  --no-base-style                do not install the base shadcn style
  -h, --help                     display help for command
```

---

## add

Use the `add` command to add components and dependencies to your project.

```bash
npx shadcn-ember@latest add [component]
```

**Options**

```bash
Usage: shadcn-ember add [options] [components...]

add a component to your project

Arguments:
  components         name, url or local path to component

Options:
  -y, --yes           skip confirmation prompt. (default: false)
  -o, --overwrite     overwrite existing files. (default: false)
  -c, --cwd <cwd>     the working directory. defaults to the current directory.
  -a, --all           add all available components (default: false)
  -p, --path <path>   the path to add the component to.
  -s, --silent        mute output. (default: false)
  --css-variables     use css variables for theming. (default: true)
  --no-css-variables  do not use css variables for theming.
  -h, --help          display help for command
```

---

## view

Use the `view` command to view items from the registry before installing them.

```bash
npx shadcn-ember@latest view [item]
```

You can view multiple items at once:

```bash
npx shadcn-ember@latest view button card dialog
```

Or view items from namespaced registries:

```bash
npx shadcn-ember@latest view @acme/auth @v0/dashboard
```

**Options**

```bash
Usage: shadcn-ember view [options] <items...>

view items from the registry

Arguments:
  items            the item names or URLs to view

Options:
  -c, --cwd <cwd>  the working directory. defaults to the current directory.
  -h, --help       display help for command
```

---

## search

Use the `search` command to search for items from registries.

```bash
npx shadcn-ember@latest search [registry]
```

You can search with a query:

```bash
npx shadcn-ember@latest search @shadcn -q "button"
```

Or search multiple registries at once:

```bash
npx shadcn-ember@latest search @shadcn @v0 @acme
```

The `list` command is an alias for `search`:

```bash
npx shadcn-ember@latest list @acme
```

**Options**

```bash
Usage: shadcn-ember search|list [options] <registries...>

search items from registries

Arguments:
  registries             the registry names or urls to search items from. Names
                         must be prefixed with @.

Options:
  -c, --cwd <cwd>        the working directory. defaults to the current directory.
  -q, --query <query>    query string
  -l, --limit <number>   maximum number of items to display per registry (default: "100")
  -o, --offset <number>  number of items to skip (default: "0")
  -h, --help             display help for command
```

---

## list

Use the `list` command to list all items from a registry.

```bash
npx shadcn-ember@latest list @acme
```

**Options**

```bash
Usage: shadcn-ember list [options] <registries...>

list items from registries

Arguments:
  registries             the registry names or urls to list items from. Names
                         must be prefixed with @.

Options:
  -c, --cwd <cwd>        the working directory. defaults to the current directory.
  -q, --query <query>    query string
  -l, --limit <number>   maximum number of items to display per registry (default: "100")
  -o, --offset <number>  number of items to skip (default: "0")
  -h, --help             display help for command
```

---

## build

Use the `build` command to generate the registry JSON files.

```bash
npx shadcn-ember@latest build
```

This command reads the `registry.json` file and generates the registry JSON files in the `public/r` directory.

**Options**

```bash
Usage: shadcn-ember build [options] [registry]

build components for a shadcn registry

Arguments:
  registry             path to registry.json file (default: "./registry.json")

Options:
  -o, --output <path>  destination directory for json files (default: "./public/r")
  -c, --cwd <cwd>      the working directory. defaults to the current directory.
  -h, --help           display help for command
```

To customize the output directory, use the `--output` option.

```bash
npx shadcn-ember@latest build --output ./public/registry
```
