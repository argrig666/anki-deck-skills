---
name: anki-note-sync
description: Safely edit notes in a local Anki collection and ensure every changed note is marked as a pending local sync change. Use whenever Codex modifies Anki note fields, examples, translations, or metadata.
---

# Anki note sync

Use this skill whenever editing a local Anki collection directly or through an Anki-compatible import/edit workflow.

## Required invariants

- Never edit a live collection while Anki is running. Have the user fully quit Anki first, or stop before mutating the database.
- Create a recoverable backup of the collection before the first write.
- For every edited note, update the note fields and sort field, recompute `csum` from the first field using Anki’s checksum convention (the first 8 hex digits of SHA-1), update `mod`, and set `notes.usn = -1`.
- Mark associated cards as pending local changes with `cards.usn = -1` when the edit changes rendered card content or note data.
- Do not change the collection’s global/server `usn` to fake a sync state.
- Verify the edited note fields and confirm the changed notes have `usn = -1` before telling the user to sync.

## Workflow

1. Locate the actual active profile and collection; do not assume an exported `.apkg` or a temporary inspection copy is the user’s live collection.
2. Identify the exact note IDs and preserve unrelated fields, tags, media references, scheduling data, and card IDs.
3. Back up the collection to a user-visible writable location before editing.
4. Apply edits transactionally. If a transaction fails, roll back and do not claim completion.
5. Reopen/read the saved database after the write and verify representative notes, `notes.usn = -1`, and associated pending cards.
6. Tell the user to restart Anki if it was open during preparation, then perform a normal sync. If Anki presents a local-versus-server conflict, explain that the local copy contains the requested edits and advise the user which side to choose rather than silently choosing.

## Important distinction

`notes.csum` supports duplicate detection and field identity; it is not the marker that makes a note upload. The sync marker for a locally changed note is `usn = -1`. A changed `mod` timestamp alone is also insufficient.

## Scope boundary

This skill governs sync bookkeeping for note edits. It does not authorize inventing missing examples, modifying unrelated decks, deleting notes, or resolving sync conflicts without the user’s explicit choice.
