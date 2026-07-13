---
name: new-project
description: Scaffold a new project repository with the standard structure - README skeleton, CHANGELOG.md, docs/DEVLOG.md, docs/adr/, CLAUDE.md with self-documenting instructions, license, .gitignore, and a stack-appropriate entry point - then git init and first commit. Use when the user starts a new project, says "scaffold", "set up a repo", or "new project".
---

# Scaffold a New Project

Create a repository that starts consistent with the standard conventions, so documentation and structure never have to be retrofitted.

## Step 1: Gather the essentials

Ask only for what can't be inferred (skip questions the user's request already answers):
1. Project name and one-line purpose.
2. Form: CLI, web UI, server/API, or library.
3. Stack (Node/TypeScript, Python, etc.).
4. License (default: MIT).

**Safety check:** if the target directory already contains files, list them and confirm before writing anything. Never scaffold over an existing project.

## Step 2: Create the skeleton

```
<project>/
  README.md            ← structure from the readme skill: title, one-liner,
                          why-paragraph, <!-- TODO: demo -->, Quick start,
                          Usage, Configuration placeholders, links to
                          CHANGELOG.md and docs/DEVLOG.md, License
  CHANGELOG.md         ← Keep a Changelog header + empty [Unreleased]
  CLAUDE.md            ← see Step 3
  LICENSE
  .gitignore           ← stack-appropriate
  docs/
    DEVLOG.md          ← header only (per the devlog skill)
    adr/               ← if the stack choice was a real decision, write
                          0001-<stack-choice>.md capturing why
    specs/             ← empty; the spec skill writes here
  src/ (or stack norm) ← minimal runnable entry point ("hello" behavior),
                          plus manifest (package.json / pyproject.toml)
                          with real name, description, and a working
                          run/test script
```

Follow the stack's own conventions for layout and tooling defaults (e.g., `src/` layout and a formatter/linter config only if the stack norm expects one). The entry point must actually run — verify it before finishing.

## Step 3: CLAUDE.md contents

Keep it short (this is context loaded every session):

```markdown
# <Project name>
<One-line purpose.>

## Commands
- run: <verified command>
- test: <verified command>

## Conventions
- After completing a feature or notable change, update CHANGELOG.md
  ([Unreleased]) and add a docs/DEVLOG.md entry; write an ADR in
  docs/adr/ for significant decisions.
- New features start with a spec in docs/specs/ (use the spec skill).
```

## Step 4: Initialize

1. `git init`, stage everything, initial commit: `chore: scaffold project`.
2. Offer to create the GitHub repo (`gh repo create <name> --public --source . --push`) — ask before doing this; creating a public repo is outward-facing.

## Step 5: Summarize

Report the tree that was created, the verified run/test commands, and the natural next step (write the first spec with the spec skill).

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Scaffolding over existing files** — a non-empty target directory halts everything until the user confirms.
- **Unverified entry point** — the "hello" behavior must actually run before finishing; a scaffold that doesn't start is a broken promise.
- **Unprompted public repo** — `gh repo create` is outward-facing; always ask first.
