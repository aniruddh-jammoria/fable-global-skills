---
name: wrap-session
description: Close out a work session - verify the changes work, update CHANGELOG.md and the devlog, catch README drift, and commit. Use when the user says to wrap up, finish the session, "let's stop here", or asks to commit completed work. Orchestrates the changelog, devlog, and readme skills so every session ends documented and committed.
---

# Wrap Up a Work Session

Close the session so the repo is left consistent: working code, updated docs, clean commits. Run the steps in order; report what each produced in the final summary.

Copy this checklist and check items off as you complete them:

```
Wrap-up progress:
- [ ] 1. Take stock — anything meaningful to wrap?
- [ ] 2. Work verified (STOP here if verification fails)
- [ ] 3. Docs updated: changelog / devlog / README drift
- [ ] 4. Committed — staging reviewed, no blanket add
- [ ] 5. Summary reported
```

## Step 1: Take stock

- `git status` and `git diff` (plus untracked files) to see everything this session touched.
- Recall from the conversation *why* each change was made — this feeds the docs below.
- If there are no meaningful changes (nothing changed, or only throwaway experiments), say so and stop. Do not manufacture log entries for trivial sessions.

## Step 2: Verify the work

Confirm the change actually works before documenting or committing it:
- Run the test suite if one exists.
- Exercise the changed behavior end-to-end (use the `verify` skill if it is available; otherwise run the app or the affected flow directly and observe the result).
- **If verification fails, stop here.** Report the failure and fix it (or ask) — never commit or document broken work as done.

## Step 3: Update the documentation

Each sub-step is an action, not a narration — actually perform it and confirm the file changed before moving on. If entries covering this session's work were already written earlier in the session, update them rather than appending duplicates.

1. Invoke the **changelog** skill — add entries under `[Unreleased]` for user-visible changes only. If the skill is unavailable, edit `CHANGELOG.md` directly in Keep a Changelog format (Added/Changed/Fixed etc. under `[Unreleased]`).
2. Invoke the **devlog** skill — write the dated entry for this session; include an ADR if a significant decision was made. If unavailable, append a dated entry (context / what was done / outcome) to the top of `docs/DEVLOG.md` directly.
3. README drift check: scan `README.md` for anything this session invalidated — renamed commands, changed config files or prompt templates, new/removed features, stale quick start. Fix small drift directly; for larger drift, invoke the **readme** skill (or restructure it directly if unavailable).

## Step 4: Commit

- Stage related changes and commit. Review the untracked-file list before staging — never use a blanket `git add -A` / `git add .`; never stage secrets, `.env` files, credentials, or build artifacts (add them to `.gitignore` instead). Split into a few logical commits if the session's work separates cleanly (feature vs docs is usually fine in one commit; unrelated fixes are not).
- Message style: imperative summary line ≤ 72 chars; follow the repo's existing convention (check `git log`) — use Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`) if the history does, or the repo has no convention yet.
- Do not push unless the user asked or the project's CLAUDE.md says pushing is the default.

## Step 5: Summarize

End with a short report: what was verified (and how), which docs were updated, what was committed, and anything left open for next session (also record open items in the devlog entry's Outcome line).

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Documenting unverified work** — Step 2 failing means stop; "the diff looks right" is not verification.
- **Blanket staging** — `git add -A` sweeps in secrets, `.env` files, and build artifacts; stage by name after reading the untracked list.
- **Manufactured entries** — a session with nothing meaningful produces no changelog or devlog lines; don't invent substance to have something to log.
