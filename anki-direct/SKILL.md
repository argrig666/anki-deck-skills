---
name: anki-direct
description: Safe direct interaction and mutation with a running Anki collection via AnkiConnect, preserving card scheduling and IDs.
---

# Anki Direct

Use this workflow when the user asks to interact with a running Anki application directly.

- Prefer the direct Anki integration/tool over creating an intermediate APKG.
- Confirm the target deck and note type before writing.
- Search for existing notes before adding new ones; avoid duplicates.
- Create or update only the fields and tags requested.
- Preserve existing scheduling, note IDs, card templates, and media unless the user explicitly
  asks to change them.
- After mutation, verify the resulting note/card count and report what changed.
- If direct Anki access is unavailable, say so and offer an explicitly requested APKG or TSV
  export as a fallback; do not imply that a direct write occurred.

