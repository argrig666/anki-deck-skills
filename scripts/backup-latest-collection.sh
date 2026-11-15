#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
source_dir=${ANKI_BACKUP_SOURCE_DIR:-$HOME/Library/Application Support/Anki2/User 1/backups}
target_dir=${ANKI_OFFSITE_BACKUP_DIR:-$repo_dir/recovery/collection-backups}

[ -d "$source_dir" ] || { printf 'Anki backup directory not found: %s\n' "$source_dir" >&2; exit 1; }
latest=$(find "$source_dir" -maxdepth 1 -type f -name '*.colpkg' -print | sort | tail -n 1)
[ -n "$latest" ] || { printf 'No Anki collection backup found in %s\n' "$source_dir" >&2; exit 1; }

mkdir -p "$target_dir"
destination="$target_dir/${latest##*/}"
if [ ! -f "$destination" ]; then
  cp -p "$latest" "$destination"
  printf 'Copied %s\n' "$destination"
else
  printf 'Already backed up: %s\n' "$destination"
fi

if command -v shasum >/dev/null 2>&1; then
  shasum -a 256 "$destination" > "$destination.sha256"
elif command -v sha256sum >/dev/null 2>&1; then
  sha256sum "$destination" > "$destination.sha256"
fi

