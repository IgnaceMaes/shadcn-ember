---
title: Changelog
description: Latest updates and announcements.
order: 10
---

## January 2026 - Initial release

I'm excited to announce the initial release of shadcn-ember!

In the recent years, significant work was made to modernize Ember and shape the Polaris edition. Vite has become the default build system, speeding up builds and unlocking a gigantic ecosystem of tools now compatible. Template tag components were introduced, solving component ergonomics. First-class TypeScript support with native types are available. And with Glint (built upon Volar.js) there is end-to-end type safety from templates to TypeScript. All of this makes Ember a solid foundation for building modern, ambitious web applications.

Yet, when starting a new Ember project, I felt like there was still something missing. While there are great component libraries available, they often come with their own design systems, or are not aligned with the modern Ember way of building components. Inspired by the success of `shadcn/ui` in the React ecosystem, I decided to create `shadcn-ember`, bringing the same design principles and component specs to Ember.

### Key design decisions

The following design decisions are taken intentionally, and will be maintained going forward:

1. Feature parity with `shadcn/ui` over improvements
    - By keeping component specs aligned, maintenance and updates are more straightforward.
    - Easier access to other shadcn ecosystem tools and resources, with minimal adjustments needed.
    - Extensions and customizations can be part of separate libraries, without affecting the core.
2. Compatibility with modern Ember only
    - While recognizing there exist numerous legacy Ember applications, this library focuses on leveraging the latest Ember features to ease maintenance and reduce complexity.
    - With minimal adaptations, components could be backported to older setups by end users.
2. Use of [Ember Context](https://github.com/emberjs/rfcs/pull/975) over contextual components
    - Aligns the composability of components with React and other frameworks.
    - Reduces the complexity of component usage by consumers.
    - As there is no native implementation in Ember yet, we rely on [ember-provide-consume-context](https://github.com/customerio/ember-provide-consume-context).
3. Usage of `@class` as component argument over splattibutes
    - By using an argument, we can merge the classes properly instead of overwriting them.
