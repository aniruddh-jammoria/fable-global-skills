---
name: vision
description: Consolidate accumulated pain-point evidence (docs/research/, docs/feedback/, eval and devlog learnings) into themes and draft or revise docs/VISION.md - a customer-outcome product vision - what best-in-class looks like, what it does for the customer, and what it deliberately is not. Use when the user wants a product vision drafted, revised, or checked against new evidence.
---

# Draft or Revise the Product Vision

A vision articulates the ideal solution **in terms of what it does for the customer** — never a feature list. It is a living 1–2 page document at `docs/VISION.md`, grounded in evidence.

## Step 1: Consolidate the evidence (mechanical, before any imagination)

Read everything on disk: `docs/research/*.md`, `docs/feedback/*.md`, relevant `docs/DEVLOG.md` and `docs/evals/` entries. Cluster the pain points into **3–6 themes**, each listing the reports/quotes it draws from.

- If `docs/VISION.md` exists, this is a **revision**: read it fully, judge which parts new evidence supports, contradicts, or leaves untouched.
- If there is **no research on disk**, say so plainly. You may still draft from the user's own hypotheses, but the document gets a prominent label at the top: `Status: Hypothesis — unvalidated (no research evidence on disk)`.

## Step 2: Interview the user — with pushback

Evidence can't answer everything. Ask (3–5 questions max, spec-skill style):
- Appetite: how big is this allowed to become?
- Differentiation: why would someone switch from the best current alternative?
- Refusals: what will you never build, even if users ask?

Push back on answers that describe features instead of customer outcomes — that is the #1 vision failure mode. Re-anchor every "it has X" as "the customer can Y".

## Step 3: Imagine best-in-class

Describe the ideal experience **as if technology and effort were free** — then mark which parts are reachable now vs aspirational (that gap is roadmap input). Two framing tools:

- **Press-release test (working backwards):** write the core narrative as a short mock press release or day-in-the-life from the *future customer's* point of view. If it isn't compelling written plainly, the vision isn't there yet.
- **Positioning statement as a compression test:** "For [customer] who [struggling moment], [product] is a [category] that [key benefit]. Unlike [best current alternative], it [primary differentiation]." If the blanks don't fill crisply, keep working.

## Step 4: Write `docs/VISION.md`

```markdown
# Vision: <Product name>

Status: Grounded | Hypothesis — unvalidated
Last revised: YYYY-MM-DD   (date from the system clock, never from memory)

## Customer & struggling moment
Who, and the progress they are trying to make (jobs-to-be-done framing).
Cite the pain-point themes.

## The ideal
Press-release-style narrative of the best-in-class experience.
Mark aspirational parts as such.

## Positioning
The one-sentence positioning statement.

## What it does for the customer
3–5 outcome statements, each traceable to a pain-point theme.

## What this is not
The anti-vision: what it deliberately will not be or become.

## Principles & bets
The few beliefs this vision stands on.

## You know it's working when…
Observable signals, not metrics theater.

## Evidence
Theme → linked research/feedback reports.

## Revision history
- YYYY-MM-DD: what changed and which evidence forced it.
```

## Rules

- **Never silently rewrite.** Revisions update the body *and* append a dated Revision history line stating what changed and why. History is never deleted.
- Every claim about customers cites a theme; every theme cites evidence on disk. Claims without evidence are labeled as the user's hypothesis.
- Vision stays at the outcome level — no feature lists, no implementation. Features belong in the roadmap's rocks and the specs.
- Keep it to 1–2 pages; a vision nobody rereads is furniture.
