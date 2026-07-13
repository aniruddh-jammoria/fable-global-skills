# Backlog

Improvement ideas and observed gotchas, awaiting triage. When an idea ships,
move it to `CHANGELOG.md`. When a gotcha is confirmed, fold it into the
relevant skill's `## Gotchas` section and remove it here.

## Ideas

- **Split `announce` into per-platform files** — `SKILL.md` keeps the shared
  workflow (gather material, readiness check, authenticity rules) plus one
  pointer line per platform; the playbooks move to
  `announce/platforms/<platform>.md`, read only for the platforms the user
  picked. Progressive disclosure, and the repo's worked example of a
  folder-structured skill.
- **Port `validate.sh` to PowerShell** — `sync.ps1` handles junction vs
  plain-copy replacement by design, but gets no frontmatter linting; Windows
  installs currently sync unvalidated skills.

## Gotchas (observed, not yet folded in)

None yet. When a model misuses a skill, record it here — skill name, what
happened, what the fix would be — then append it to that skill's Gotchas
section once confirmed.
