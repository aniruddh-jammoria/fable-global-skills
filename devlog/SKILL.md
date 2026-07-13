---
name: devlog
description: Record development history in docs/DEVLOG.md (dated entries for features, analyses, simplifications, experiments) and docs/adr/ (Architecture Decision Records for significant decisions). Use when the user asks to log work done, document a decision or analysis, write an ADR, or at the end of a work session worth recording. Complements the changelog - the changelog records what changed for users; the devlog records how and why for the builder.
---

# Maintain a Development Log and ADRs

Two artifacts, one purpose: preserve the builder's reasoning so future readers and contributors can follow how the project evolved.

- `docs/DEVLOG.md` — chronological, dated entries: features built, analyses done, simplifications made, experiments run, dead ends hit.
- `docs/adr/NNNN-short-slug.md` — one page per **significant decision**, capturing context and alternatives.

## Step 1: Locate or create

Read the top of `docs/DEVLOG.md` if it exists — match its entry style and find the last entry date. If it doesn't exist, create it with a one-line header:

```markdown
# Development Log

Newest entries first. Major decisions live in [adr/](adr/).
```

Check `docs/adr/` for existing ADRs and the highest number used.

## Step 2: Write the DEVLOG entry (newest first, at the top)

If the top entry already covers this session's work (written earlier in the same session), extend that entry instead of adding a near-duplicate below it.

```markdown
## 2026-07-09 — Short title of what happened

**Type:** feature | analysis | simplification | experiment | fix
**Context:** Why this work was picked up (1–2 sentences).
**What was done:** The substance — what was built/analyzed/removed and the key
findings or trade-offs. Include what was tried and rejected; documented dead
ends save future readers from repeating them.
**Outcome:** Result and follow-ups. Link related ADRs (adr/0003-....md),
notable commits, or changelog entries.
```

Keep entries honest and specific — "reduced the agent loop from 3 LLM calls to 1 by batching tool results; latency dropped ~40%" beats "improved performance". Write the entry from what actually happened in the session, not an idealized narrative.

## Step 3: Decide whether an ADR is warranted

Write an ADR only when the decision passes at least one of these tests:
- Hard or expensive to reverse (framework, data model, protocol, hosting).
- Shapes the architecture other code will grow around.
- Chose between real alternatives that a reasonable person might revisit ("why CLI not UI", "why this orchestration pattern").

Routine implementation choices stay in the DEVLOG entry. When in doubt, DEVLOG only.

## Step 4: Write the ADR (if warranted)

File: `docs/adr/NNNN-short-slug.md`, next sequential number, zero-padded.

```markdown
# NNNN. Title as a short decision statement

Date: YYYY-MM-DD
Status: Accepted   (Proposed | Accepted | Deprecated | Superseded by [NNNN](NNNN-slug.md))

## Context
The forces at play: requirements, constraints, tensions. 1 short paragraph.

## Decision
What was decided, in active voice: "We will ..."

## Alternatives considered
Each rejected option and the one-line reason it lost.

## Consequences
What becomes easier, what becomes harder, what we are now committed to.
List the negative consequences too.
```

## Rules

- **ADRs are append-only.** Never edit an accepted ADR's substance; write a new one that supersedes it and update the old one's Status line only.
- One decision per ADR; one page maximum.
- DEVLOG entries are also never rewritten later — corrections get a new entry.
- Dates (entry headings, ADR Date lines) come from the system clock (`date` / `Get-Date`) or git — never from memory. Convert relative dates ("yesterday") to absolute.
- Don't duplicate the changelog: user-visible outcomes go there; reasoning and process go here. Cross-link instead of repeating.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Idealized narratives** — the entry records what actually happened, dead ends included; a tidy story that omits the failed attempt erases the entry's value.
- **Edited history** — past entries and accepted ADRs are immutable; corrections are new entries, supersessions are new ADRs.
- **ADR inflation** — routine implementation choices stay in the DEVLOG; when in doubt, no ADR.
