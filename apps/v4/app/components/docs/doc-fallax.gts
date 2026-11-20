import type { TOC } from '@ember/component/template-only';

interface DocFallaxSignature {
  Element: HTMLDivElement;
}

const DocFallax: TOC<DocFallaxSignature> = <template>
  <div class="flex flex-col gap-2" ...attributes>
    <p class="text-muted-foreground text-[0.7rem]">
      Sponsored by
    </p>
    <a
      class="text-muted-foreground hover:text-foreground flex items-start gap-2.5 no-underline transition-colors"
      href="https://fallax.io"
      rel="noopener noreferrer"
      target="_blank"
    >
      <svg
        aria-hidden="true"
        class="mt-0.5 size-5 shrink-0"
        fill="currentColor"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path d="M4.2 2.8H20.4V7.4H8.8V9.6L4.2 12.2Z" />
        <path d="M4.2 14.8 8.8 12.2V10.4H17.6V15H8.8V21.2H4.2Z" />
      </svg>
      <span class="flex flex-col gap-0.5">
        <span class="text-foreground text-[0.8rem] font-medium leading-none">
          Fallax
        </span>
        <span class="text-[0.7rem] leading-snug">
          Phishing simulation and security awareness training on autopilot
        </span>
      </span>
    </a>
  </div>
</template>;

export default DocFallax;
