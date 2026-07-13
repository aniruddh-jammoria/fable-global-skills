# Claude Code Global Skills

Personal Agent Skills for Claude Code — one directory per skill (`<name>/SKILL.md`), linked into `~/.claude/skills` by `sync.sh` / `sync.ps1`.

## Conventions

- **Every push is a release.** Before pushing, promote `CHANGELOG.md` `[Unreleased]` to a calendar version `[YYYY.MM.DD]` (date from the system clock). Between pushes, entries accumulate under `[Unreleased]`.
- After completing notable changes, update `CHANGELOG.md` (`[Unreleased]`) and add a `docs/DEVLOG.md` entry.
- Skills improve by **appending to their Gotchas sections** (observed failure modes), not by rewrites. Keep each SKILL.md concise; the target reader is a smaller model.
- Improvement ideas and not-yet-confirmed gotchas go in `BACKLOG.md`; fold a gotcha into its skill once confirmed, move an idea to the changelog once shipped.
- After adding or removing a skill directory, re-run `sync.sh` (or `sync.ps1` on Windows). `sync.sh` runs `validate.sh` first and aborts if any SKILL.md breaks the frontmatter constraints or repo conventions.
