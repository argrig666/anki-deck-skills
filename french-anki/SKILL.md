---
name: french-anki
description: Workflow and linguistic conventions for authoring two-way French vocabulary cards in Anki, including gender, phonology, and natural examples.
---

# French Anki

Apply with French Language QA for every French note.

## Confirmed deck & note type

- **Decks:**
  - `French Decks::Class Notes Vocabulary`
  - `French Decks::My French Vocabulary`
- **Note type:** `French Note (Front and Reverse, with examples)`
- **Fields (in order):**
  1. `FrenchWord` — target French word or expression (with article for nouns; infinitive for verbs).
  2. `IPA` — IPA transcription (e.g. `/kɑ̃ bjɛ̃ mɛm/`).
  3. `EnglishWord` — English gloss (formatted per `translation-formatting` skill; multiple distinct senses split across lines `<br>`; secondary Russian translations in a new paragraph `<br><br>`).
  4. `FrenchExample` — natural French example sentence.
  5. `EnglishExample` — English translation of the example sentence.
- **Cards generated:** 2 (front → back and reverse).
- **Tags:** empty array `[]` unless specified.

## Linguistic conventions

- Nouns: include article and gender; add plural or irregular feminine forms when useful.
- Verbs: include infinitive, meaning, auxiliary where relevant, and irregular forms only when
  they support the learning objective.
- Preserve accents, apostrophes, hyphens, ligatures, and capitalization.
- Check liaison/elision-sensitive examples, prepositions, pronoun placement, and agreement.
- Mark register, Canadian/European variation, colloquial forms, and false friends.
- Prefer idiomatic French examples and avoid English-calque syntax.

## Translation formatting

Refer to `translation-formatting/SKILL.md` for full rules:
- Semicolon-separated nuances/clauses in `EnglishWord` are split across lines with `<br>`.
- Any Russian translation (`· <russian>`) is placed in a separate paragraph using `<br><br>` (with `·` stripped).
- Short single-word synonyms (e.g., `fast; quick`, `position; job`) remain on a single line.


