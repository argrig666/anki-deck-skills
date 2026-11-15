---
name: language-card-authoring
description: Language-agnostic card creation, card-type selection (recognition, production, cloze, minimal pairs), and content quality standards.
---

# Language Card Authoring

Use this pipeline for Italian, French, Russian, or another language.

## Input contract

Extract the target expression, intended sense, part of speech, morphology, register, example
sentence, translation, source, and desired audio. If any meaning is ambiguous, ask or flag it;
do not silently choose a sense.

## Card selection

- Recognition: target on the front, meaning/context on the back.
- Production: meaning or context on the front, target on the back.
- Sentence/cloze: hide the target form while preserving enough context.
- Minimal pair: contrast only closely related forms that are easy to confuse.
- Reverse cards are optional and should be used only when the reverse prompt is natural.

Prefer one direction per learning objective. Avoid mechanically generating reverse cards for
phrases, polysemous words, or answers with many valid translations.

## Content quality

- Keep one primary answer; list alternatives only when pedagogically useful.
- Include gender/article, conjugation, case, stress, or register when omission would make the
  answer underdetermined.
- Use a short, natural example sentence and translate it accurately.
- Do not overload the back with dictionary material; put optional detail in an extra field.

