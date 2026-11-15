#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

install_root() {
  root=$1
  mkdir -p "$root"
  for skill_file in "$repo_dir"/*/SKILL.md; do
    [ -f "$skill_file" ] || continue
    skill_dir=${skill_file%/SKILL.md}
    skill_name=${skill_dir##*/}
    destination="$root/$skill_name"

    if [ -L "$destination" ]; then
      current=$(readlink "$destination")
      if [ "$current" = "$skill_dir" ]; then
        continue
      fi
      printf 'Refusing to replace unrelated link: %s -> %s\n' "$destination" "$current" >&2
      exit 1
    fi
    if [ -e "$destination" ]; then
      printf 'Refusing to overwrite existing path: %s\n' "$destination" >&2
      exit 1
    fi
    ln -s "$skill_dir" "$destination"
    printf 'Installed %s in %s\n' "$skill_name" "$root"
  done
}

install_root "${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"
install_root "${SHARED_AGENT_SKILLS_DIR:-$HOME/.agents/skills}"

printf '\nBootstrap complete. Open Anki, enable AnkiConnect, then run:\n  %s/scripts/health-check.sh --online\n' "$repo_dir"

