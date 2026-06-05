import type { Rule } from "eslint";

type GlimmerElementNode = Rule.Node & {
  tag: string;
  blockParams?: string[];
  attributes?: GlimmerAttrNode[];
  children?: Rule.Node[];
  modifiers?: Rule.Node[];
};

type GlimmerAttrNode = Rule.Node & {
  name: string;
  value?: Rule.Node;
};

type PropRequirement = {
  prop: string;
  kind: "attribute" | "modifier";
  names?: string[];
};

const AS_CHILD_COMPONENTS = new Map<string, PropRequirement[]>([
  [
    "Badge",
    [{ prop: "classes", kind: "attribute", names: ["class", "@class"] }],
  ],
  [
    "BreadcrumbLink",
    [{ prop: "classes", kind: "attribute", names: ["class", "@class"] }],
  ],
  [
    "Button",
    [{ prop: "classes", kind: "attribute", names: ["class", "@class"] }],
  ],
  [
    "DropdownMenuItem",
    [{ prop: "classes", kind: "attribute", names: ["class", "@class"] }],
  ],
  ["DropdownMenuTrigger", [{ prop: "modifiers", kind: "modifier" }]],
  ["HoverCardTrigger", [{ prop: "modifiers", kind: "modifier" }]],
  ["PopoverTrigger", [{ prop: "modifiers", kind: "modifier" }]],
  [
    "Item",
    [
      { prop: "class", kind: "attribute", names: ["class", "@class"] },
      { prop: "slot", kind: "attribute", names: ["data-slot"] },
      { prop: "variant", kind: "attribute", names: ["data-variant"] },
      { prop: "size", kind: "attribute", names: ["data-size"] },
    ],
  ],
  [
    "CollapsibleTrigger",
    [
      { prop: "onClick", kind: "modifier" },
      { prop: "aria-controls", kind: "attribute", names: ["aria-controls"] },
      { prop: "aria-expanded", kind: "attribute", names: ["aria-expanded"] },
      { prop: "data-disabled", kind: "attribute", names: ["data-disabled"] },
      { prop: "data-state", kind: "attribute", names: ["data-state"] },
      { prop: "disabled", kind: "attribute", names: ["disabled"] },
    ],
  ],
]);

function isGlimmerElementNode(value: Rule.Node): value is GlimmerElementNode {
  return value.type === "GlimmerElementNode";
}

function getAttr(
  node: GlimmerElementNode,
  name: string,
): GlimmerAttrNode | undefined {
  return node.attributes?.find((attr) => attr.name === name);
}

function isFalseLiteral(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: Rule.Node,
): boolean {
  return sourceCode.getText(node) === "{{false}}";
}

function hasEnabledAsChildArg(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: GlimmerElementNode,
): boolean {
  const asChildAttr = getAttr(node, "@asChild");

  if (!asChildAttr) {
    return false;
  }

  if (asChildAttr.value && isFalseLiteral(sourceCode, asChildAttr.value)) {
    return false;
  }

  return true;
}

function getBlockParam(node: GlimmerElementNode): string | undefined {
  return node.blockParams?.[0];
}

function hasYieldedPropReference(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: Rule.Node,
  blockParam: string,
  prop: string,
): boolean {
  return sourceCode.getText(node).includes(`${blockParam}.${prop}`);
}

function hasAttributeRequirement(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: GlimmerElementNode,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  return Boolean(
    node.attributes?.some((attr) => {
      if (!requirement.names?.includes(attr.name)) {
        return false;
      }

      return hasYieldedPropReference(
        sourceCode,
        attr,
        blockParam,
        requirement.prop,
      );
    }),
  );
}

function hasModifierRequirement(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: GlimmerElementNode,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  const expectedModifier = `${blockParam}.${requirement.prop}`;

  if (sourceCode.getText(node).includes(`{{${expectedModifier}}}`)) {
    return true;
  }

  if (
    node.modifiers?.some((modifier) =>
      sourceCode.getText(modifier).includes(expectedModifier),
    )
  ) {
    return true;
  }

  return Boolean(
    node.modifiers?.some((modifier) =>
      hasYieldedPropReference(
        sourceCode,
        modifier,
        blockParam,
        requirement.prop,
      ),
    ),
  );
}

function childSatisfiesRequirement(
  sourceCode: Rule.RuleContext["sourceCode"],
  child: Rule.Node,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  if (!isGlimmerElementNode(child)) {
    return false;
  }

  if (requirement.kind === "attribute") {
    return hasAttributeRequirement(sourceCode, child, blockParam, requirement);
  }

  return hasModifierRequirement(sourceCode, child, blockParam, requirement);
}

function getMissingPropsForChild(
  sourceCode: Rule.RuleContext["sourceCode"],
  child: Rule.Node,
  blockParam: string,
  requirements: PropRequirement[],
): string[] {
  return requirements
    .filter(
      (requirement) =>
        !childSatisfiesRequirement(sourceCode, child, blockParam, requirement),
    )
    .map((requirement) => requirement.prop);
}

function getMissingProps(
  sourceCode: Rule.RuleContext["sourceCode"],
  node: GlimmerElementNode,
  blockParam: string,
  requirements: PropRequirement[],
): string[] {
  const glimmerChildren = node.children?.filter(isGlimmerElementNode) ?? [];

  if (glimmerChildren.length === 0) {
    return requirements.map((requirement) => requirement.prop);
  }

  return glimmerChildren.reduce<string[]>(
    (bestMissingProps, child) => {
      const missingProps = getMissingPropsForChild(
        sourceCode,
        child,
        blockParam,
        requirements,
      );

      return missingProps.length < bestMissingProps.length
        ? missingProps
        : bestMissingProps;
    },
    requirements.map((requirement) => requirement.prop),
  );
}

function formatMissingProps(props: string[]): string {
  return props.map((prop) => `\`${prop}\``).join(", ");
}

const rule: Rule.RuleModule = {
  meta: {
    type: "problem",
    docs: {
      description:
        "require applying yielded properties when using `@asChild` on shadcn-ember components",
      category: "Best Practices",
      url: "https://github.com/IgnaceMaes/shadcn-ember/blob/main/packages/cli/docs/rules/require-as-child-props.md",
    },
    schema: [],
    messages: {
      missingBlockParam:
        "Use a block param with `{{componentName}}` when passing `@asChild` so the yielded properties can be applied.",
      missingYieldedProps:
        "Apply the yielded {{properties}} from `{{blockParam}}` when using `@asChild` on `{{componentName}}`.",
    },
  },

  create(context) {
    const sourceCode = context.sourceCode;

    return {
      GlimmerElementNode(node: Rule.Node) {
        if (!isGlimmerElementNode(node)) {
          return;
        }

        const requirements = AS_CHILD_COMPONENTS.get(node.tag);

        if (!requirements || !hasEnabledAsChildArg(sourceCode, node)) {
          return;
        }

        const blockParam = getBlockParam(node);

        if (!blockParam) {
          context.report({
            node,
            messageId: "missingBlockParam",
            data: { componentName: node.tag },
          });
          return;
        }

        const missingProps = getMissingProps(
          sourceCode,
          node,
          blockParam,
          requirements,
        );

        if (missingProps.length > 0) {
          context.report({
            node,
            messageId: "missingYieldedProps",
            data: {
              blockParam,
              componentName: node.tag,
              properties: formatMissingProps(missingProps),
            },
          });
        }
      },
    };
  },
};

export default rule;
