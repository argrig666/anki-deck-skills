#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
failed=0

pass() { printf 'OK   %s\n' "$1"; }
fail() { printf 'FAIL %s\n' "$1" >&2; failed=1; }

[ -f "$repo_dir/PROJECT_MANIFEST.json" ] && pass 'project manifest present' || fail 'project manifest missing'
[ -f "$repo_dir/anki-system/SKILL.md" ] && pass 'entry skill present' || fail 'entry skill missing'
[ -f "$repo_dir/anki-system/references/recovery.md" ] && pass 'recovery guide present' || fail 'recovery guide missing'

for skill_file in "$repo_dir"/*/SKILL.md; do
  [ -f "$skill_file" ] || continue
  first=$(sed -n '1p' "$skill_file")
  [ "$first" = '---' ] || fail "invalid skill metadata: $skill_file"
done
pass 'skill entry files inspected'

if git -C "$repo_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  remote=$(git -C "$repo_dir" remote get-url origin 2>/dev/null || true)
  [ "$remote" = 'https://github.com/argrig666/anki-deck-skills.git' ] && pass 'canonical GitHub remote configured' || fail 'canonical GitHub remote missing or changed'
  [ -z "$(git -C "$repo_dir" status --porcelain)" ] && pass 'working tree clean' || fail 'working tree has uncommitted changes'
else
  fail 'repository Git metadata missing'
fi

for root in "${CODEX_SKILLS_DIR:-$HOME/.codex/skills}" "${SHARED_AGENT_SKILLS_DIR:-$HOME/.agents/skills}"; do
  [ -L "$root/anki-system" ] && pass "anki-system installed in $root" || fail "anki-system not installed in $root"
done

if [ "${1:-}" = '--online' ]; then
  git -C "$repo_dir" ls-remote --exit-code origin HEAD >/dev/null 2>&1 && pass 'GitHub remote reachable' || fail 'GitHub remote not reachable'
  if command -v curl >/dev/null 2>&1 && curl -fsS --max-time 3 http://127.0.0.1:8765 >/dev/null 2>&1; then
    pass 'AnkiConnect reachable'
  else
    fail 'AnkiConnect not reachable; open Anki and verify the add-on'
  fi
fi

[ "$failed" -eq 0 ]

