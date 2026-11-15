---
name: anki-deck-review
description: Audit and correct Italian examples in a user’s real Anki collection, enforcing headword presence, noun gender/article visibility, strict grammar, and natural usage. Use when reviewing or editing Italian Anki decks.
---

# Anki deck review

Use this skill for Italian Anki-deck audits, example correction, and follow-up verification. For any write, also apply the `anki-note-sync` skill’s sync-metadata requirements.

## Locate the real collection

- Inspect the user’s actual Anki profile and deck names before reading or writing notes.
- Do not confuse an exported `.apkg`, a temporary import, a merge/debug collection, or a copied SQLite database with the collection the user uses in Anki.
- If the user identifies a profile and deck, verify that exact profile/deck pair and the note type shown in Anki.
- If the UI and saved database disagree, treat that as a stale or different loaded collection; do not claim the edit is visible until the exact collection is verified.

## Strict Italian review rules

- Every example must contain the card’s main word. For verbs, a valid conjugated or otherwise inflected form is acceptable. Do not accept an example merely because it illustrates the meaning while omitting the target word.
- For nouns, use an article or construction that visibly conveys gender whenever possible. Prefer `un angolo` over only contracted definite `l’angolo`; prefer `un ospedale`, `un esercizio`, `un incidente`, and `un impegno` when the card teaches the masculine noun.
- Correct the headword itself when it has a spelling or article error: `il esercizio` → `l’esercizio`, `il sfidante` → `lo sfidante`.
- Preserve intentional pronunciation/stress markings as annotations; do not treat them as standard orthographic accents.
- Check grammar, agreement, articles, prepositions, tense/mood, reflexive constructions, idiomatic usage, and translation alignment.
- Separate hard errors from merely formal, colloquial, regional, or less-natural alternatives. Report both categories distinctly.
- Flag blank examples, but do not invent replacements unless the user authorizes generating new examples.

## Review output

For each issue, record the card/headword, current example, corrected example, and a concise reason. Group findings into spelling/headword, grammar, article/gender, target-word omission, naturalness/register, translation mismatch, and blank fields. Include exact note IDs or enough identifying context when editing is requested.

## Editing boundary

Do not modify unrelated decks, scheduling data, tags, media, or note fields. Before writing, make a recoverable backup and confirm the exact target collection. After writing, reopen/read the saved collection and verify representative corrections plus pending sync metadata. Do not resolve AnkiWeb conflicts silently; leave the local/server choice to the user.
