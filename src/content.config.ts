// content.config.ts — defines the shape of every content collection.
// Zod validates each Markdown file's frontmatter against these schemas
// AT BUILD TIME. A missing/mistyped field fails the build with a clear error.

import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

// --- PUBLICATIONS -------------------------------------------------
const publications = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/publications" }),
  schema: z.object({
    title:   z.string(),
    authors: z.string(),
    year:    z.number(),
    venue:   z.string(),
    doi:     z.string().url(),          // must be a valid URL
    pdf:     z.string().url().optional(),  // optional link
    code:    z.string().url().optional(),  // optional link
  }),
});

// --- PROJECTS -----------------------------------------------------
const projects = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/projects" }),
  schema: z.object({
    title:   z.string(),
    status:  z.enum(["active", "archived", "wip"]),  // only these 3 allowed
    summary: z.string(),
    stack:   z.array(z.string()).optional(),  // a list of strings
    link:    z.string().url().optional(),
  }),
});

// --- WRITING ------------------------------------------------------
const writing = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/writing" }),
  schema: z.object({
    title: z.string(),
    date:  z.date(),                    // a real date, parsed & validated
    tags:  z.array(z.string()).optional(),
  }),
});

// Register all collections so Astro knows about them.
export const collections = { publications, projects, writing };