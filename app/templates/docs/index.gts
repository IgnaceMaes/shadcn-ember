import {
  DocPage,
  DocHeader,
  DocContent,
  DocHeading,
  DocParagraph,
  DocList,
  DocListItem,
  DocStrong,
  DocEmphasis,
} from '@/components/docs';

<template>
  <DocPage>
    <DocHeader
      @title="Introduction"
      @description="Build your own component library with beautiful, accessible components."
    />

    <DocContent>
      <DocParagraph>
        <DocStrong>This is not a component library. It is how you build your
          component library.</DocStrong>
      </DocParagraph>

      <DocParagraph>
        You know how most traditional component libraries work: you install a
        package from NPM, import the components, and use them in your app.
      </DocParagraph>

      <DocParagraph>
        This approach works well until you need to customize a component to fit
        your design system or require one that isn't included in the library.
        <DocStrong>Often, you end up wrapping library components, writing
          workarounds to override styles, or mixing components from different
          libraries with incompatible APIs.</DocStrong>
      </DocParagraph>

      <DocParagraph>
        This is what shadcn-ember aims to solve. It is built around the
        following principles:
      </DocParagraph>

      <DocList>
        <DocListItem><DocStrong>Open Code:</DocStrong>
          The top layer of your component code is open for modification.</DocListItem>
        <DocListItem><DocStrong>Composition:</DocStrong>
          Every component uses a common, composable interface, making them
          predictable.</DocListItem>
        <DocListItem><DocStrong>Distribution:</DocStrong>
          A flat-file schema and command-line tool make it easy to distribute
          components.</DocListItem>
        <DocListItem><DocStrong>Beautiful Defaults:</DocStrong>
          Carefully chosen default styles, so you get great design
          out-of-the-box.</DocListItem>
        <DocListItem><DocStrong>AI-Ready:</DocStrong>
          Open code for LLMs to read, understand, and improve.</DocListItem>
      </DocList>

      <DocHeading id="open-code">Open Code</DocHeading>

      <DocParagraph>
        shadcn-ember hands you the actual component code. You have full control
        to customize and extend the components to your needs. This means:
      </DocParagraph>

      <DocList>
        <DocListItem><DocStrong>Full Transparency:</DocStrong>
          You see exactly how each component is built.</DocListItem>
        <DocListItem><DocStrong>Easy Customization:</DocStrong>
          Modify any part of a component to fit your design and functionality
          requirements.</DocListItem>
        <DocListItem><DocStrong>AI Integration:</DocStrong>
          Access to the code makes it straightforward for LLMs to read,
          understand, and even improve your components.</DocListItem>
      </DocList>

      <DocParagraph>
        <DocEmphasis>In a typical library, if you need to change a button's
          behavior, you have to override styles or wrap the component. With
          shadcn-ember, you simply edit the button code directly.</DocEmphasis>
      </DocParagraph>

      <DocHeading id="composition">Composition</DocHeading>

      <DocParagraph>
        Every component in shadcn-ember shares a common, composable interface.
        <DocStrong>If a component does not exist, we bring it in, make it
          composable, and adjust its style to match and work with the rest of
          the design system.</DocStrong>
      </DocParagraph>

      <DocParagraph>
        <DocEmphasis>A shared, composable interface means it's predictable for
          both your team and LLMs. You are not learning different APIs for every
          new component. Even for third-party ones.</DocEmphasis>
      </DocParagraph>

      <DocHeading id="distribution">Distribution</DocHeading>

      <DocParagraph>
        shadcn-ember is also a code distribution system. It defines a schema for
        components and a CLI to distribute them.
      </DocParagraph>

      <DocList>
        <DocListItem><DocStrong>Schema:</DocStrong>
          A flat-file structure that defines the components, their dependencies,
          and properties.</DocListItem>
        <DocListItem><DocStrong>CLI:</DocStrong>
          A command-line tool to distribute and install components across
          projects with cross-framework support.</DocListItem>
      </DocList>

      <DocParagraph>
        <DocEmphasis>You can use the schema to distribute your components to
          other projects or have AI generate completely new components based on
          existing schema.</DocEmphasis>
      </DocParagraph>

      <DocHeading id="beautiful-defaults">Beautiful Defaults</DocHeading>

      <DocParagraph>
        shadcn-ember comes with a large collection of components that have
        carefully chosen default styles. They are designed to look good on their
        own and to work well together as a consistent system:
      </DocParagraph>

      <DocList>
        <DocListItem><DocStrong>Good Out-of-the-Box:</DocStrong>
          Your UI has a clean and minimal look without extra work.</DocListItem>
        <DocListItem><DocStrong>Unified Design:</DocStrong>
          Components naturally fit with one another. Each component is built to
          match the others, keeping your UI consistent.</DocListItem>
        <DocListItem><DocStrong>Easily Customizable:</DocStrong>
          If you want to change something, it's simple to override and extend
          the defaults.</DocListItem>
      </DocList>

      <DocHeading id="ai-ready">AI-Ready</DocHeading>

      <DocParagraph>
        The design of shadcn-ember makes it easy for AI tools to work with your
        code. Its open code and consistent API allow AI models to read,
        understand, and even generate new components.
      </DocParagraph>

      <DocParagraph>
        <DocEmphasis>An AI model can learn how your components work and suggest
          improvements or even create new components that integrate with your
          existing design.</DocEmphasis>
      </DocParagraph>
    </DocContent>
  </DocPage>
</template>
