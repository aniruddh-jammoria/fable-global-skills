---
name: research
description: Research user pain points and the solution landscape for what is being built - mine Reddit, Hacker News, forums, GitHub issues, and reviews for what real people struggle with, what solutions exist, and what works vs what doesn't - then write an evidence-backed report to docs/research/. Use when the user wants pain-point research, market/competitive discovery, or validation before a spec or vision.
---

# Research Pain Points and the Solution Landscape

Find out what real people struggle with in a problem space and how existing solutions serve them — as cited evidence, not vibes. The output feeds the **vision** and **spec** skills.

**Requires web search tooling.** If the environment has no way to search the web, stop and say so — never write a "research" report from model memory. Model knowledge may supplement findings but must be labeled `(background knowledge, unverified)` and kept separate from found evidence.

## Step 1: Frame and gate

Confirm with the user before searching:
1. **Question:** what are we trying to learn, about which problem space? One sentence.
2. **Effort level:** quick scan (~8–12 searches, one pass) or deep dive (~25–40 searches across source types). Propose one based on stakes; don't over-research a casual question.

Check `docs/research/` for existing reports on the topic — extend rather than duplicate.

## Step 2: Search — breadth first, primary sources first

Start with short, broad queries; evaluate what's out there; then progressively narrow. Never open with long-tail specific queries.

Source map, in trust order:
- **Primary voice-of-customer (highest value):** Reddit (`site:reddit.com` + niche subreddits), Hacker News (search via hn.algolia.com), niche forums and Discords with public archives, GitHub issues of competing/adjacent tools, app-store and G2/Capterra reviews of incumbents — 1–3★ reviews are pain-point gold.
- **Solution landscape:** product sites, docs, changelogs, pricing pages of existing tools.
- **Discount heavily:** SEO listicles and vendor blogs. Search results over-represent SEO-optimized content — actively counterweight toward primary sources.

## Step 3: Score pain points

For each candidate pain point, score 1–3 on each:
- **Frequency** — do multiple independent people report it?
- **Intensity** — emotional language, hand-built workarounds, rage-quits?
- **Willingness to pay** — do people seek alternatives or say "I'd pay for"?
- **Specificity** — a concrete situation, not a vague gripe?

**Evidence discipline:** every pain point carries at least one verbatim quote with a link and date. Quotes are copied exactly — never paraphrased into stronger claims. No "users say…" without a citation. Thin evidence is reported as "weak evidence", not upgraded into a confident claim.

## Step 4: Map the solutions

For each existing solution found: what it is **praised for** and where it **falls short** — both cited the same way as pain points. The gaps between those two columns are the opportunity.

## Step 5: Write the report

File: `docs/research/YYYY-MM-DD-<topic-slug>.md` (date from the system clock — `date` / `Get-Date` — never from memory).

```markdown
# <Research question>

Date: YYYY-MM-DD
Effort: quick scan | deep dive (N searches)

## Question
What we wanted to learn and why now.

## Method
Sources searched, date range of the evidence found.

## Pain-point inventory
| Pain point | Freq | Int | WTP | Spec | Evidence |
(representative quotes with links, one row per pain point, sorted by total score)

## Solution landscape
| Solution | Praised for | Falls short on | Evidence |

## Gaps & opportunities
Pain points no current solution addresses well.

## Confidence & limitations
What this research does NOT establish; where evidence is thin.
```

## Step 6: Connect it

- One-line devlog entry (type: analysis) linking the report.
- Recommend the natural next step: another research pass, a **vision** draft/revision, or straight to a **spec** if the scope is narrow.
