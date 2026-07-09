---
name: announce
description: Draft platform-tailored announcement posts for a project or release - LinkedIn, Reddit, Twitter/X, Hacker News (Show HN) - from the repo's README, changelog, devlog, and specs. Use when the user wants to share, promote, launch, or announce a project or milestone. Drafts to docs/announcements/ for human review; NEVER posts to any platform itself.
---

# Draft Project Announcements

Turn the repo's own record — README, CHANGELOG, DEVLOG, specs, eval reports — into posts written for each platform's culture. **This skill only drafts. Publishing is always a human act:** never post, schedule, or call any social API, even if credentials are available.

## Step 1: Gather material

Read the repo's story before writing a word:
- `README.md` — what it is, the demo, the quick start.
- `CHANGELOG.md` — what's new (for release announcements).
- `docs/DEVLOG.md` + `docs/adr/` — the honest narrative: decisions, trade-offs, dead ends. **This is the best content**; audiences engage with the struggle, not the polish.
- `docs/evals/` — real measured results, if any.

Ask the user: what's the occasion (first launch vs milestone vs learning write-up), and which platforms?

## Step 2: Readiness check (first launch only)

Before drafting a launch, verify the front door can take traffic and flag gaps:
- README current, quick start works, demo GIF/screenshot exists (a launch without a visual underperforms — recommend making one first).
- No crash-level bugs in the main flow; repo is public.

## Step 3: Draft per platform

Write to `docs/announcements/YYYY-MM-DD-<occasion>/<platform>.md` (date from the system clock, never from memory), one file per platform. Each platform gets a **different post**, not a reworded copy:

**LinkedIn** — journey and lessons framing. Hook line, the problem, 2–3 concrete lessons or decisions from the devlog, what you'd do differently, link. Professional but first-person; short paragraphs; no hashtag walls (≤3).

**Twitter/X** — a thread: (1) hook + what it does, (2) demo visual [note where to attach it], (3) the most interesting technical decision or number, (4) a dead end or surprise, (5) link + ask for feedback. Each tweet stands alone; ≤280 chars each.

**Reddit** — draft a body, then per-subreddit guidance: suggest 2–3 niche subreddits matching the project's actual users (niche beats big general subs), and **instruct the user to read each subreddit's self-promotion rules before posting** — the skill cannot verify them. Tone: a person sharing what they made and asking for feedback, not marketing. Title states plainly what it is.

**Hacker News (Show HN)** — title: `Show HN: <name> – <plain description of what it does>`. Body: candid and technical — motivation, how it works, stack, **current limitations stated up front**, what feedback is wanted. Plus a prepared first comment (to post within ~5 minutes) going deeper on the interesting technical bits. Never ask for upvotes. Only use Show HN for something people can actually try.

Include a `notes.md` in the folder: suggested timing (Tue–Thu, ~10:00–13:00 ET is the common recommendation), which platform to lead with, and reminders (attach the demo GIF, check subreddit rules).

## Rules — authenticity is the whole game

- **Never fabricate:** no invented metrics, user counts, or results. Numbers only from the repo's own evals, benchmarks, or git history.
- **State limitations honestly** — on HN and Reddit especially, candor about what doesn't work yet builds more credibility than polish.
- Banned register: "revolutionary", "game-changing", "blazingly", superlatives generally. Write like a person explaining what they made to a friend.
- First person, the user's voice. If their previous announcement drafts exist in `docs/announcements/`, match their established voice.
- Every draft ends with a note that the user should review and edit before posting — these are starting points, not final copy.
