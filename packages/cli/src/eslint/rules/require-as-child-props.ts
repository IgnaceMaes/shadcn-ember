import type { Rule } from "eslint";

type GlimmerNode = Rule.Node & {
  tag?: string;
  name?: string;
  value?: unknown;
  blockParams?: string[];
  attributes?: GlimmerNode[];
  children?: GlimmerNode[];
  modifiers?: GlimmerNode[];
  path?: GlimmerNode;
  params?: GlimmerNode[];
  hash?: {
    pairs?: Array<{ value?: GlimmerNode }>;
  } | null;
  head?: {
    type: string;
    name?: string;
  };
  tail?: string[];
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
      { prop: "data-slot", kind: "attribute", names: ["data-slot"] },
      { prop: "data-state", kind: "attribute", names: ["data-state"] },
      { prop: "disabled", kind: "attribute", names: ["disabled"] },
    ],
  ],
]);

function isGlimmerElementNode(value: Rule.Node): value is GlimmerNode {
  return value.type === "GlimmerElementNode";
}

function getAttr(node: GlimmerNode, name: string): GlimmerNode | undefined {
  return node.attributes?.find((attr) => attr.name === name);
}

function asNode(value: unknown): GlimmerNode | undefined {
  return value && typeof value === "object"
    ? (value as GlimmerNode)
    : undefined;
}

function isYieldedPropPath(
  node: GlimmerNode | undefined,
  blockParam: string,
  prop: string,
): boolean {
  return Boolean(
    node &&
    node.type === "GlimmerPathExpression" &&
    node.head?.type === "VarHead" &&
    node.head.name === blockParam &&
    node.tail?.length === 1 &&
    node.tail[0] === prop,
  );
}

function hashContainsYieldedPropReference(
  hash: GlimmerNode["hash"],
  blockParam: string,
  prop: string,
): boolean {
  return Boolean(
    hash?.pairs?.some((pair) =>
      nodeContainsYieldedPropReference(pair.value, blockParam, prop),
    ),
  );
}

function nodeContainsYieldedPropReference(
  node: GlimmerNode | undefined,
  blockParam: string,
  prop: string,
): boolean {
  if (!node) {
    return false;
  }

  if (isYieldedPropPath(node, blockParam, prop)) {
    return true;
  }

  if (node.type === "GlimmerMustacheStatement") {
    return (
      isYieldedPropPath(node.path, blockParam, prop) ||
      Boolean(
        node.params?.some((param) =>
          nodeContainsYieldedPropReference(param, blockParam, prop),
        ),
      ) ||
      hashContainsYieldedPropReference(node.hash, blockParam, prop)
    );
  }

  if (node.type === "GlimmerHash") {
    return hashContainsYieldedPropReference(node, blockParam, prop);
  }

  return false;
}

function isFalseLiteral(node: GlimmerNode | undefined): boolean {
  if (!node) {
    return false;
  }

  return (
    node.type === "GlimmerMustacheStatement" &&
    node.path?.type === "GlimmerBooleanLiteral" &&
    node.path.value === false
  );
}

function hasEnabledAsChildArg(node: GlimmerNode): boolean {
  const asChildAttr = getAttr(node, "@asChild");

  if (!asChildAttr) {
    return false;
  }

  if (isFalseLiteral(asNode(asChildAttr.value))) {
    return false;
  }

  return true;
}

function getBlockParam(node: GlimmerNode): string | undefined {
  return node.blockParams?.[0];
}

function hasAttributeRequirement(
  node: GlimmerNode,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  return Boolean(
    node.attributes?.some((attr) => {
      if (!requirement.names?.includes(attr.name)) {
        return false;
      }

      return nodeContainsYieldedPropReference(
        asNode(attr.value),
        blockParam,
        requirement.prop,
      );
    }),
  );
}

function hasModifierRequirement(
  node: GlimmerNode,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  return Boolean(
    node.modifiers?.some((modifier) => {
      if (modifier.type !== "GlimmerElementModifierStatement") {
        return false;
      }

      if (requirement.prop === "modifiers") {
        return isYieldedPropPath(modifier.path, blockParam, requirement.prop);
      }

      return (
        isYieldedPropPath(modifier.path, blockParam, requirement.prop) ||
        Boolean(
          modifier.params?.some((param) =>
            nodeContainsYieldedPropReference(
              param,
              blockParam,
              requirement.prop,
            ),
          ),
        ) ||
        hashContainsYieldedPropReference(
          modifier.hash,
          blockParam,
          requirement.prop,
        )
      );
    }),
  );
}

function childSatisfiesRequirement(
  child: Rule.Node,
  blockParam: string,
  requirement: PropRequirement,
): boolean {
  if (!isGlimmerElementNode(child)) {
    return false;
  }

  if (requirement.kind === "attribute") {
    return hasAttributeRequirement(child, blockParam, requirement);
  }

  return hasModifierRequirement(child, blockParam, requirement);
}

function getMissingPropsForChild(
  child: Rule.Node,
  blockParam: string,
  requirements: PropRequirement[],
): string[] {
  return requirements
    .filter(
      (requirement) =>
        !childSatisfiesRequirement(child, blockParam, requirement),
    )
    .map((requirement) => requirement.prop);
}

function getMissingProps(
  node: GlimmerNode,
  blockParam: string,
  requirements: PropRequirement[],
): string[] {
  const glimmerChildren = getDescendantElements(node);

  if (glimmerChildren.length === 0) {
    return requirements.map((requirement) => requirement.prop);
  }

  return glimmerChildren.reduce<string[]>(
    (bestMissingProps, child) => {
      const missingProps = getMissingPropsForChild(
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

function getDescendantElements(node: GlimmerNode): GlimmerNode[] {
  const descendants: GlimmerNode[] = [];

  for (const child of node.children ?? []) {
    if (!isGlimmerElementNode(child)) {
      continue;
    }

    descendants.push(child, ...getDescendantElements(child));
  }

  return descendants;
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
    return {
      GlimmerElementNode(node: Rule.Node) {
        if (!isGlimmerElementNode(node)) {
          return;
        }

        const requirements = AS_CHILD_COMPONENTS.get(node.tag);

        if (!requirements || !hasEnabledAsChildArg(node)) {
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

        const missingProps = getMissingProps(node, blockParam, requirements);

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
