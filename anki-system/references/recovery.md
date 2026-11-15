# Recovery and Redundancy Model

## What survives where

| Layer | Primary | Independent recovery copy | Never rely on |
|---|---|---|---|
| Decks, media, scheduling | AnkiWeb sync | Anki automatic backups and periodic full exports in OneDrive | GitHub or a live database inside OneDrive |
| Card-making rules and project knowledge | Public GitHub repository | OneDrive project copy | Chat history on one machine |
| Agent integration | Installed links under the agent's skills directory | Recreated by `scripts/bootstrap.sh` | Hand-copied, untracked local files |
| Anki automation | Anki + AnkiConnect | Reinstall and verify from documented requirements | A particular computer remaining available |

## New-machine recovery

1. Install Anki and sign into AnkiWeb. Sync from AnkiWeb before creating or editing notes.
2. Install Git. Authentication is needed only when publishing changes to the repository.
3. Clone `https://github.com/argrig666/anki-deck-skills.git` or open the OneDrive copy.
4. Run `scripts/bootstrap.sh` from the repository. It installs links without overwriting
   unrelated local skills.
5. Install or enable AnkiConnect, open Anki, then run `scripts/health-check.sh --online`.
6. If AnkiWeb is unavailable or incomplete, restore the newest verified Anki backup or full
   export. Preserve the damaged collection until recovery is confirmed.

## Normal maintenance

- Sync Anki normally with AnkiWeb before and after work on different machines.
- Let Anki create its automatic backups; periodically verify that a recent backup exists.
- On macOS, run `scripts/install-macos-backup-agent.sh` once. It installs a daily job that
  copies the newest automatic `.colpkg` backup into the OneDrive-backed recovery directory
  without touching the live collection. Keep occasional manual full exports as well,
  especially before structural deck work.
- Do not sync a live Anki profile directory with OneDrive, Dropbox, Git, or similar tools.
- When a durable methodology rule changes, update the relevant skill, run the health check,
  commit, and push. OneDrive provides a second copy of the working tree; GitHub preserves
  version history and remains the authoritative collaboration remote.

## Partial-survivor recovery

- **Only GitHub survives:** clone, bootstrap, restore collection from AnkiWeb.
- **Only OneDrive survives:** open this folder, verify its Git history, bootstrap, and push to
  a replacement remote if necessary.
- **Only an installed skill survives:** inspect its source link or copy, recover the repository
  URL from `anki-system`, clone the repository, and compare before publishing anything.
- **Only an Anki backup survives:** restore the collection, then recover methodology from
  GitHub or OneDrive. The cards alone are not treated as complete documentation of the rules.

## Backup verification

The daily off-site copy includes a SHA-256 checksum beside each copied backup. A backup is not
considered verified merely because its filename exists: confirm the checksum and, after major
structural work, test an import into a disposable Anki profile when practical.

