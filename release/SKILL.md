---
name: release
description: Cut a versioned release - pre-flight checks, choose the semver bump from [Unreleased] changelog content, promote it to a dated version, bump the manifest version, commit, tag, and draft a GitHub release. Use only when the user explicitly asks to release, ship, tag, or cut a version - never proactively.
---

# Cut a Release

Releasing is deliberate: every step gates the next, and the user confirms the version before anything irreversible happens.

Copy this checklist and check items off as you complete them:

```
Release progress:
- [ ] 1. Pre-flight passed: clean tree, tests, [Unreleased] non-empty, README quick start
- [ ] 2. Version proposed and CONFIRMED BY THE USER
- [ ] 3. Changelog promoted, manifest bumped
- [ ] 4. Committed, tagged, pushed, GitHub release drafted
- [ ] 5. Summary with tag + release URL
```

## Step 1: Pre-flight (all must pass)

1. Working tree clean (`git status`) — uncommitted work means run the **wrap-session** skill first.
2. Tests pass / the app runs (verify the same way wrap-session Step 2 does).
3. `CHANGELOG.md` has a non-empty `[Unreleased]` section. Empty → nothing to release; stop and say so.
4. README quick-start commands still work as documented.

Report any failure and stop — never release around a failed check.

## Step 2: Choose the version

Read `[Unreleased]` and propose a semver bump from the current version (manifest or latest git tag; no tags yet → propose `0.1.0`):
- Breaking change for users → **major** (while pre-1.0, breaking → minor is acceptable; say so).
- New features (`Added`) → **minor**.
- Only fixes/tweaks → **patch**.

If the changelog uses calendar versions (`[YYYY.MM.DD]`) or dated milestones instead of semver, the proposed version is today's date from the system clock — no bump reasoning needed.

**Ask the user to confirm the version number before proceeding.** This is the one mandatory pause.

## Step 3: Update files

1. `CHANGELOG.md`: rename `[Unreleased]` → `[X.Y.Z] - YYYY-MM-DD` (date from the system clock — `date` / `Get-Date` — never from memory); insert a fresh empty `## [Unreleased]` above it. (Follow the changelog skill's conventions; if the file uses dated milestones instead of versions, follow that.)
2. Bump the version field in the manifest (`package.json`, `pyproject.toml`, etc.). Use the ecosystem's own tool when it exists (`npm version --no-git-tag-version`, `poetry version`); otherwise edit directly.

## Step 4: Commit, tag, publish

1. Commit: `chore(release): vX.Y.Z`
2. Annotated tag: `git tag -a vX.Y.Z -m "vX.Y.Z"`
3. Push commit and tag: `git push && git push --tags`
4. GitHub release: `gh release create vX.Y.Z --title "vX.Y.Z" --notes-file <notes>` — notes adapted from the new changelog section: lead with the 1–2 changes that matter most, written for users; link the full changelog. Skip gracefully if there is no GitHub remote or `gh` isn't authenticated (report it; the tag still stands).

Package registry publishing (npm, PyPI) is **not** part of this skill — only do it if the user explicitly asks.

## Step 5: Summarize

Report: version released, tag, GitHub release URL, and the headline changes. If any step was skipped (no remote, no `gh`), say which and how to finish manually.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Skipping the version pause** — the user must confirm the version number explicitly; "release it" is not consent to a specific version.
- **Releasing around a failed check** — a dirty tree, failing tests, or an empty [Unreleased] each halt the release; fix, don't work around.
- **Dates or versions from memory** — the version comes from the manifest/tags, the date from the system clock.
