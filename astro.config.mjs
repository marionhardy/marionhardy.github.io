// @ts-check
import { defineConfig } from 'astro/config';
import remarkWikiLink from 'remark-wiki-link';

export default defineConfig({
  site: 'https://marionhardy.github.io',
  markdown: {
    remarkPlugins: [
      [remarkWikiLink, {
        hrefTemplate: (permalink) => `/${permalink}`,
        pageResolver: (name) => [name.replace(/ /g, '-').toLowerCase()],
      }],
    ],
  },
});