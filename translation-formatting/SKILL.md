---
name: translation-formatting
description: >-
  Formats multilingual and multiline translation glosses in Anki language decks (e.g. EnglishWord field). Splits multi-part English nuances across lines (<br>) and places secondary/Russian translations into a separate paragraph (<br><br>).
---

# Translation Formatting

Use when formatting, reviewing, or generating translation glosses (such as the `EnglishWord` field) in Anki language-learning decks.

## Core Principle

Raw dictionary imports or notes often cram multiple senses, grammatical usage markers, and secondary language translations into a single continuous line separated by semicolons and middle dots:

> `even if [it were the case]; even then (+ conditional) · даже если бы`

Cramming these into one line hinders visual perception and active recall during review, especially on mobile devices or reverse cards where the translation is the front prompt.

Formatting these into distinct lines and paragraphs creates immediate visual hierarchy:
- **Primary language nuances** appear as stacked lines (`<br>`).
- **Secondary / auxiliary translations** (e.g., Russian, native language) appear in a separate paragraph (`<br><br>`), visually isolated from the primary gloss.
- **Concise single-word synonyms** remain on a single line to preserve card density.

---

## Formatting Conventions

### 1. Primary Gloss (e.g. English) Nuances
- **Delimiter**: Semicolons (`;`) separating distinct nuances or clauses.
- **Transformation**: Replace semicolons with `<br>` line breaks; trim whitespace from each clause.
- **Punctuation**: Omit trailing semicolons at the end of lines for clean visual separation.

### 2. Secondary Language (e.g. Russian) Translations
- **Delimiter**: Middle dot (`·`) or secondary language marker.
- **Transformation**: Move to a new paragraph preceded by `<br><br>`.
- **Delimiter Removal**: Strip the middle dot (`·`) delimiter; it is rendered redundant by the paragraph break.

### 3. Classification Criteria: Multiline vs. Single-Line
Apply line breaks when a card meets any of the following:
- **Bilingual translation**: Contains a secondary language translation separated by `·`.
- **Three or more senses**: Contains 3+ semicolon-separated glosses (e.g., `to retain; to remember; to select; to shortlist`).
- **Grammatical / usage qualifiers**: Contains parenthetical or bracketed notes (e.g., `(+ indicative)`, `(+ subjunctive)`, `(+ infinitive)`, `[noun]`, `(concession)`, `(not: ...)`).
- **Substantive clauses**: Total length $\ge 35$ characters with multiple full clauses.

**Preserve on a single line**:
- Short synonym pairs without grammatical qualifiers (e.g., `fast; quick`, `position; job`, `means; way`, `sorrow; grief`).

---

## Concrete Examples

| Target Expression | Raw / Unformatted Value | Formatted HTML (`EnglishWord`) |
| :--- | :--- | :--- |
| **quand bien même** | `even if [it were the case]; even then (+ conditional) · даже если бы` | `even if [it were the case]<br>even then (+ conditional)<br><br>даже если бы` |
| **faillir** | `to almost [do]; to come close to doing · чуть не / едва не` | `to almost [do]<br>to come close to doing<br><br>чуть не / едва не` |
| **au moins** | `at least (a minimum of) · как минимум` | `at least (a minimum of)<br><br>как минимум` |
| **alors que** | `whereas; while (at the same time); even though (concession) (+ indicative)` | `whereas<br>while (at the same time)<br>even though (concession) (+ indicative)` |
| **retenir** | `to retain; to remember; to select; to shortlist` | `to retain<br>to remember<br>to select<br>to shortlist` |
| **rapide** | `fast; quick` | `fast; quick` *(single line preserved)* |

---

## Automation & Mutation Safety

When running batch reformatting across existing decks:

1. **Pre-mutation Backup**:
   Always export a full `.apkg` with scheduling data (`exportPackage` with `includeSched: true`) before mutating any fields.
2. **In-place Field Mutation**:
   Use AnkiConnect `updateNoteFields` to update only the target field (e.g., `EnglishWord`). Do not recreate notes. Preserve note IDs, card IDs, scheduling history, tags, and media.
3. **Verification**:
   Confirm total note count and card count remain unchanged. Render sample cards for both Front (Card 2) and Back (Card 1) to check visual spacing against deck CSS (`text-align: center`, line heights, font sizes).
