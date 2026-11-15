# Reusable Anki Card-Creation Skills

This is a portable skill bundle for language-learning Anki work, especially Italian, French,
and Russian. It captures the durable workflow abstractions available in this project:

- `anki-core/SKILL.md` — universal note/card engineering and validation
- `anki-deck-engineering/SKILL.md` — deck structure, note models, imports, exports, and validation
- `anki-deck-review/SKILL.md` — systematic deck-content review
- `anki-note-sync/SKILL.md` — safe collection synchronization rules
- `language-card-authoring/SKILL.md` — language-agnostic card-generation workflow
- `italian-anki/SKILL.md` — Italian morphology, usage, and card conventions
- `italian-language-qa/SKILL.md` — Italian linguistic quality assurance
- `italian-didactic-examples/SKILL.md` — high-value Italian example construction
- `french-anki/SKILL.md` — French morphology, usage, and card conventions
- `russian-anki/SKILL.md` — Russian morphology, stress, and card conventions
- `tts-audio/SKILL.md` — text-to-speech generation, naming, and QA
- `tts-neural-principles/SKILL.md` — neural TTS language and voice principles
- `anki-direct/SKILL.md` — safe direct interaction with a running Anki instance
- `translation-formatting/SKILL.md` — multiline translation layout and bilingual paragraph formatting
- `git-verify-and-sync/SKILL.md` — verified Git and GitHub publishing workflow

## Cross-machine use

This repository is the versioned source of truth for durable Anki deck-building and
card-authoring instructions. OneDrive may carry working copies, but reusable rules should be
incorporated here and committed so every machine can recover the same behavior.

Clone the repository on a new machine, then link or copy the needed skill directories into
that agent's skills directory. For Codex, place them under `~/.codex/skills/`; multi-agent
setups may instead link them from a shared `~/.agents/skills/` hub. Preserve each skill as a
directory containing its `SKILL.md` and any supporting resources.

## Maintenance rule

When a durable preference or workflow is agreed during deck work, update the relevant skill
here rather than leaving the rule only in chat history. Validate the change, commit it, and
push it so OneDrive, GitHub, and each machine's installed skills do not drift silently.

