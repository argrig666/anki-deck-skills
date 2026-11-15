#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
template="$repo_dir/macos/com.argrig.anki-offsite-backup.plist.template"
launch_agents_dir="$HOME/Library/LaunchAgents"
destination="$launch_agents_dir/com.argrig.anki-offsite-backup.plist"
backup_dir=${ANKI_OFFSITE_BACKUP_DIR:-$repo_dir/recovery/collection-backups}
runner_dir="$HOME/Library/Application Support/AnkiOffsiteBackup"
runner="$runner_dir/backup-latest-collection.sh"

mkdir -p "$launch_agents_dir" "$backup_dir" "$runner_dir"
cp "$repo_dir/scripts/backup-latest-collection.sh" "$runner"
chmod +x "$runner"
escaped_script=$(printf '%s' "$runner" | sed 's/[&|]/\\&/g')
escaped_backup=$(printf '%s' "$backup_dir" | sed 's/[&|]/\\&/g')
sed -e "s|__SCRIPT_PATH__|$escaped_script|g" -e "s|__BACKUP_PATH__|$escaped_backup|g" "$template" > "$destination"
plutil -lint "$destination" >/dev/null

launchctl bootout "gui/$(id -u)/com.argrig.anki-offsite-backup" >/dev/null 2>&1 || true
launchctl bootstrap "gui/$(id -u)" "$destination"
launchctl kickstart -k "gui/$(id -u)/com.argrig.anki-offsite-backup"
printf 'Installed daily Anki off-site backup job: %s\n' "$destination"

