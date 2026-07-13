---
name: roadmap
description: Build or update docs/ROADMAP.md by diffing the product vision against the current product state and pain-point evidence, then selecting 4-5 force-ranked big rocks framed as customer outcomes on Now/Next/Later horizons, with an explicit "Not now" cut list. Use when the user wants a roadmap created, updated after a shipped rock, or re-prioritized against new evidence.
---

# Build or Update the Roadmap

Pick the few large things worth building next — **big rocks** — by finding where the vision gap intersects the strongest pain-point evidence. Output: `docs/ROADMAP.md`, a living document.

## Step 1: Gather the three inputs

1. **Where we're going:** `docs/VISION.md`. If none exists, flag it prominently, proceed from pain points alone, and recommend running the **vision** skill.
2. **Where we are:** the current product — README, CHANGELOG, specs, the code's actual capabilities.
3. **What hurts users most:** pain-point inventories in `docs/research/`, with their scores — first-party feedback reports weigh heaviest when they exist.

If `docs/ROADMAP.md` exists, read it fully — this is an update: carry statuses forward, move shipped rocks to Shipped, and re-rank only with reason.

## Step 2: Gap analysis

Diff vision against current state: which vision outcomes does the product not yet deliver? Cross with the pain-point scores: **rocks live where a large vision gap meets a high-scoring pain point.** List the candidate intersections before selecting.

## Step 3: Select and rank the rocks

- **4–5 rocks maximum, force-ranked.** Refuse to add a sixth — something must drop to "Not now" first. A 12-item roadmap is a backlog wearing a costume.
- **Rocks are customer outcomes, not features.** "A new user gets value in under two minutes" — not "build onboarding wizard". The spec decides the how later; the roadmap must not pre-decide implementations.
- **Horizons, not dates:** Now (1–2 rocks, the only ones with commitment language), Next (2–3), Later (unordered pool).
- **ICE scoring as a sanity check** (impact × confidence × ease, 1–10 each): all numbers are the **user's estimates, elicited from them and labeled as estimates** — never model-invented figures presented as data. Scoring informs the ranking; the user's judgment makes the final call. Non-interactive fallback: if the user cannot be asked, leave ICE blank and rank on evidence strength alone — never fill in the numbers yourself.
- A rock with no evidence or vision link gets labeled **"pet project — no evidence"**. The user may keep it (their call), but the label stays in the document.

## Step 4: Write `docs/ROADMAP.md`

```markdown
# Roadmap: <Product name>

Last reviewed: YYYY-MM-DD   (date from the system clock, never from memory)

## Now
### <Rock: outcome statement>
- Why: pain-point themes addressed → vision element advanced (links)
- Done when: observable success signal
- ICE (user's estimate): I_ C_ E_
- Status: not started | in progress (link spec) | blocked

## Next
(same shape, 2–3 rocks)

## Later
(unordered pool, one line each)

## Not now
- <cut idea> — one-line reason it lost.

## Shipped
- YYYY-MM-DD <rock> → release link.

## Review log
- YYYY-MM-DD: what changed this review and why.
```

## Step 5: Connect it

- When a rock moves to "Now" and work starts, hand off to the **spec** skill — the rock's outcome statement becomes the spec's goal.
- When a rock ships (via the **release** skill), move it to Shipped with the release link — the roadmap doubles as a record of promises kept.
- One-line devlog entry for each roadmap review.

## Rules

- The "Not now" list is half the document's value — every cut gets a reason, so decisions aren't relitigated from scratch.
- No implementation detail anywhere in the roadmap; that's the spec's job.
- Review notes are appended to the Review log; history is never rewritten.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **The sixth rock** — pressure to add "just one more"; refuse until something drops to "Not now".
- **Invented ICE numbers** — scores are elicited from the user; blank beats fabricated.
- **Features wearing outcome costumes** — "build onboarding wizard" reworded is still a feature; the test is whether the statement names a customer result.
