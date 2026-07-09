# Skill designs: research, vision, roadmap

> **Status: implemented 2026-07-09** — see [`research/`](../research/SKILL.md),
> [`vision/`](../vision/SKILL.md), [`roadmap/`](../roadmap/SKILL.md). Kept as
> the design rationale behind those skills.

Design notes for the next three skills, researched and drafted with Claude Fable 5
(2026-07-09). Each section is written so a future session — on any model — can
implement the skill from this document alone, following the conventions of the
existing nine skills (update-don't-regenerate, evidence over fabrication, dates
from the clock, gates on expensive actions, inline fallbacks).

They chain, and close the loop the current set leaves open:

```
/research → /vision → /roadmap → /spec → build → /wrap-session → /release → /announce
    ▲                                                                          │
    └────────────────────── user feedback, new pain points ────────────────────┘
```

Traceability is the backbone: verbatim quote → scored pain point → theme →
vision element → roadmap rock → spec. Every claim downstream should be able to
cite its upstream artifact.

---

## 1. `/research` — pain-point and solution-landscape discovery

**Purpose:** given what the user is building (or considering), find out what real
people struggle with in that space, what solutions exist, what works and what
doesn't — as evidence, not vibes.

**Trigger:** "research pain points for X", "what are people struggling with in
X", before writing a spec or vision for a new area.

### Design ideas (sources: Anthropic's multi-agent research system write-up;
Reddit pain-point-mining practice)

- **Breadth-first search discipline.** Start with short, broad queries; evaluate
  what's out there; then progressively narrow. Never jump straight to specific
  long-tail queries — that's how research agents get few, shallow results.
- **Effort scaling, stated up front.** Ask the user (or infer from stakes):
  quick scan (~8–12 searches, one pass) vs deep dive (~25–40 searches across
  source types). Announce the level and stick to it — don't over-research a
  casual question or under-research a bet-the-project one.
- **Source map with quality tiers.** Different sources answer different
  questions; the skill should say which to hit and how much to trust each:
  - *Primary voice-of-customer (highest value):* Reddit (`site:reddit.com`
    + niche subreddits), Hacker News (hn.algolia.com search), niche forums,
    GitHub issues of competing/adjacent tools, app-store & G2/Capterra reviews
    of incumbents (1–3★ reviews are pain-point gold).
  - *Solution landscape:* product sites, docs, changelogs of existing tools.
  - *Discount heavily:* SEO listicles and vendor blogs — research agents
    naturally over-trust SEO-optimized content; the prompt must explicitly
    counterweight toward primary sources.
- **Pain-point validity rubric** (score each candidate 1–3 on each):
  - **Frequency** — do multiple independent people report it?
  - **Intensity** — emotional language, workarounds built, rage-quits?
  - **Willingness to pay** — do people ask for alternatives or say "I'd pay"?
  - **Specificity** — concrete situation, not a vague gripe?
- **Evidence discipline (the eval skill's anti-fabrication rule, applied to
  research):** every pain point in the report carries at least one verbatim
  quote with a link and date. No "users say…" without a citation. If evidence
  is thin, the report says "weak evidence", not a confident claim.
- **Solutions get the same treatment:** for each existing solution — what it
  does well (praised for), where it falls short (complained about), both cited.
  The gaps between the two columns are the opportunity.

### Output

`docs/research/YYYY-MM-DD-<topic>.md`:

1. **Question** — what we wanted to learn and why now.
2. **Method** — effort level, sources searched, date range of evidence.
3. **Pain-point inventory** — table: pain point, rubric scores, representative
   quotes (linked), where found.
4. **Solution landscape** — table: solution, what it does well, where it falls
   short, evidence links.
5. **Gaps & opportunities** — pain points no solution addresses well.
6. **Confidence & limitations** — what this research does NOT establish.

Feeds `/vision` and `/spec`; one-line devlog entry (type: analysis) links it.

### Guardrails

- Confirm topic + effort level before searching (the eval skill's gate pattern).
- Dates from the system clock. Quotes copied exactly, never paraphrased into
  stronger claims.
- If search tooling is unavailable in the environment, stop and say so — do not
  write a "research" report from model memory. Memory may supplement, but must
  be labeled as such, separate from found evidence.

---

## 2. `/vision` — consolidate pain into a product vision

**Purpose:** consolidate all accumulated evidence (research reports, feedback,
eval learnings) into themes, imagine what best-in-class would look like, and
write a vision that articulates the ideal solution *in terms of what it does
for the customer*.

**Trigger:** "draft the product vision", after one or more research passes;
revisit when new evidence contradicts the current vision.

### Design ideas (frameworks with the strongest track record)

- **Inputs first, imagination second.** Step 1 is mechanical: read every
  `docs/research/*.md`, `docs/feedback/*.md`, and relevant devlog/eval entries;
  cluster pain points into 3–6 themes, each traceable to its evidence. (This is
  the same consolidation move as Anthropic's 81k-response qualitative user
  study — the value came from clustering raw voice-of-customer at scale, not
  from any single response.)
- **Working Backwards / press-release test (Amazon).** The core of the vision
  is a short narrative written from the *future customer's* point of view — a
  day-in-the-life or a mock press release announcing the ideal product. If the
  narrative isn't exciting written plainly, the vision isn't there yet.
- **Jobs-to-be-Done framing.** Anchor on the customer's struggling moment and
  the progress they're trying to make — not on features. "Hire this product
  to ___" is the sentence to get right.
- **Positioning statement (Geoffrey Moore) as a compression test:** "For
  [customer] who [struggling moment], [product] is a [category] that [key
  benefit]. Unlike [best current alternative], it [primary differentiation]."
  If this can't be filled in crisply, the vision is still mush.
- **Best-in-class means ignoring current constraints first.** Describe the
  ideal experience as if technology/effort were free; *then* mark which parts
  are reachable now vs aspirational. The gap becomes roadmap input.
- **Anti-vision is half the value.** What this product deliberately is NOT and
  will not become. (Same muscle as the spec skill's Non-goals — it does the
  most work.)

### Output

`docs/VISION.md` — a living document, 1–2 pages:

1. **Customer & struggling moment** (JTBD, evidence-linked to themes).
2. **The ideal** — press-release-style narrative of best-in-class.
3. **Positioning statement** (the one-sentence compression).
4. **What it does for the customer** — 3–5 outcome statements, each traceable
   to a pain-point theme.
5. **What this is not** — the anti-vision.
6. **Principles & bets** — the few beliefs the vision stands on.
7. **You know it's working when…** — observable signals, not metrics theater.
8. **Evidence appendix** — theme → research-report links.

Versioned like an ADR: major revisions append a dated "Revision" note saying
what changed and which new evidence forced it — never silently rewritten.

### Guardrails

- **Push back on feature-list visions.** If a draft reads as "it has X, Y, Z",
  reject it and re-anchor on customer outcomes. This is the #1 failure mode.
- Every claim about customers must cite a theme; themes must cite research.
  A vision written with zero research reports on disk should be labeled
  "hypothesis — unvalidated" at the top, prominently.
- Interview the user with pushback (spec-skill style) on the parts evidence
  can't answer: appetite, differentiation, what they refuse to build.

---

## 3. `/roadmap` — big rocks from vision-gap analysis

**Purpose:** compare the vision against the current product and the pain-point
evidence, and pick 4–5 big rocks — the few large things worth building next.

**Trigger:** "build/update the roadmap", after vision exists; re-run when a
rock completes or evidence shifts.

### Design ideas

- **Gap analysis is the engine.** Three inputs, diffed:
  1. `docs/VISION.md` — where we're going;
  2. the repo as it stands (README, changelog, specs) — where we are;
  3. pain-point inventory — what hurts users most *today*.
  Rocks live where a large vision gap intersects a high-scoring pain point.
- **Rocks are outcomes, not features.** "A new user gets value in under two
  minutes" — not "build onboarding wizard". The spec skill decides the how
  later; the roadmap must not pre-decide implementations.
- **4–5 maximum, force-ranked.** The cap is the point — a 12-item roadmap is a
  backlog wearing a costume. Everything that didn't make the cut goes to an
  explicit **"Not now"** list with one-line reasons (this list prevents
  relitigating and is half the document's value).
- **Now / Next / Later horizons** rather than dates — honest for a solo builder
  whose velocity varies. Only "Now" items (1–2) get any commitment language.
- **Lightweight scoring, honestly labeled.** ICE (impact × confidence × ease)
  per rock as a sanity check, with all numbers explicitly marked as the user's
  estimates — never model-invented reach/impact figures presented as data.
  Scoring informs the ranking; the user's judgment makes it.
- **Traceability per rock:** pain-point themes it addresses → vision element it
  advances → success signal ("done when users stop complaining about X") → link
  to its spec once one exists.

### Output

`docs/ROADMAP.md` — living document:

1. **Now** (1–2 rocks) / **Next** (2–3) / **Later** (unordered pool).
2. Per rock: outcome statement, evidence links (themes + vision element),
   success signal, ICE estimate (labeled as estimate), status.
3. **Not now** — the cut list with reasons.
4. **Last reviewed** date + what changed since last review.

Completed rocks move to a **Shipped** section with a link to their release —
the roadmap doubles as a record of promises kept.

### Guardrails

- Refuse to add a 6th rock; something must drop to "Not now" first.
- A rock with no evidence link gets flagged as "pet project — no evidence"
  rather than silently accepted (the user may keep it anyway; the label stays).
- Roadmap never contains implementation detail — that's the spec's job.
- Dates from the clock; review notes appended, history never rewritten.

---

## Implementation notes (for the future session that builds these)

- Follow the repo's existing SKILL.md format and Design-notes rules (see
  README). Each skill is one directory + SKILL.md; run `sync.ps1` after adding.
- Keep them as three separate, composable skills — the lab lesson from both
  Anthropic and OpenAI agent guidance is that simple composable patterns beat
  one monolithic workflow. `/vision` should work even if the only input is one
  research report; `/roadmap` should degrade gracefully with no vision (flag
  it, proceed from pain points alone).
- Smaller-model hardening to carry over: evidence-or-silence rules, effort
  gates before expensive search runs, system-clock dates, no invented numbers,
  append-only revision history on VISION.md and ROADMAP.md.
- Suggested build order: `/research` first (it feeds everything and is useful
  standalone), then `/vision`, then `/roadmap`.

## Sources

- Anthropic — [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
  (breadth-first queries, effort scaling, source-quality heuristics, composable subagents)
- Anthropic — [How we use skills in Claude Code](https://claude.com/blog/lessons-from-building-claude-code-how-we-use-skills)
- Anthropic — [Building effective AI agents](https://www.anthropic.com/research/building-effective-agents)
  (simple composable patterns over frameworks)
- Reddit pain-point mining methodology: [PainOnSocial guides](https://painonsocial.com/blog/how-to-find-pain-points-on-reddit),
  [Inc. — Reddit as a pain-point goldmine](https://www.inc.com/diana-bocco/reddit-customer-pain-point-founders-best-product-ideas/91352669)
  (frequency / intensity / willingness-to-pay / specificity rubric)
- Framework provenance: Amazon Working Backwards (PR/FAQ), Christensen's
  Jobs-to-be-Done, Geoffrey Moore's positioning statement, Now/Next/Later
  roadmapping, ICE scoring.
