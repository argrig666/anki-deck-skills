---
name: anki-deck-engineering
description: Deck architecture, field design, template validation, and format specifications for Anki language decks.
---

# Anki Deck Engineering

Use this workflow whenever creating, repairing, updating, converting, inspecting, or
validating an Anki deck.

## Card design

- Prefer atomic notes: one durable fact or usage distinction per note.
- Use the smallest useful number of fields, with stable field names.
- Keep prompts unambiguous and answers concise.
- Use examples that demonstrate the target meaning or grammar point.
- Preserve accents, apostrophes, capitalization, and punctuation exactly where relevant.
- Avoid duplicate notes; define a deterministic duplicate key such as lemma + sense + part of speech.
- Add tags that describe language level, topic, grammar, and source when useful.

## Italian vocabulary deck — confirmed format

- **Deck:** `Italian Decks::My Italian Vocabulary`
- **Note type:** `Italian Note (Front and Reverse, with examples)`
- **Fields:** `ItalianWord`, `IPA`, `EnglishWord`, `ItalianExample`, `EnglishExample`
- **Cards:** 2 per note (front → back and reverse)
- **Tags:** empty unless user specifies otherwise
- Nouns carry their article (e.g. `la modifica`, `un intervento`).
- Verbs carry infinitive and usage patterns (e.g. `convenire (conviene + inf)`). For `-ire` verbs with the `-isc-` infix (e.g. `capire`, `finire`, `preferire`), the Italian example must demonstrate a conjugated `-isc-` form (e.g. `capisco`, `finisce`) for didactic value.
- Italian examples must provide high didactic value: exemplify natural usage, reinforce grammatical intuition (valency, triggers, agreement), expose to useful phrasing/collocations, and avoid throwaway filler.
- Italian examples use stress-marking diacritics on polysyllabic words.
- English glosses use semicolons to separate senses.

## Construction and validation

1. Inspect the input material and identify the intended note type, fields, templates, deck,
   tags, and media.
2. Normalize only mechanically; do not change linguistic content without QA.
3. Generate notes with stable IDs or deterministic deduplication.
4. Validate required fields, HTML escaping, template references, tags, media references,
   note counts, and duplicate keys.
5. Render representative cards and inspect front/back readability, cloze behavior, and mobile
   line wrapping when possible.
6. Export only after validation; report the output path, note count, and any warnings.

## Safety

- Treat source/reference files as read-only unless explicitly authorized otherwise.
- Never overwrite an existing deck without a backup or an explicitly requested replacement.
- Do not claim a deck is valid based only on successful file creation; structural and visual
  checks are both required.
