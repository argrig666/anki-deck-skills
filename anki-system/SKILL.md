---
name: anki-system
description: Recover, orient, maintain, or route work within the user's complete Anki language-learning system. Use when the user refers to their usual Anki workflow, moves to a new machine, asks about backup or synchronization, or gives a durable deck-building preference that should survive across chats and computers.
---

# Anki System

Treat this repository as the versioned source of truth for the user's Anki methodology. The
system has three independently recoverable layers:

1. **Collection data:** AnkiWeb sync plus Anki's automatic collection backups. Do not store a
   live `collection.anki2` database in Git or a cloud-synced folder.
2. **Methodology:** this GitHub repository, mirrored by the OneDrive working copy. It contains
   card conventions, language QA, examples, deck engineering, and safe mutation workflows.
3. **Machine integration:** installed skills and AnkiConnect. Recreate these from the repository
   with `scripts/bootstrap.sh`; do not rely on remembered local configuration.

## Task routing

- Italian cards or audits: read `italian-anki`, `italian-language-qa`, and
  `italian-didactic-examples`.
- French or Russian cards: read the corresponding language skill plus
  `language-card-authoring` and `translation-formatting`.
- Live Anki inspection or additions: read `anki-direct`. Preserve its confirmation boundaries.
- Deck structure, imports, exports, or model changes: read `anki-deck-engineering`.
- Collection recovery or synchronization: read `references/recovery.md` before acting.
- Durable new preference: update the narrowest relevant skill, validate, commit, and push.

## Continuity rule

Do not make the user restate an established convention. Search this repository first. If a
new instruction changes a durable convention, reconcile it with existing guidance and record
the result here. Keep examples only when they clarify a decision boundary.

## Health check

Run `scripts/health-check.sh` when setting up a machine, diagnosing drift, or before claiming
the system is recoverable. Read `references/recovery.md` for the recovery order and backup
boundaries.

