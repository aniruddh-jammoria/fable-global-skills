# Development Log

Newest entries first.

## 2026-07-13 — Best-practices review and smaller-model hardening

- **Type:** analysis
- **Context:** Reviewed all twelve skills against Anthropic's skill-authoring
guidance (the platform best-practices doc, "Equipping agents for the real
world with Agent Skills", and the Claude Code skills lessons post) to check
the repo's core premise: Fable-written skills that smaller models execute
reliably.
- **What was done:** Findings — descriptions (what + when, third person,
keyword-rich), conciseness (~50–110 lines vs the 500-line budget),
composition with inline fallbacks, and the anti-fabrication guardrails
already match official guidance. Gaps were the improvement loop and a
dangling reference: no Gotchas sections (Anthropic calls gotchas the
highest-signal content in a skill), no copyable checklists in the multi-step
orchestrators, interactive gates that stall autonomous runs, and vision +
roadmap reading a `docs/feedback/` directory no skill ever wrote. Applied
fixes: research now owns first-party feedback capture (vision and roadmap
read only `docs/research/`); every skill gained a seeded Gotchas section;
wrap-session and release gained progress checklists; research, eval, spec,
vision, and roadmap gained one-line non-interactive fallbacks. Considered
and rejected a separate /feedback skill — research's scoring rubric already
fits, and this repo stays skills-only (target projects hold the `docs/`
artifacts, not this repo; the changelog and this devlog are the exception,
since the repo is itself a project).
- **Outcome:** All twelve skills hardened and re-linked into
`~/.claude/skills` via sync.sh. Adopted calendar versioning for the
changelog (every push is a release; Keep a Changelog has no rolling-release
convention, but doesn't require SemVer either) — convention recorded in
CLAUDE.md, and the changelog + release skills now recognize
calendar-versioned files in any project. Later the same session: built
validate.sh (frontmatter + convention linter, run by sync.sh before
linking) and the not-a-symlink guard before sync.sh's `rm -rf` — both
verified, including negative tests (malformed skill caught with exit 1; a
real directory in ~/.claude/skills survives a sync untouched). Remaining
ideas moved to BACKLOG.md (announce per-platform split, PowerShell port of
validate.sh); eval-driven gotcha harvesting and a /demo skill were
deliberately dropped for now rather than backlogged.
