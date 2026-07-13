---
name: spec
description: Turn a product or feature idea into a short written spec in docs/specs/ before any code is written - problem, target user, goals and non-goals, key flows, success criteria, open questions. Use when the user describes something new to build ("I want to build...", "add a feature that...", "spec this out") and no spec exists yet. Sits upstream of implementation planning - the spec answers what and why; plan mode answers how.
---

# Write a Product Spec

Force clarity on **what** and **why** before anyone (including Claude) decides **how**. The output is a one-to-two-page markdown spec; the test of a good one is that a stranger could tell what's in scope, what's out, and how success is judged.

## Step 1: Interview — briefly, and with pushback

Ask only questions whose answers aren't already in the user's request or the repo. The essentials:

1. **Problem:** What is painful/impossible today? For whom?
2. **User:** Who exactly uses this? (One primary persona; "everyone" is a red flag — push back.)
3. **Smallest version:** What is the minimum that proves the idea works?
4. **Success:** How will we know it worked? Concrete and observable.

Act like a good product counterpart, not a stenographer:
- Challenge scope creep: propose cutting anything not needed for the smallest version — cut items go to "Later", not into the MVP.
- Refuse vague success criteria ("it should be nice to use" → "what would a user do differently?").
- Name trade-offs and make the user choose rather than choosing silently.
- 3–6 questions total, then write. A spec that ships beats an interview that doesn't end.

Non-interactive fallback: if the user cannot be asked, draft from what's known, put every unanswered essential in Open questions, and leave Status: Draft.

## Step 2: Write the spec

File: `docs/specs/YYYY-MM-DD-<feature-slug>.md` (create `docs/specs/` if needed; date from the system clock — `date` / `Get-Date` — never from memory). Check for an existing spec on the same topic first — update it rather than duplicating.

```markdown
# <Feature/Project name>

Date: YYYY-MM-DD
Status: Draft | Accepted | Implemented (link the wrap-up devlog entry)

## Problem
What hurts today and for whom. 2–4 sentences.

## Target user
The primary persona and their context. Be specific.

## Goals
What this must achieve, as testable statements.

## Non-goals
What is explicitly out of scope, and why. As important as Goals.

## Key flows
The 1–3 core user journeys, step by step ("User runs X → sees Y → ...").

## Success criteria
Observable outcomes that mean this worked. Measurable where possible.

## Open questions
Unresolved decisions, each with a leaning if one exists.

## Scope
MVP: the smallest shippable slice.
Later: everything deliberately deferred.
```

## Step 3: Hand off

1. Walk the user through the draft; revise until they accept (Status: Accepted).
2. Then move to implementation planning (plan mode) with the spec as the source of truth for scope.
3. If implementation reveals the spec was wrong, update the spec and note the change in the devlog — don't let code and spec silently diverge.

## Rules

- Specs describe product behavior, not implementation. No file names, schemas, or library choices — those belong in the plan and in ADRs.
- One spec per feature; a project-level spec is fine for a brand-new project.
- Never skip Non-goals — it is the section that does the most work.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Implementation leakage** — file names, schemas, and library choices don't belong; the spec answers what and why, never how.
- **Skipped Non-goals** — the section that does the most work is the easiest to omit under time pressure.
- **The interview that never ends** — 3–6 questions, then write; a shipped draft beats a perfect intake.
