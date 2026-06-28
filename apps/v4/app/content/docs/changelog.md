---
title: Changelog
description: Latest updates and announcements.
order: 10
---

## July 2026 - Components for Chat Interfaces

A new set of components and utilities for building chat interfaces is now available: [Message](/docs/components/message), [Bubble](/docs/components/bubble), [Attachment](/docs/components/attachment), and [Marker](/docs/components/marker), along with two CSS utilities, [scroll-fade](/docs/utils/scroll-fade) and [shimmer](/docs/utils/shimmer).

This is the conversation layer: message rows, bubbles, attachments, and markers. They are intentionally small, and meant to be composed together for AI chats, support inboxes, team threads, group chats, and product-specific conversations.

```bash
npx shadcn-ember@latest add message bubble attachment marker
```

### Message

The [Message](/docs/components/message) component lays out a single row in a conversation: avatar, alignment, header, content, and footer. It handles the layout around the message surface so you can drop your content in, and `MessageGroup` keeps consecutive messages from the same author together.

For AI apps, you can render reasoning steps, tool calls, and assistant replies through `Message`.

### Bubble

The [Bubble](/docs/components/bubble) component renders the message surface itself. It ships with variants, start/end alignment, reactions, links, buttons, and collapsible content.

`Bubble` is intentionally scoped to the bubble surface — use it for chat text, short structured output, quoted replies, and suggestions. Place avatars, names, timestamps, and message-level actions in `Message`.

### Attachment

The [Attachment](/docs/components/attachment) component displays files and images with media, metadata, upload state, and actions. It supports `idle`, `uploading`, `processing`, `error`, and `done` states, multiple sizes and orientations, and a full-card trigger that keeps individual actions separately clickable. Use `AttachmentGroup` for rows of attachments in a composer or message thread.

### Marker

The [Marker](/docs/components/marker) component renders inline conversation markers: status updates, system notes, bordered rows, and labeled separators. Use it for streaming state, tool activity, and date breaks, composed alongside `Message` in a thread.

### scroll-fade and shimmer

Two new CSS utilities cover the details that make chat interfaces feel better.

[scroll-fade](/docs/utils/scroll-fade) adds scroll-aware edge fades to scroll containers. Use it on long lists, attachment rows, and any scrollable region where you want to hint at more content without overlays or scroll listeners. It supports per-axis and per-edge variants (`scroll-fade-y`, `scroll-fade-x`, `scroll-fade-t`, `scroll-fade-b`, …) and a configurable fade size.

[shimmer](/docs/utils/shimmer) adds a text shimmer for live status, ideal for "Thinking…", "Generating response…", running tools, and streaming markers. It's configurable via `shimmer-once`, `shimmer-reverse`, and the `shimmer-color`, `shimmer-duration`, `shimmer-spread`, and `shimmer-angle` modifiers.

Both utilities ship with `shadcn/tailwind.css`, so projects initialized with shadcn-ember already have them.

---

## June 2026 - Calendar & Date Picker

Two new components are now available: [Calendar](/docs/components/calendar) and [Date Picker](/docs/components/date-picker).

### Calendar

The `Calendar` component provides a full-featured date selection UI built on top of [date-fns](https://date-fns.org). It supports single and range selection modes, month/year dropdown navigation, week numbers, custom cell sizing, booked date indicators, and a built-in time picker.

```bash
npx shadcn-ember@latest add calendar
```

Key features:

- **Single & range selection** — Use `@mode="single"` or `@mode="range"` to switch between modes.
- **Dropdown caption** — Use `@captionLayout="dropdown"` for month and year dropdowns, useful for date-of-birth pickers.
- **Custom cell size** — Adjust cell dimensions with the `--cell-size` CSS variable, including responsive breakpoint values.
- **Week numbers** — Enable with `@showWeekNumber`.
- **Disabled & booked dates** — Pass dates or a predicate function to `@disabled`, or use `@modifiers` and `@modifiersClassNames` for custom styling.
- **Time picker** — Combine the calendar with a time input for full date-time selection.
- **Timezone support** — Use `@timeZone` to ensure dates are interpreted in the correct timezone.

### Date Picker

The [Date Picker](/docs/components/date-picker) page documents how to compose `<Popover>` and `<Calendar>` into a date picker — there is no separate `DatePicker` component. This keeps the API flexible and composable.

Examples include a basic date picker, range picker, date of birth selector, input-based picker, and a time picker variant.

---

## May 2026 - ESLint Plugin

shadcn-ember now ships a built-in [ESLint plugin](/docs/eslint) to help you catch common mistakes when using components.

### `shadcn-ember/require-class-arg`

The first rule, `require-class-arg`, enforces using `@class` instead of `class` on shadcn-ember component invocations. When you pass `class` as a regular HTML attribute, it gets forwarded via `...attributes` (splattributes) and bypasses the component's internal class merging logic using `cn()` / `cva()`. This can lead to unexpected styling where your classes don't get properly merged with the component's variant classes.

The rule is auto-fixable — running `eslint --fix` will automatically replace `class` with `@class` on known shadcn-ember components.

### Setup

Add the recommended config to your ESLint configuration:

```js title="eslint.config.mjs"
import { configs as shadcnEmberConfigs } from 'shadcn-ember/eslint';

export default [
  // ...your other config
  ...shadcnEmberConfigs.recommended,
];
```

See the [ESLint Plugin](/docs/eslint) page for full documentation, or check the updated [installation guides](/docs/installation).

---

## January 2026 - Initial release

I'm excited to announce the initial release of shadcn-ember!

In the recent years, significant work was made to modernize Ember and shape the [Polaris edition](https://emberjs.com/editions/polaris/). [Vite](https://vite.dev/) has become the default build system, speeding up builds and unlocking a gigantic ecosystem of tools now compatible. Template tag components were introduced, solving component ergonomics. First-class TypeScript support with native types are available. And with [Glint](https://typed-ember.gitbook.io/glint) (built upon [Volar.js](https://volarjs.dev/)) there is end-to-end type safety from templates to TypeScript. All of this makes Ember a solid foundation for building modern, ambitious web applications.

Yet, when starting a new Ember project, I felt like there was still something missing. While there are great component libraries available, they often come with their own design systems, or are not aligned with the modern Ember way of building components. Inspired by the success of [shadcn/ui](https://ui.shadcn.com/) in the React ecosystem, I decided to create `shadcn-ember`, bringing the same design principles and component specs to Ember.

### Key design decisions

The following design decisions are taken intentionally, and will be maintained going forward:

1. Feature parity with `shadcn/ui` over improvements
   - By keeping component specs aligned, maintenance and updates are more straightforward.
   - Easier access to other shadcn ecosystem tools and resources, with minimal adjustments needed.
   - Extensions and customizations can be part of separate libraries, without affecting the core.
   - AI coding tools can better assist engineers due to prior shadcn/ui knowledge.
2. Compatibility with modern Ember only
   - While recognizing there exist numerous legacy Ember applications, this library focuses on leveraging the latest Ember features to ease maintenance and reduce complexity.
   - With minimal adaptations, components could be backported to older setups by end users.
3. Use of [Ember Context](https://github.com/emberjs/rfcs/pull/975) over contextual components
   - Aligns the composability of components with React and other frameworks.
   - Reduces the complexity of component usage by consumers.
   - As there is no native implementation in Ember yet, we rely on [ember-provide-consume-context](https://github.com/customerio/ember-provide-consume-context).
4. Usage of `@class` as component argument over splattibutes
   - By using an argument, we can merge the classes properly instead of overwriting them.

### Call for maintainers

This project is ambitious, and will require ongoing maintenance to keep up with both the Ember ecosystem and the shadcn/ui updates. If you are interested in contributing or helping maintain this library, please do so via GitHub!
