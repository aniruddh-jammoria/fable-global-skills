# Claude Code Global Skills

A set of personal [Agent Skills](https://code.claude.com/docs/en/skills) for Claude Code that cover the full lifecycle of a software project — from first spec to public announcement — with documentation that maintains itself along the way.

These skills were written with Claude Fable 5: each one distills how a frontier model approaches the task — the judgment calls, guardrails, and failure modes — into explicit instructions that guide smaller, faster models to execute it just as reliably.

Most projects accumulate documentation debt: the README goes stale, the changelog is an afterthought, and the reasoning behind decisions evaporates. These skills make the paper trail a side effect of normal work instead of a chore — each one encodes a convention once (Keep a Changelog, ADRs, spec-before-code) and every project gets it for free.

## The skills

### Discovery

| Skill | What it does |
|---|---|
| [`/research`](research/SKILL.md) | Mines Reddit, Hacker News, forums, GitHub issues, and reviews for user pain points and the existing-solution landscape — scored on frequency/intensity/willingness-to-pay/specificity, every claim backed by a verbatim linked quote — into `docs/research/`. |
| [`/vision`](vision/SKILL.md) | Consolidates accumulated evidence into themes and drafts `docs/VISION.md` — a customer-outcome vision with a press-release narrative, positioning statement, and explicit anti-vision. Revisions are appended, never silent. |
| [`/roadmap`](roadmap/SKILL.md) | Diffs vision against current product state and pain-point scores to pick 4–5 force-ranked big rocks (customer outcomes, Now/Next/Later) in `docs/ROADMAP.md`, with an explicit "Not now" cut list. |

### Documentation

| Skill | What it does |
|---|---|
| [`/readme`](readme/SKILL.md) | Creates or updates `README.md` from what's actually in the code — verified quick-start commands, user-editable config surfaces, architecture overview. Existing READMEs are normalized to one canonical structure, reusing content that's still accurate. |
| [`/changelog`](changelog/SKILL.md) | Maintains `CHANGELOG.md` in [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format — curated, user-perspective entries, never commit dumps. |
| [`/devlog`](devlog/SKILL.md) | Records the builder's side in `docs/DEVLOG.md` (dated entries: features, analyses, dead ends) and `docs/adr/` (one-page Architecture Decision Records for significant choices, append-only). |

### Lifecycle

| Skill | When | What it does |
|---|---|---|
| [`/new-project`](new-project/SKILL.md) | Project start | Scaffolds the standard repo: README skeleton, changelog, devlog, ADR/spec directories, `CLAUDE.md` with self-documenting conventions, runnable entry point. |
| [`/spec`](spec/SKILL.md) | Before building | Turns an idea into a short product spec (`docs/specs/`) — problem, target user, goals, **non-goals**, success criteria — with deliberate pushback on vague scope. |
| [`/eval`](eval/SKILL.md) | Deciding between options | Builds a layered evaluation — deterministic checks first, LLM-as-judge only for what code can't measure — runs it against a fixed dataset, and writes a decision report to `docs/evals/`. |
| [`/wrap-session`](wrap-session/SKILL.md) | End of every session | Verifies the work runs, updates changelog + devlog, catches README drift, commits. The habit-forming one. |
| [`/release`](release/SKILL.md) | Shipping a milestone | Pre-flight checks, semver bump proposed from the changelog, tag, GitHub release with human-readable notes. |
| [`/announce`](announce/SKILL.md) | Sharing publicly | Drafts platform-native posts (LinkedIn, Twitter/X, Reddit, Show HN) from the repo's own record. Drafts only — it never posts anything. |

They chain rather than duplicate: `wrap-session` invokes `changelog` and `devlog`; `release` defers to `wrap-session` for a dirty tree; `announce` mines what the others wrote; `research` feeds `vision` feeds `roadmap`, whose rocks become `spec` inputs. Each convention lives in exactly one file, and a traceability thread runs end to end: verbatim user quote → scored pain point → theme → vision element → roadmap rock → spec.

```
/research → /vision → /roadmap → /spec → build → /eval → /wrap-session → /release → /announce
    ▲          │                    │               │           │             │
    │       outcomes,           4–5 rocks       what/why    evidence      docs update
    │       not features        force-ranked    before how  for the       + commit,
    │                                                       decision      every session
    └──────────────────── user feedback, new pain points ─────────────────────┘
```

## Installation

Clone, then link the skills into `~/.claude/skills` (Claude Code's personal-skills directory):

```powershell
# Windows
git clone https://github.com/aniruddh-jammoria/fable-global-skills.git
cd fable-global-skills
.\sync.ps1
```

```sh
# macOS / Linux
git clone https://github.com/aniruddh-jammoria/fable-global-skills.git
cd fable-global-skills
./sync.sh
```

The script links (junctions on Windows, symlinks elsewhere) each skill directory into `~/.claude/skills`, so the clone is the live source — edit a `SKILL.md` and the change is active in your next Claude Code session. Re-run the script only when adding or removing a skill directory. Verify with `/readme`, `/wrap-session`, etc. showing up as slash commands in any project.

## Usage

Each skill is a slash command (`/spec`, `/eval`, …) and also triggers automatically when a request matches its description — saying "let's wrap up" invokes `wrap-session` without the slash.

To make the documentation loop automatic in a project, add one line to its `CLAUDE.md` (the `new-project` skill does this for you):

```markdown
- After completing a feature or notable change, update CHANGELOG.md
  ([Unreleased]) and add a docs/DEVLOG.md entry; write an ADR in
  docs/adr/ for significant decisions.
```

## Design notes

A few rules run through all twelve skills, aimed at making them safe for any model to execute:

- **Update, never regenerate.** Every skill reads existing artifacts first and appends or amends; released changelog entries, accepted ADRs, and devlog history are immutable.
- **Verify before documenting.** `wrap-session` refuses to log or commit work that fails its checks; `eval` forbids simulated or estimated results — every reported number must come from a run whose per-case outputs exist on disk.
- **Gates on irreversible actions.** Creating a public repo, confirming a release version, and running a large eval all require explicit confirmation; `announce` never publishes, only drafts.
- **Dates from the clock, not from memory.** Anything that writes a dated file or entry gets the date from the system or git.
- **Graceful degradation.** Cross-skill calls carry inline fallbacks, so a step is performed minimally rather than skipped if a referenced skill is missing. Skills that normally interview the user also carry a non-interactive fallback: conservative defaults, with every assumption labeled in the output.
- **Gotchas as memory.** Every skill ends with a Gotchas section — known failure modes checked before finishing, and the append point for new ones observed in real use. Skills grow by accumulating gotchas, not by rewrites.

## Repository structure

```
<skill-name>/SKILL.md   one directory per skill, Agent Skills format
sync.ps1                link skills into ~/.claude/skills (Windows)
sync.sh                 same, macOS/Linux
```

Skills are plain markdown with YAML frontmatter — fork and edit them to match your own conventions.
