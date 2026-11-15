---
name: tts-audio
description: Audio generation and text-to-speech synthesis pipeline for language cards, including voice selection, naming conventions, and quality control.
---

# TTS Audio for Anki

Use when cards include generated pronunciation audio or when configuring/auditing TTS playback pipelines.
For complete architectural invariants on multilingual voices, SSML locale tags, and cognate QA, see `tts-neural-principles`.

## Voice Selection & Generation Rules

- **Dedicated Monolingual Voices Only**: For language learning decks, never default to "multilingual" neural voices (e.g. `fr-FR-VivienneMultilingualNeural`, `it-IT-GiuseppeMultilingualNeural`). Always select dedicated, native monolingual voices (`fr-FR-DeniseNeural`, `it-IT-ElsaNeural`, `es-ES-ElviraNeural`, `de-DE-KatjaNeural`, `ru-RU-SvetlanaNeural`) to prevent English phonetic leakage on shared vocabulary.
- **SSML Locale Integrity**: Never allow hardcoded `xml:lang='en-US'` in synthesis requests. The SSML `<speak>` tag must dynamically match the voice's locale (e.g. `xml:lang='fr-FR'`).
- **Target Text Normalization**: Generate audio from the exact final target text, including diacritics, accents, and punctuation.
- **Granularity**: Prefer one short clip per target expression; use a separate sentence clip when sentence pronunciation is a learning objective.
- Do not synthesize audio for uncertain or unreviewed text.

## File & Cache Discipline

- **Deterministic Naming**: Use collision-resistant names based on language, normalized content hash, and voice/version; never rely on display text alone.
- **Media Storage**: Keep deck audio in the collection media folder (`collection.media`) and reference it with Anki’s `[sound:filename]` syntax.
- **Cache Invalidation**: When fixing voice mappings or pronunciation bugs, immediately delete poisoned cached files. Cache keys must include `(engine, voice, speed, text)` so a gTTS/espeak fallback cannot overwrite a neural Edge slot. A code fix will not take effect if Anki plays old cached files. After October 2026, require vendored `edge-tts>=7.3.0` (403 handshake break on 7.2.8).
- Avoid spaces and fragile punctuation in filenames; preserve Unicode in the spoken text.
- Do not overwrite an existing asset unless the source text or voice version changed.

## QA & Auditing

- **The Cognate Test**: Always audit new voices or language configs against true/false cognates and English-shared orthographic words (e.g. *intégrer*, *table*, *restaurant*, *impossible*). If an English phoneme or English stress is detected, reject the voice/config.
- **Integrity**: Verify the file exists, decodes, has nonzero duration, and is referenced by exactly the intended note(s).
- **Acoustics**: Listen to a sample from every language/voice/batch and check pronunciation, truncation, silence, clipping, and wrong-language output.
- Report missing audio separately from linguistic QA; a card can be linguistically correct but media-incomplete.
