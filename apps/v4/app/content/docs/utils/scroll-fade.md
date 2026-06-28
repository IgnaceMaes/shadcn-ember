---
title: scroll-fade
description: Utilities for adding a fade effect to the edges of a scroll container.
---

<ComponentPreview name="scroll-fade-demo" />

Add `scroll-fade` or `scroll-fade-y` to the scroll container, i.e. the element
that has `overflow-y-auto`.

```hbs
<div class="scroll-fade overflow-y-auto">{{! ... }}</div>
```

The fade is scroll-aware and tracks the scroll position:

- At rest, the top edge is crisp and the bottom edge fades to hint at more content.
- As you scroll, a fade appears at the top and both edges stay faded mid-scroll.
- At the end, the bottom edge sharpens to show you have reached the last item.

The fade is applied with `mask-image`, so it dissolves the content itself rather
than overlaying a color. The mask uses a linear fade from transparent to black,
so it adapts to any background without configuration. If your scroll area sits
inside a card, put the background and border on a wrapper and `scroll-fade` on the
inner scroller, so the fade dissolves the content and not the card.

The [`ScrollArea`](/docs/components/scroll-area) component can use `scroll-fade`
on its scrollable viewport.

## Installation

The scroll-fade utilities ship with shadcn-ember and are already included in the
global stylesheet (`app/app.css`) when you scaffold a project. To add them to an
existing project, copy the following utilities into your global CSS file:

```css
/* scroll-fade */
@property --scroll-fade-t {
  syntax: '<length-percentage>';
  inherits: false;
  initial-value: 0;
}

@property --scroll-fade-b {
  syntax: '<length-percentage>';
  inherits: false;
  initial-value: 0;
}

@property --scroll-fade-s {
  syntax: '<length-percentage>';
  inherits: false;
  initial-value: 0;
}

@property --scroll-fade-e {
  syntax: '<length-percentage>';
  inherits: false;
  initial-value: 0;
}

@property --scroll-fade-mask {
  syntax: '*';
  inherits: false;
}

@theme inline {
  @keyframes scroll-fade-reveal-t {
    from {
      --scroll-fade-t: 0px;
    }

    to {
      --scroll-fade-t: var(
        --_scroll-fade-size-t,
        var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
      );
    }
  }

  @keyframes scroll-fade-reveal-b {
    from {
      --scroll-fade-b: var(
        --_scroll-fade-size-b,
        var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
      );
    }

    to {
      --scroll-fade-b: 0px;
    }
  }

  @keyframes scroll-fade-reveal-s {
    from {
      --scroll-fade-s: 0px;
    }

    to {
      --scroll-fade-s: var(
        --_scroll-fade-size-s,
        var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
      );
    }
  }

  @keyframes scroll-fade-reveal-e {
    from {
      --scroll-fade-e: var(
        --_scroll-fade-size-e,
        var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
      );
    }

    to {
      --scroll-fade-e: 0px;
    }
  }
}

@utility scroll-fade {
  --_scroll-fade-size-t: var(
    --scroll-fade-t-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --_scroll-fade-size-b: var(
    --scroll-fade-b-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-block: linear-gradient(
    to bottom,
    transparent 0,
    #000 var(--scroll-fade-t, 0px),
    #000 calc(100% - var(--scroll-fade-b, 0px)),
    transparent 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask, var(--scroll-fade-block));
  mask-image: var(--scroll-fade-mask, var(--scroll-fade-block));
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation:
      scroll-fade-reveal-t 1ms ease-in-out,
      scroll-fade-reveal-b 1ms ease-in-out;
    animation-timeline: scroll(self y), scroll(self y);
    animation-range:
      0 var(--scroll-fade-reveal, calc(var(--spacing) * 24)),
      calc(100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))) 100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-t: var(--_scroll-fade-size-t);
    --scroll-fade-b: var(--_scroll-fade-size-b);
  }
}

@utility scroll-fade-y {
  --_scroll-fade-size-t: var(
    --scroll-fade-t-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --_scroll-fade-size-b: var(
    --scroll-fade-b-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-block: linear-gradient(
    to bottom,
    transparent 0,
    #000 var(--scroll-fade-t, 0px),
    #000 calc(100% - var(--scroll-fade-b, 0px)),
    transparent 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask, var(--scroll-fade-block));
  mask-image: var(--scroll-fade-mask, var(--scroll-fade-block));
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation:
      scroll-fade-reveal-t 1ms ease-in-out,
      scroll-fade-reveal-b 1ms ease-in-out;
    animation-timeline: scroll(self y), scroll(self y);
    animation-range:
      0 var(--scroll-fade-reveal, calc(var(--spacing) * 24)),
      calc(100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))) 100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-t: var(--_scroll-fade-size-t);
    --scroll-fade-b: var(--_scroll-fade-size-b);
  }
}

@utility scroll-fade-x {
  --_scroll-fade-size-s: var(
    --scroll-fade-s-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --_scroll-fade-size-e: var(
    --scroll-fade-e-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-inline: linear-gradient(
    to right,
    transparent 0,
    #000 var(--scroll-fade-s, 0px),
    #000 calc(100% - var(--scroll-fade-e, 0px)),
    transparent 100%
  );

  &:where([dir='rtl'], [dir='rtl'] *) {
    --scroll-fade-inline: linear-gradient(
      to left,
      transparent 0,
      #000 var(--scroll-fade-s, 0px),
      #000 calc(100% - var(--scroll-fade-e, 0px)),
      transparent 100%
    );
  }

  -webkit-mask-image: var(--scroll-fade-mask, var(--scroll-fade-inline));
  mask-image: var(--scroll-fade-mask, var(--scroll-fade-inline));
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation:
      scroll-fade-reveal-s 1ms ease-in-out,
      scroll-fade-reveal-e 1ms ease-in-out;
    animation-timeline: scroll(self inline), scroll(self inline);
    animation-range:
      0 var(--scroll-fade-reveal, calc(var(--spacing) * 24)),
      calc(100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))) 100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-s: var(--_scroll-fade-size-s);
    --scroll-fade-e: var(--_scroll-fade-size-e);
  }
}

@utility scroll-fade-t {
  --_scroll-fade-size-t: var(
    --scroll-fade-t-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to bottom,
    transparent 0,
    #000 var(--scroll-fade-t, 0px),
    #000 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-t 1ms ease-in-out;
    animation-timeline: scroll(self y);
    animation-range: 0 var(--scroll-fade-reveal, calc(var(--spacing) * 24));
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-t: var(--_scroll-fade-size-t);
  }
}

@utility scroll-fade-b {
  --_scroll-fade-size-b: var(
    --scroll-fade-b-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to bottom,
    #000 0,
    #000 calc(100% - var(--scroll-fade-b, 0px)),
    transparent 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-b 1ms ease-in-out;
    animation-timeline: scroll(self y);
    animation-range: calc(
        100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))
      )
      100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-b: var(--_scroll-fade-size-b);
  }
}

@utility scroll-fade-l {
  --_scroll-fade-size-s: var(
    --scroll-fade-s-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to right,
    transparent 0,
    #000 var(--scroll-fade-s, 0px),
    #000 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-s 1ms ease-in-out;
    animation-timeline: scroll(self x);
    animation-range: 0 var(--scroll-fade-reveal, calc(var(--spacing) * 24));
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-s: var(--_scroll-fade-size-s);
  }
}

@utility scroll-fade-r {
  --_scroll-fade-size-e: var(
    --scroll-fade-e-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to right,
    #000 0,
    #000 calc(100% - var(--scroll-fade-e, 0px)),
    transparent 100%
  );

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-e 1ms ease-in-out;
    animation-timeline: scroll(self x);
    animation-range: calc(
        100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))
      )
      100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-e: var(--_scroll-fade-size-e);
  }
}

@utility scroll-fade-s {
  --_scroll-fade-size-s: var(
    --scroll-fade-s-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to right,
    transparent 0,
    #000 var(--scroll-fade-s, 0px),
    #000 100%
  );

  &:where([dir='rtl'], [dir='rtl'] *) {
    --scroll-fade-mask: linear-gradient(
      to left,
      transparent 0,
      #000 var(--scroll-fade-s, 0px),
      #000 100%
    );
  }

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-s 1ms ease-in-out;
    animation-timeline: scroll(self inline);
    animation-range: 0 var(--scroll-fade-reveal, calc(var(--spacing) * 24));
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-s: var(--_scroll-fade-size-s);
  }
}

@utility scroll-fade-e {
  --_scroll-fade-size-e: var(
    --scroll-fade-e-size,
    var(--scroll-fade-size, min(12%, calc(var(--spacing) * 10)))
  );
  --scroll-fade-mask: linear-gradient(
    to right,
    #000 0,
    #000 calc(100% - var(--scroll-fade-e, 0px)),
    transparent 100%
  );

  &:where([dir='rtl'], [dir='rtl'] *) {
    --scroll-fade-mask: linear-gradient(
      to left,
      #000 0,
      #000 calc(100% - var(--scroll-fade-e, 0px)),
      transparent 100%
    );
  }

  -webkit-mask-image: var(--scroll-fade-mask);
  mask-image: var(--scroll-fade-mask);
  -webkit-mask-composite: source-in;
  mask-composite: intersect;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;

  @supports (animation-timeline: scroll()) {
    animation: scroll-fade-reveal-e 1ms ease-in-out;
    animation-timeline: scroll(self inline);
    animation-range: calc(
        100% - var(--scroll-fade-reveal, calc(var(--spacing) * 24))
      )
      100%;
    animation-fill-mode: both;
  }

  @supports not (animation-timeline: scroll()) {
    --scroll-fade-e: var(--_scroll-fade-size-e);
  }
}

@utility scroll-fade-* {
  --scroll-fade-size: calc(var(--spacing) * --value(integer));
  --scroll-fade-size: --value([length], [percentage]);
}

@utility scroll-fade-t-* {
  --scroll-fade-t-size: calc(var(--spacing) * --value(integer));
  --scroll-fade-t-size: --value([length], [percentage]);
}

@utility scroll-fade-b-* {
  --scroll-fade-b-size: calc(var(--spacing) * --value(integer));
  --scroll-fade-b-size: --value([length], [percentage]);
}

@utility scroll-fade-s-* {
  --scroll-fade-s-size: calc(var(--spacing) * --value(integer));
  --scroll-fade-s-size: --value([length], [percentage]);
}

@utility scroll-fade-e-* {
  --scroll-fade-e-size: calc(var(--spacing) * --value(integer));
  --scroll-fade-e-size: --value([length], [percentage]);
}

@utility scroll-fade-none {
  --scroll-fade-mask: none;
}

/* scrollbar-none */
@utility scrollbar-none {
  scrollbar-width: none;

  &::-webkit-scrollbar {
    display: none;
  }
}
```

## Usage

| Class                             | Description                                                                    |
| --------------------------------- | ------------------------------------------------------------------------------ |
| `scroll-fade` / `scroll-fade-y`   | Scroll-aware fade on the top and bottom edges of a vertical scroller.          |
| `scroll-fade-x`                   | Scroll-aware fade on the inline edges of a horizontal scroller.                |
| `scroll-fade-t` / `scroll-fade-b` | Fade mask on the top / bottom edge only.                                       |
| `scroll-fade-l` / `scroll-fade-r` | Fade mask on the left / right physical edge only.                              |
| `scroll-fade-s` / `scroll-fade-e` | Fade mask on the start / end logical edge only. Mirrors in RTL.                |
| `scroll-fade-<number>`            | Sets the fade size on the spacing scale. Also accepts `scroll-fade-[<value>]`. |
| `scroll-fade-{t,b,s,e}-<number>`  | Sets the fade size for a single edge, overriding `scroll-fade-<number>`.       |
| `scroll-fade-none`                | Removes the fade.                                                              |

## No Overflow, No Fade

If the content does not overflow, no fade is shown. You can apply `scroll-fade` to
any list without checking whether it scrolls.

<ComponentPreview name="scroll-fade-overflow" />

## Horizontal Scrolling

Use `scroll-fade-x` on containers that scroll horizontally, i.e. the element that
has `overflow-x-auto`.

<ComponentPreview name="scroll-fade-horizontal" />

```hbs
<div class="flex scroll-fade-x overflow-x-auto">{{! ... }}</div>
```

`scroll-fade-<number>` and `scroll-fade-none` work the same for both axes.

## Edge Fades

Use edge utilities when only one edge should track the scroll position. Use
`scroll-fade-t`, `scroll-fade-b`, `scroll-fade-l`, and `scroll-fade-r` for
physical edges. Use `scroll-fade-s` and `scroll-fade-e` for logical inline edges.

<ComponentPreview name="scroll-fade-edge" class="!h-auto" />

```hbs
<div class="scroll-fade-b overflow-y-auto">{{! ... }}</div>
```

The edge utilities are scroll-aware. Start edges fade in after you scroll away
from the start, and end edges fade out when you reach the end.

## Fade Size

The fade depth defaults to 12% of the container, capped at 40px so tall scrollers
stay subtle. Use `scroll-fade-<number>` to set a fixed size on the spacing scale
instead, the same way `scroll-mt-<number>` works.

<ComponentPreview name="scroll-fade-size" class="!h-auto" />

```hbs
<div class="scroll-fade overflow-y-auto scroll-fade-24">{{! ... }}</div>
```

For one-off values, use an arbitrary length or percentage:

```hbs
<div class="scroll-fade overflow-y-auto scroll-fade-[15%]">{{! ... }}</div>
```

To fade opposite edges by different amounts, use the per-edge modifiers
`scroll-fade-t-<number>`, `scroll-fade-b-<number>`, `scroll-fade-s-<number>`, and
`scroll-fade-e-<number>`. They override `scroll-fade-<number>` on the edge they
target and accept arbitrary values too.

```hbs
<div class="scroll-fade overflow-y-auto scroll-fade-b-8 scroll-fade-t-2">
  {{! ... }}
</div>
```

The fade eases in and out over a fixed scroll distance rather than appearing
instantly. That distance is the `--scroll-fade-reveal` variable, `96px` by
default and independent of the fade depth. Lower it for a snappier reveal or
raise it for a more gradual one:

```hbs
<div class="scroll-fade overflow-y-auto [--scroll-fade-reveal:64px]">
  {{! ... }}
</div>
```

## Disabling the Fade

Use `scroll-fade-none` to remove the fade. It works in any class order, so the
typical use is responsive or stateful.

<ComponentPreview name="scroll-fade-none" class="!h-auto" />

```hbs
<div class="scroll-fade overflow-y-auto md:scroll-fade-none">
  {{! ... }}
</div>
```

## Fallback

The scroll-aware behavior is implemented with CSS scroll-driven animations, with
no JavaScript and no scroll listeners. In browsers that do not support
scroll-driven animations, `scroll-fade` falls back to a static fade on both edges,
and edge utilities fall back to a static fade on the selected edge.

Since the mask is applied to the scroll container itself, a visible scrollbar
fades with the content at the edges. Pair `scroll-fade` with `scrollbar-none`,
which ships in the same stylesheet, if you want to hide the scrollbar entirely.
