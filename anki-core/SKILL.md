---
name: anki-core
description: Universal note and card engineering, model schemas, and card template design principles across Anki decks.
---

# Anki Core

Use for inspecting, generating, repairing, converting, importing, exporting, or validating
Anki decks.

## Durable principles

- Make each note atomic: one fact, contrast, or communicative use per note.
- Choose the note type before generating content; never let import order define semantics.
- Use stable field names and deterministic duplicate keys.
- Keep prompts unambiguous, answers concise, and examples natural.
- Preserve user HTML, accents, punctuation, tags, media, scheduling, and note IDs unless a
  requested change requires otherwise.
- Treat reference/source files as read-only.

## Required workflow

1. Inspect deck structure: decks, note types, fields, templates, CSS, tags, media, and counts.
2. Infer conventions only from evidence; record assumptions separately.
3. Generate or transform notes with stable deduplication.
4. Validate field counts, required values, HTML escaping, templates, tags, media references,
   duplicate keys, and encoding.
5. Render representative cards and inspect front/back readability and cloze behavior.
6. Back up before mutation and report exact outputs, counts, and warnings.

Never call a file valid merely because Anki accepted its container. Structural and visual QA
are both required.

