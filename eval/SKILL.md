---
name: eval
description: Design and run an evaluation to decide between options (prompts, models, agent designs, parameters) using layered checks - deterministic metrics first, LLM-as-judge only for what code cannot check - then write a decision report to docs/evals/. Use when the user wants to compare options, evaluate a prompt/model change, measure quality, or write up eval results.
---

# Build and Run an Evaluation

An eval exists to answer a decision question ("which prompt/model/design should we use?") with evidence instead of vibes. Every eval produces two artifacts: a repeatable harness in `evals/` and a decision report in `docs/evals/`.

## Step 1: Frame the decision

Before any code, pin down with the user:
1. **Question:** What decision will this eval settle? One sentence.
2. **Options:** The concrete variants under test (prompt A vs B, model X vs Y). Two to four; more dilutes the signal.
3. **What "better" means:** The observable qualities that matter, ranked. Push back on vague criteria the same way the spec skill does.

Check `evals/` and `docs/evals/` first — extend an existing harness/dataset rather than building a parallel one.

## Step 2: Build the dataset

- A fixed, versioned input set in `evals/datasets/` (JSONL or similar), representative of real usage — include hard cases and known past failures, not just happy paths.
- Size by stakes: ~20–30 cases for a quick directional check; **50+ (prefer 100+) before treating a comparison as decided.** State the size honestly in the report.
- Never let the same LLM generate both the test cases and the judgments without user review of the cases.

## Step 3: Layer the metrics

**Layer 1 — deterministic (always first).** Code checks that are free and unambiguous: schema/format validation, exact or regex match where a right answer exists, length contracts, required-content presence, latency/cost. These catch a large share of failures before any judge runs. Match the metric to the failure mode — never force a string-overlap metric onto open-ended output.

**Layer 2 — LLM-as-judge (only for what code can't check):** relevance, faithfulness, tone, helpfulness. Rules that keep judges trustworthy:
- **Closed-ended rubric questions** ("Does the response cite the provided context? yes/no"), not open scales — "rate 1–10" is noisy and non-deterministic.
- Judge prompt states criteria explicitly and asks for reasoning before the verdict.
- Use a strong model as judge; judge one criterion per call rather than everything at once.
- For head-to-head comparisons, pairwise A/B with randomized order beats absolute scoring.
- **Calibrate:** before trusting the judge, hand-label 5–10 cases and compare. Disagreement means fix the rubric, not the data. Record judge model + prompt version in the report.

**Layer 3 — human spot-check.** Read a sample of raw outputs yourself, especially cases where the layers disagree. Surprises live here.

## Step 4: Run

**Gate before running:** state the run's size to the user and get confirmation first — cases × options × judge calls per case = total LLM calls, with a rough cost estimate. Suggest a 5-case smoke run first when the total is large. Non-interactive fallback: if the user cannot be asked, run only the ~5-case smoke set and report results as directional — never launch the full run unconfirmed.

- Model access: reuse the project's existing LLM client and configuration. If the project has no working way to call a model (no client, no key), **stop and tell the user** — do not write a runner that can't execute.
- A small runner script in `evals/` (stack-appropriate) that takes option + dataset and emits per-case results to a file — so runs are repeatable and diffable. Prefer the project's existing eval tooling if any.
- Run **all options against the identical dataset**; fix temperature/seeds where possible; note any nondeterminism.
- Keep raw per-case outputs; aggregates hide the interesting failures.
- **Never estimate, simulate, or fabricate results.** Every number in the report must come from an actual run, and the per-case output files must exist on disk. If a run failed or was skipped, the report says so — a table cell is real data or it is empty.

## Step 5: Write the report

File: `docs/evals/YYYY-MM-DD-<question-slug>.md` (date from the system clock — `date` / `Get-Date` — never from memory).

```markdown
# <Decision question>

Date: YYYY-MM-DD
Status: Decided | Inconclusive

## Question
What we needed to decide and why now.

## Setup
Options tested; dataset (size, source, what it covers); metrics per layer;
judge model + rubric version if used.

## Results
One table: options as columns, metrics as rows. Then 2–3 illustrative
examples — especially cases where options disagreed or a judge and a
deterministic check disagreed.

## Decision
Which option wins and by how much. If the margin is thin, say so.

## Threats to validity
Small n, dataset bias, judge unreliability, what this eval does NOT tell us.

## Follow-ups
What to re-test later; cases to add to the dataset.
```

## Step 6: Connect it

- One-line devlog entry (type: analysis) linking the report.
- If the decision is architectural (model choice, agent design), also write an ADR referencing the eval as evidence.
- Report results faithfully: an inconclusive eval written up honestly is a valid outcome — never overstate a thin margin as a clear win.

## Gotchas

Known failure modes — check them before finishing; append new ones as they surface.

- **Fabricated results** — the cardinal sin: every number traces to a run whose per-case outputs exist on disk; an empty cell beats an estimated one.
- **"Rate 1–10" judges** — open scales are noisy and non-deterministic; closed-ended rubric questions only.
- **Ungated runs** — cases × options × judge calls gets stated and confirmed before spending; when in doubt, smoke run first.
