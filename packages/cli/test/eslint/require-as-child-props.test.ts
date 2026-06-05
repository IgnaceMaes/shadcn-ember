import { RuleTester } from "eslint";
import { describe, it } from "vitest";

import rule from "../../src/eslint/rules/require-as-child-props";

function wrapGjs(code: string): string {
  return `<template>${code}</template>`;
}

// eslint-disable-next-line @typescript-eslint/no-require-imports
const gjsParser = require("ember-eslint-parser");

describe("require-as-child-props", () => {
  const ruleTester = new RuleTester({
    languageOptions: {
      parser: gjsParser,
      ecmaVersion: 2022,
      sourceType: "module",
      parserOptions: {
        filePath: "test.gts",
      },
    },
  });

  const valid = [
    "<Button>Login</Button>",
    "<Button @asChild={{false}}>Login</Button>",
    '<Button @asChild={{true}} as |button|><LinkTo @route="index" class={{button.classes}}>Login</LinkTo></Button>',
    '<Button @asChild={{this.isLink}} as |button|><LinkTo @route="index" class={{cn button.classes "w-full"}}>Login</LinkTo></Button>',
    '<Badge @asChild={{true}} as |badge|><LinkTo @route="index" class={{badge.classes}}>Badge</LinkTo></Badge>',
    '<BreadcrumbLink @asChild={{true}} as |link|><LinkTo @route="index" class={{link.classes}}>Home</LinkTo></BreadcrumbLink>',
    '<DropdownMenuItem @asChild={{true}} as |item|><LinkTo @route="index" class={{item.classes}}>Profile</LinkTo></DropdownMenuItem>',
    '<Button @asChild={{true}} as |button|><div><LinkTo @route="index" class={{button.classes}}>Login</LinkTo></div></Button>',
    "<DropdownMenuTrigger @asChild={{true}} as |trigger|><Button {{trigger.modifiers}}>Open</Button></DropdownMenuTrigger>",
    "<DropdownMenuTrigger @asChild={{true}} as |trigger|><div><Button {{trigger.modifiers}}>Open</Button></div></DropdownMenuTrigger>",
    "<PopoverTrigger @asChild={{true}} as |trigger|><button {{trigger.modifiers}}>Open</button></PopoverTrigger>",
    '<HoverCardTrigger @asChild={{true}} as |trigger|><a href="#" {{trigger.modifiers}}>Hover</a></HoverCardTrigger>',
    `<Item @asChild={{true}} as |item|>
      <a class={{item.class}} data-size={{item.size}} data-slot={{item.slot}} data-variant={{item.variant}} href="#">Item</a>
    </Item>`,
    `<CollapsibleTrigger @asChild={{true}} as |trigger|>
      <Button
        aria-controls={{trigger.aria-controls}}
        aria-expanded={{trigger.aria-expanded}}
        data-disabled={{trigger.data-disabled}}
        data-slot={{trigger.data-slot}}
        data-state={{trigger.data-state}}
        disabled={{trigger.disabled}}
        {{on "click" trigger.onClick}}
      >Toggle</Button>
    </CollapsibleTrigger>`,
    "<DialogTrigger @asChild={{true}}><Button>Open</Button></DialogTrigger>",
    "<MyComponent @asChild={{true}}><Button>Open</Button></MyComponent>",
  ];

  const invalid = [
    {
      code: '<Button @asChild={{true}}><LinkTo @route="index">Login</LinkTo></Button>',
      errors: [{ messageId: "missingBlockParam" as const }],
    },
    {
      code: '<Button @asChild={{true}} as |button|><LinkTo @route="index">Login</LinkTo></Button>',
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: '<Button @asChild={{true}} as |button|><LinkTo @route="index" class="button.classes">Login</LinkTo></Button>',
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: '<Button @asChild={{true}} as |button|><LinkTo @route="index" class={{this.button.classes}}>Login</LinkTo></Button>',
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: '<Badge @asChild={{true}} as |badge|><LinkTo @route="index">Badge</LinkTo></Badge>',
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: "<DropdownMenuTrigger @asChild={{true}} as |trigger|><Button>Open</Button></DropdownMenuTrigger>",
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: "<DropdownMenuTrigger @asChild={{true}} as |trigger|><Button>Open {{trigger.modifiers}}</Button></DropdownMenuTrigger>",
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: "<DropdownMenuTrigger @asChild={{true}} as |trigger|><Button {{some-modifier trigger.modifiers}}>Open</Button></DropdownMenuTrigger>",
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: `<Item @asChild={{true}} as |item|>
        <a class={{item.class}} data-slot={{item.slot}} href="#">Item</a>
      </Item>`,
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
    {
      code: `<CollapsibleTrigger @asChild={{true}} as |trigger|>
        <Button
          aria-controls={{trigger.aria-controls}}
          aria-expanded={{trigger.aria-expanded}}
          data-state={{trigger.data-state}}
          disabled={{trigger.disabled}}
        >Toggle</Button>
      </CollapsibleTrigger>`,
      errors: [{ messageId: "missingYieldedProps" as const }],
    },
  ];

  describe("gjs/gts", () => {
    it("passes valid and invalid cases", () => {
      ruleTester.run("require-as-child-props", rule, {
        valid: valid.map((code) => ({ code: wrapGjs(code) })),
        invalid: invalid.map((entry) => ({
          ...entry,
          code: wrapGjs(entry.code),
        })),
      });
    });
  });
});
