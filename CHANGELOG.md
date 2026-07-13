# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
with [calendar versions](https://calver.org/) (`YYYY.MM.DD`) instead of SemVer —
every push is a release. Work accumulates under `[Unreleased]` between pushes
and is promoted to a dated version at push time.

## [Unreleased]

## [2026.07.13.2]

### Fixed
- The devlog skill's entry template rendered Type/Context/What/Outcome as one run-on paragraph; the fields are now list items so each renders as its own bullet

## [2026.07.13.1]

### Added
- `validate.sh`: lints every SKILL.md against the Agent Skills frontmatter constraints (name/description limits, reserved words, 500-line body) and repo conventions (Gotchas section, name matches directory); `sync.sh` runs it before linking and aborts on failure
- `BACKLOG.md` for improvement ideas and observed-but-unconfirmed gotchas

### Fixed
- `sync.sh` now refuses to overwrite a destination that exists but is not a symlink, instead of silently `rm -rf`-ing it

## [2026.07.13]

### Added
- Gotchas section in every skill: known failure modes to check before finishing, and the append point for new ones observed when smaller models run the skill
- Copyable progress checklists in the wrap-session and release skills, so multi-step runs can't silently skip verification or the version-confirmation gate
- Non-interactive fallbacks in research, eval, spec, vision, and roadmap: conservative defaults with labeled assumptions when the user cannot be asked
- This changelog, a development log ([docs/DEVLOG.md](docs/DEVLOG.md)), and a `CLAUDE.md` recording the repo's release convention

### Changed
- The research skill now also captures first-party feedback (the project's own issues, announcement replies, user messages) as scored evidence, and no longer hard-requires web search for a first-party-only pass
- This changelog uses calendar versioning; the changelog and release skills now recognize calendar-versioned files anywhere they're used

### Fixed
- The vision and roadmap skills referenced a `docs/feedback/` directory no skill ever wrote; all pain-point evidence now lives in `docs/research/`
- README said the shared design rules run through "all nine skills"; there are twelve
- `sync.sh` had lost its executable bit, so the README's `./sync.sh` install step failed

## [2026.07.09]

Baseline: twelve lifecycle skills (research → vision → roadmap → spec → eval → wrap-session → release → announce, plus readme, changelog, devlog, new-project), sync scripts that link them into `~/.claude/skills`, and design notes in `docs/SKILL-IDEAS.md`.
