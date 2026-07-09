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

If `README.md` exists, **update it — do not rewrite it wholesale**:

1. Read it fully.
2. Keep sections that are accurate and any intentional custom content (badges, credits, tone).
3. Fix stale facts: commands that no longer work, features that changed, dead links.
4. Add missing sections from the structure below; remove content that belongs in linked docs.
5. If a section would be deleted or heavily rewritten and you are unsure it is obsolete, ask the user rather than silently dropping it.

If none exists, create one from the structure below.

## Step 3: Structure

Use these sections in this order. Sections marked *(optional)* only if they earn their space.

```markdown
# Project Name
One-sentence description of what it does.

Short paragraph: the problem it solves and why it exists (the "why").

## Demo
Screenshot / GIF / terminal recording. If none exists yet, insert a
placeholder comment: <!-- TODO: add screenshot/demo -->

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

## Rules

- **Every command must work verbatim.** Check it against the manifest/scripts before writing it. Never invent flags or scripts.
- **Show, don't tell** — prefer one concrete example over three paragraphs of description.
- **Don't inline deep docs.** API references, contribution guides, and decision rationale get linked, not pasted.
- Write in plain, direct language. No filler ("blazingly fast", "simple yet powerful") unless demonstrably true.
- If the repo has a `CHANGELOG.md` or `docs/DEVLOG.md`, always link them from the README.
- State clearly in your summary which sections you added, updated, and preserved.
