// Shared frontmatter parsing utility

export interface Frontmatter {
  title?: string;
  description?: string;
  order?: number;
  [key: string]: unknown;
}

export function parseFrontmatter(markdown: string): {
  frontmatter: Frontmatter;
  content: string;
} {
  const trimmed = markdown.trim();
  const frontmatterRegex = /^---\s*\n([\s\S]*?)\n---\s*\n([\s\S]*)$/;
  const match = trimmed.match(frontmatterRegex);

  if (!match) {
    return { frontmatter: {}, content: trimmed };
  }

  const [, frontmatterText, content] = match;
  const frontmatter: Frontmatter = {};

  // Parse simple YAML frontmatter (key: value pairs)
  if (frontmatterText) {
    frontmatterText.split('\n').forEach((line) => {
      const colonIndex = line.indexOf(':');
      if (colonIndex > -1) {
        const key = line.slice(0, colonIndex).trim();
        const value = line.slice(colonIndex + 1).trim();

        // Try to parse numbers
        if (key === 'order' && value) {
          const numValue = parseInt(value, 10);
          if (!isNaN(numValue)) {
            frontmatter[key] = numValue;
            return;
          }
        }

        frontmatter[key] = value;
      }
    });
  }

  return { frontmatter, content: content || '' };
}
