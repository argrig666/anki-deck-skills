---
name: italian-anki
description: Workflow and conventions for authoring two-way Italian vocabulary cards in Italian Decks::My Italian Vocabulary via AnkiConnect or direct edit, including IPA, stress-marked examples, didactic value-added sentences, and pedagogical rules for -ire verbs with -isc-.
---

# Italian Anki

Apply with Italian Language QA for every Italian note.

## Confirmed deck & note type

- **Deck:** `Italian Decks::My Italian Vocabulary`
- **Note type:** `Italian Note (Front and Reverse, with examples)`
- **Fields (in order):**
  1. `ItalianWord` — lemma with article for nouns (e.g. `la modifica`, `il pelago`,
     `un intervento`); infinitive for verbs with usage note when needed
     (e.g. `convenire (conviene + inf)`).
  2. `IPA` — IPA transcription in slashes (e.g. `/moˈdi.fi.ka/`).
  3. `EnglishWord` — concise English gloss; multiple senses separated by semicolons
     (e.g. `a change; a modification; an amendment`). Part-of-speech labels or HTML
     `<br>` separators only when needed to disambiguate (e.g. `(aggettivo)<br>surrounded`).
  4. `ItalianExample` — short natural sentence with **stress-marked vowels** using
     diacritics on stressed syllables of polysyllabic words
     (e.g. `Abbiàmo approvàto la modìfica al contràtto sénza problèmi.`).
  5. `EnglishExample` — accurate English translation of the example sentence.
- **Cards generated:** 2 (front → back and reverse), per the note type template.
- **Tags:** empty array `[]` unless the user specifies tags.

## Linguistic conventions

- Nouns: include article and gender, e.g. `la finestra (f.)`; show plural when irregular or
  especially useful.
- Verbs and verbal expressions: choose the `ItalianWord` headword for durable learning value.
  Retain a conjugated form only when the expression is predominantly learned and used in that
  fixed form and the conjugation is genuinely dominant (for example, `mi è passato di mente`
  and `non importa`). Otherwise use the infinitive whenever person, number, tense, or context
  naturally changes the surface form. Preserve required clitics and particles: prefer
  `avercelo`, `esserci`, `non vedere l'ora`, `stare a vedere`, and `trattarsi di`, rather than
  `ce l'ho`, `ci sarà`, `non vedo l'ora`, `staremo a vedere`, or `si tratta di` on the front.
  When uncertain whether one conjugated form is unequivocally dominant, default to the
  infinitive. Put the most common natural conjugated form in `ItalianExample` to increase the
  card's didactic payload. Also record meaning, transitivity/reflexivity, and irregular forms
  when they matter.
- **`-ire` verbs with `-isc-` infix**: For third-conjugation verbs that insert the `-isc-` infix in conjugated forms (e.g. *capire*, *finire*, *preferire*, *spedire*, *costruire*, *chiarire*, *unire*), the example sentence in `ItalianExample` must use a conjugated form featuring `-isc-` (present indicative or subjunctive 1st/2nd/3rd sing. or 3rd plur.: *capisco*, *finisce*, *preferiscono*) rather than an infinitive, compound tense, or non-infix form. This provides key didactic value by actively illustrating the verb's conjugation class.
- Record preposition + article contractions explicitly (`a + il → al`, etc.).
- For clitics, idioms, and fixed prepositions, prefer a natural sentence over a literal gloss.
- Check agreement, elision, apostrophes, doubled consonants, and accents (`è/e`, `l'acqua`,
  `un po'`).
- Label formal, informal, regional, literary, archaic, or technical usage.
- Distinguish false friends and multiple senses rather than collapsing them into one gloss.

## Didactic value and example sentence principles

A foundational principle of this deck is that every example sentence must maximize didactic value for the learner:
- **Natural usage in context**: The example must showcase authentic, idiomatic contemporary Italian rather than an artificial or simplistic translation.
- **Reinforce grammatical intuition**: Wherever possible, structure sentences to reinforce subconscious grammatical reflexes (e.g. governing prepositions/valency, subjunctive triggers, clitic placement, auxiliary selection, past participle agreement).
- **Introduce useful phrasing**: Expose the learner to natural connectors, transitionals, and collocations (*a quanto pare*, *in modo da*, *non poter fare a meno di*, *prima di + inf*, *senza che + cong*).
- **Avoid throwaway sentences**: Reject trivial filler sentences (e.g. *"Vedo il tavolo"*); every example should provide dual value by exercising the target word in a rich, instructive context.
- **Conjugation patterns**: For third-conjugation (`-ire`) verbs taking `-isc-` (*capire*, *finire*, *preferire*, *spedire*), always use a conjugated form with `-isc-` in the example.

## Stress marking in examples

Every Italian example sentence must mark stressed vowels on polysyllabic words using
diacritics (grave for open vowels, acute for close vowels), matching the convention
established in the deck. Monosyllables and function words (articles, prepositions, clitics)
are left unmarked unless they carry a standard orthographic accent (e.g. `è`, `più`).

## Adding a note — required workflow

1. **Duplicate check** — search `deck:"Italian Decks::My Italian Vocabulary"` for the
   target word before proposing.
2. **Present the note** — show all 5 fields in a table for user review.
3. **Add via AnkiConnect** — use `addNote` with `allowDuplicate: false` and
   `duplicateScope: "deck"`.
4. **Verify** — call `notesInfo` on the returned note ID and confirm:
   - correct note type and deck
   - all 5 fields populated
   - 2 cards generated
   - no error
