#!/usr/bin/env sh
# Links every skill in this repo into ~/.claude/skills so Claude Code uses
# the repo as the live source (macOS/Linux). Re-run after adding a skill.
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
dest="$HOME/.claude/skills"

"$repo/validate.sh"

mkdir -p "$dest"

for dir in "$repo"/*/; do
    name=$(basename "$dir")
    [ -f "$dir/SKILL.md" ] || continue
    if [ -e "$dest/$name" ] && [ ! -L "$dest/$name" ]; then
        echo "SKIP    $name  ($dest/$name exists and is not a symlink; refusing to overwrite)"
        continue
    fi
    rm -rf "${dest:?}/$name"
    ln -s "$repo/$name" "$dest/$name"
    echo "linked  $name"
done
echo
echo "Done. Skills in this repo are now live in $dest"
