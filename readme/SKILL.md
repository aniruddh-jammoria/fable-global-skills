---
name: readme
description: Create or update a repository README.md. Use when the user asks to write, improve, refresh, or audit a README, when a new project needs one, or after significant features change what the project does. Surveys the actual code first so the README reflects reality, preserves accurate existing content, and follows a proven structure (title, why, demo, quick start, usage, links out to deeper docs).
---

# Write or Update a README

A README is the front door of a repository, not its documentation. It must answer three questions in the first screen: **what** the project does, **who** it is for, and **why** it exists. Target 500–1500 words; link out to anything deeper.

## Step 1: Understand the project from its code

Never write a README from assumptions. Survey first:

- Package manifests (`package.json`, `pyproject.toml`, `Cargo.toml`, etc.) for name, scripts, entry points, dependencies.
- The main entry point and top-level source layout — what does it actually do (CLI? UI? server? library?)
- `CLAUDE.md`, `docs/`, existing `CHANGELOG.md` / `docs/DEVLOG.md` — link to these rather than duplicating them.
- How the project is actually run and installed (verify the commands you will document really exist — e.g., the script names in the manifest).
- User-editable surfaces: config files (`config.*`, `.env.example`, `settings.*`), prompt templates, themes — anything a user can customize without touching code. These feed the Configuration section.

## Step 2: Handle an existing README

If `README.md` exists: **the structure below always wins; existing content is reused where it is accurate.** Consistency across repos is the point — an existing README that deviates from the structure gets restructured, not patched in place.

1. Read it fully and inventory its content: which facts, examples, and custom touches (badges, credits, acknowledgments) are accurate and worth keeping?
2. **Rebuild the file in the canonical section order below**, migrating each piece of accurate existing content into the section where it belongs. Reuse good prose verbatim — restructuring is not an excuse to reword what already reads well.
3. While migrating, fix stale facts: commands that no longer work, features that changed, dead links. Content that belongs in linked docs (deep API detail, contribution rules) moves out, replaced by a link.
4. Preserved custom content that has no canonical section (badges at top, credits/acknowledgments near the end) keeps a sensible home — don't delete it just because the template doesn't name it.
5. Drop content only when it is stale or redundant. If you are unsure whether something is obsolete, keep it and flag it to the user rather than silently dropping it.

The result must match the canonical structure even if the old README was organized completely differently. In your summary, list which sections' content was migrated, what was updated, and anything dropped or flagged.

If no README exists, create one from the structure below.

## Step 3: Structure

Use these sections in this order. Sections marked *(optional)* only if they earn their space.

```markdown
# Project Name
Badge row (shields.io, one line): license, language/runtime version,
package version, build status — see badge rules below.

One-sentence description of what it does.

Short paragraph: the problem it solves and why it exists (the "why").

## Demo
Screenshot / GIF / terminal recording. If none exists yet, insert a
placeholder comment: <!-- TODO: add screenshot/demo -->

## How it works
A short paragraph (or 3–5 numbered steps) bridging description to usage:
what the user provides (input, config, credentials), what happens under
the hood (the one-sentence version — pipeline, agent loop, transform),
and what comes out at the end. A reader should finish it knowing the
shape of the workflow before seeing a single command. Keep component
depth out — that belongs in Architecture.

## Quick start
Copy-paste-ready install + first-run commands, verified against the repo.

## Usage
The 1–3 most common workflows, each with a working example.

## Configuration & customization (include whenever the project has any)
Everything a user can change without touching code: config files, prompt
templates, environment variables, flags. For each: where it lives, what it
controls, and a short annotated example of the most useful customization.
If extensive, document the top 3–5 here and link a full reference doc.

## Architecture                  (optional — for non-trivial projects)
How the pieces fit: 3–6 sentences or a small diagram (Mermaid works on
GitHub) covering the main components and the flow between them. Follow
with a short annotated repo tree (top-level dirs only, one comment each).
If it needs more than ~20 lines, move the depth to docs/ARCHITECTURE.md
and keep only the overview here.

## Roadmap / Status              (optional)

## Changelog & development notes
Links to CHANGELOG.md and docs/DEVLOG.md if they exist.

## Contributing                  (optional — link CONTRIBUTING.md if present)
## License
```

## Badge rules

- 3–6 badges, one row, directly under the title. Use shields.io static or
  dynamic badges (e.g. `![License: MIT](https://img.shields.io/badge/license-MIT-blue)`,
  `https://img.shields.io/badge/python-3.12%2B-blue`).
- **Every badge must be derived from a repo fact**: license from LICENSE,
  runtime version from the manifest (`requires-python`, `engines`), package
  version from the registry if published, CI status only if a workflow exists.
  Never guess a value; wrong badges are worse than none.
- Worth including when true: license, language/runtime version, package
  version, build/CI status, platform (CLI/web). Skip vanity badges: stars,
  visitor counters, "PRs welcome", "made with" — they carry no information.

## Rules

- **Every command must work verbatim.** Check it against the manifest/scripts before writing it. Never invent flags or scripts.
- **Show, don't tell** — prefer one concrete example over three paragraphs of description.
- **Don't inline deep docs.** API references, contribution guides, and decision rationale get linked, not pasted.
- Write in plain, direct language. No filler ("blazingly fast", "simple yet powerful") unless demonstrably true.
- If the repo has a `CHANGELOG.md` or `docs/DEVLOG.md`, always link them from the README.
- State clearly in your summary which sections you added, updated, and preserved.
