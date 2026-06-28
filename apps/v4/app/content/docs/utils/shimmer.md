---
title: shimmer
description: Utilities for adding a shimmer effect to text elements.
---

<ComponentPreview name="shimmer-demo" />

The `shimmer` utility animates a highlight across a text element, a subtle way to
signal that something is streaming or in progress.

The shimmer is built on `currentColor`, so it adapts to the element:

- The highlight is derived from the text color, with no configuration needed.
- It works on any color, from `text-muted-foreground` to brand colors.
- In dark mode, the highlight automatically brightens to stay visible.

The effect is pure CSS. The text is painted with `background-clip: text`, and the
highlight sweeps across it in a seamless loop.

## Installation

The shimmer utilities ship with shadcn-ember and are already included in the
global stylesheet (`app/app.css`) when you scaffold a project. To add them to an
existing project, copy the following utilities into your global CSS file:

```css
/* shimmer */
@property --shimmer-angle {
  syntax: '<angle>';
  inherits: true;
  initial-value: 20deg;
}

@property --shimmer-image {
  syntax: '*';
  inherits: false;
}

@property --shimmer-text-fill {
  syntax: '*';
  inherits: false;
}

@theme inline {
  @keyframes tw-shimmer {
    from {
      background-position: 100% 0;
    }

    to {
      background-position: 0 0;
    }
  }
}

@utility shimmer {
  --_spread: var(--shimmer-spread, calc(3ch + 40px));
  --_base: currentcolor;
  --_highlight: var(
    --shimmer-color,
    oklch(from currentColor l c h / calc(alpha* 0.2))
  );

  background-image: var(
    --shimmer-image,
    linear-gradient(
      calc(90deg + var(--shimmer-angle)),
      var(--_base) calc(50% - var(--_spread)),
      color-mix(in oklch, var(--_highlight), var(--_base) 50%)
        calc(50% - var(--_spread) * 0.5),
      var(--_highlight) 50%,
      color-mix(in oklch, var(--_highlight), var(--_base) 50%)
        calc(50% + var(--_spread) * 0.5),
      var(--_base) calc(50% + var(--_spread))
    )
  );
  background-repeat: no-repeat;
  background-size: calc(200% + var(--_spread) * 2) 100%;
  background-position: 0 0;
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: var(--shimmer-text-fill, transparent);
  animation: tw-shimmer var(--shimmer-duration, 2s) linear infinite;

  @variant dark {
    --_highlight: var(
      --shimmer-color,
      oklch(from currentColor max(0.8, calc(l + 0.4)) c h / calc(alpha + 0.4))
    );
  }

  &:where([dir='rtl'], [dir='rtl'] *) {
    animation-direction: reverse;
  }
}

@utility shimmer-once {
  animation-iteration-count: 1;
}

@utility shimmer-reverse {
  animation-direction: reverse;
}

@utility shimmer-none {
  --shimmer-image: none;
  --shimmer-text-fill: currentcolor;
}

@utility shimmer-color-* {
  --shimmer-color: --value(--color, [color]);
  --shimmer-color: color-mix(
    in oklch,
    --value(--color, [color]) calc(--modifier(integer) * 1%),
    transparent
  );
}

@utility shimmer-duration-* {
  --shimmer-duration: calc(--value(integer) * 1ms);
}

@utility shimmer-spread-* {
  --shimmer-spread: calc(var(--spacing) * --value(integer));
  --shimmer-spread: --value([length], [percentage]);
}

@utility shimmer-angle-* {
  --shimmer-angle: calc(--value(integer) * 1deg);
}

@media (prefers-reduced-motion: reduce) {
  .shimmer {
    animation: none;
    background-image: none;
    -webkit-text-fill-color: currentcolor;
  }
}
```

## Usage

Add `shimmer` to a text element.

```hbs
<p class="shimmer text-muted-foreground">Generating response…</p>
```

| Class                       | Description                                                                                                                |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `shimmer`                   | Paints the text with `background-clip: text` and animates the highlight sweep in a loop.                                   |
| `shimmer-once`              | Plays a single sweep instead of looping.                                                                                   |
| `shimmer-reverse`           | Sweeps the highlight in the opposite direction.                                                                            |
| `shimmer-none`              | Turns the effect off and renders the text normally.                                                                        |
| `shimmer-color-<color>`     | Sets the highlight color. Accepts a theme color with optional `/<pct>` opacity, or an arbitrary `shimmer-color-[<value>]`. |
| `shimmer-duration-<number>` | Sets the duration of one sweep in milliseconds. Defaults to `2000`.                                                        |
| `shimmer-spread-<number>`   | Sets the width of the highlight band on the spacing scale. Also accepts `shimmer-spread-[<value>]`.                        |
| `shimmer-angle-<number>`    | Sets the tilt of the highlight band in degrees. Defaults to `20`.                                                          |

## With Marker

The shimmer composes with any component that renders text. A common pattern is a
[`Marker`](/docs/components/marker) showing a live status while the assistant is
working.

<ComponentPreview name="shimmer-marker" />

## Color

Use `shimmer-color-<color>` to set the highlight color explicitly. It accepts
theme colors with an optional opacity modifier, or any arbitrary color value.

<ComponentPreview name="shimmer-color" />

```hbs
<p class="shimmer shimmer-color-blue-500/60">Generating response…</p>
<p class="shimmer shimmer-color-[#378ADD]">Generating response…</p>
```

## Duration

Use `shimmer-duration-<number>` to set the duration of one sweep in
milliseconds. The default is `2000`, i.e. `2s`.

<ComponentPreview name="shimmer-duration" />

```hbs
<p class="shimmer shimmer-duration-1000">Generating response…</p>
```

## Spread

Use `shimmer-spread-<number>` to set the width of the highlight band using the
spacing scale. The default is `calc(3ch + 40px)`: a fixed base plus a `3ch` term
that scales with the font size.

<ComponentPreview name="shimmer-spread" />

For one-off values, use an arbitrary length or percentage:

```hbs
<p class="shimmer shimmer-spread-[5rem]">Generating response…</p>
```

## Angle

Use `shimmer-angle-<number>` to set the tilt of the highlight band in degrees.
The default is `20`.

<ComponentPreview name="shimmer-angle" />

```hbs
<p class="shimmer shimmer-angle-45">Generating response…</p>
```

## Reverse

Use `shimmer-reverse` to sweep the highlight in the opposite direction.

```hbs
<p class="shimmer shimmer-reverse">Generating response…</p>
```

## Play Once

Use `shimmer-once` to play a single sweep instead of looping, useful as a reveal
when streaming completes. Pair it with `shimmer-duration-<number>` to control how
long the sweep takes.

<ComponentPreview name="shimmer-once" />

```hbs
<p class="shimmer shimmer-duration-1100 shimmer-once">Response generated.</p>
```

## Disabling the Shimmer

Use `shimmer-none` to turn the effect off and render the text normally. It works
in any class order, so the typical use is responsive or stateful.

<ComponentPreview name="shimmer-none" />

```hbs
<p class="shimmer md:shimmer-none">Generating response…</p>
```

## Fallback

The shimmer is built on modern color features, relative color syntax and
`color-mix()`, which are available in all current browsers. In older browsers
without support, the highlight gradient is dropped and the text can render
transparent. If you target older browsers, apply `shimmer` conditionally with a
`supports-*` variant:

```hbs
<p class="supports-[color:oklch(from_white_l_c_h)]:shimmer">
  Generating response…
</p>
```

## Reduced Motion

When the user prefers reduced motion, the animation is disabled automatically and
the text renders normally. There is nothing to configure.
