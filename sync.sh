#!/usr/bin/env sh
# Links every skill in this repo into ~/.claude/skills so Claude Code uses
# the repo as the live source (macOS/Linux). Re-run after adding a skill.
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
dest="$HOME/.claude/skills"
mkdir -p "$dest"

for dir in "$repo"/*/; do
    name=$(basename "$dir")
    [ -f "$dir/SKILL.md" ] || continue
    rm -rf "${dest:?}/$name"
    ln -s "$repo/$name" "$dest/$name"
    echo "linked  $name"
done
echo
echo "Done. Skills in this repo are now live in $dest"
