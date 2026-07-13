---
name: changelog
description: Create or update CHANGELOG.md in the Keep a Changelog format. Use when the user asks to update the changelog, log a new feature/fix, cut or release a version, or after completing a notable change that users would care about. Curates human-readable entries from the actual work done (conversation context and git history), never dumps commit messages.
---

# Maintain a Changelog

`CHANGELOG.md` (repo root) is a curated, reverse-chronological record of **notable changes for the humans who use the project** — not a commit log, and not a development diary (internal reasoning belongs in the devlog).

Follow the [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/) format.

## Step 1: Locate or create the file

If `CHANGELOG.md` exists, read it and **match its existing conventions** (heading style, date format, whether it uses versions or dates). Append to it; never regenerate it.

If it does not exist, create it:

```markdown
# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]
```

If the repo has history but no changelog, do **not** backfill every commit — add at most a short summary entry for the current state, then maintain it going forward.

## Step 2: Determine what changed

Sources, in order of reliability:
1. Work completed in the current session (you know exactly what changed and why).
2. `git log` since the last changelog entry's date or the last version tag — as raw material to curate, never to paste.

## Step 3: Write curated entries under `[Unreleased]`

**First, read what is already in `[Unreleased]`** — if an entry from earlier in the session (or a previous run of this skill) already covers a change, update that line rather than appending a duplicate.

Group entries under exactly these headings (only the ones you need):
**Added, Changed, Deprecated, Removed, Fixed, Security.**

Each entry:
- One line, plain language, **from the user's perspective**: what they can now do or what behaves differently — not which files or functions changed.
  - Good: `- Added --dry-run flag to preview changes without applying them`
  - Bad: `- Refactored apply() in executor.py to support dry_run param`
- Skip pure-internal changes (refactors with no behavior change, tooling, CI). Those go in the devlog instead.

## Step 4: Releasing a version (only when asked)

When the user cuts a release, rename `[Unreleased]` to `[X.Y.Z] - YYYY-MM-DD` (semver: breaking → major, feature → minor, fix → patch), and add a fresh empty `[Unreleased]` above it. For projects without formal versions, calendar versions (`## [2026.07.13]`, promoted at release/push time) or dated milestone headings (`## 2026-07-09`) are acceptable — follow whichever convention the file already uses; the file's header should state which scheme it follows.

## Rules

- Newest entries at the top; never rewrite or delete released entries.
- Never fabricate dates or versions — versions come from tags/manifest; dates come from git history or from the environment (`git log -1 --format=%cd --date=short`, or the system clock via `date` / `Get-Date`). Never write a date from memory.
- If a change is user-visible **and** involved a notable decision, it appears in both the changelog (the what) and the devlog (the why) — one line each, different framing.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Commit-dump entries** — file or function names in an entry mean it was written from the diff, not the user's perspective; git log is raw material to curate.
- **Duplicate [Unreleased] lines** — read what's already there first; a change logged earlier in the session gets updated, not re-appended.
- **Dates from memory** — dates come from git or the system clock, always.
