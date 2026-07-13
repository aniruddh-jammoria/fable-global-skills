#!/usr/bin/env sh
# Validates every skill's SKILL.md against the Agent Skills frontmatter
# constraints and this repo's conventions. Exits non-zero on any failure.
# Run directly, or via sync.sh (which calls it before linking).
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
fail=0

err() { echo "FAIL  $1: $2"; fail=1; }

for dir in "$repo"/*/; do
    name=$(basename "$dir")
    file="$dir/SKILL.md"
    [ -f "$file" ] || continue

    if [ "$(head -n 1 "$file")" != "---" ]; then
        err "$name" "frontmatter must open with --- on line 1"
        continue
    fi
    fm=$(awk 'NR==1{next} /^---$/{exit} {print}' "$file")
    fm_name=$(printf '%s\n' "$fm" | sed -n 's/^name:[[:space:]]*//p')
    fm_desc=$(printf '%s\n' "$fm" | sed -n 's/^description:[[:space:]]*//p')

    [ -n "$fm_name" ] || err "$name" "missing or empty name"
    [ -n "$fm_desc" ] || err "$name" "missing or empty description"
    [ "$fm_name" = "$name" ] || err "$name" "frontmatter name '$fm_name' does not match directory name"
    [ "${#fm_name}" -le 64 ] || err "$name" "name is ${#fm_name} chars (limit 64)"
    printf '%s' "$fm_name" | grep -Eq '^[a-z0-9-]+$' || err "$name" "name may only contain lowercase letters, numbers, hyphens"
    case "$fm_name" in
        *anthropic*|*claude*) err "$name" "name contains a reserved word (anthropic/claude)" ;;
    esac
    [ "${#fm_desc}" -le 1024 ] || err "$name" "description is ${#fm_desc} chars (limit 1024)"
    if printf '%s\n%s' "$fm_name" "$fm_desc" | grep -q '<[a-zA-Z/]'; then
        err "$name" "XML tags are not allowed in name or description"
    fi

    # body = everything after the closing ---; spec recommends <500 lines
    body_lines=$(awk 'NR==1{next} f{c++} /^---$/ && !f{f=1} END{print c+0}' "$file")
    [ "$body_lines" -le 500 ] || err "$name" "body is $body_lines lines (limit 500)"

    # repo convention: every skill ends with a Gotchas section
    grep -q '^## Gotchas' "$file" || err "$name" "missing '## Gotchas' section (repo convention)"
done

if [ "$fail" -ne 0 ]; then
    echo
    echo "Validation failed - fix the skills above before syncing."
    exit 1
fi
echo "All skills valid."
