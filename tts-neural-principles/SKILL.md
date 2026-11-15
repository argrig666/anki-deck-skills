---
name: tts-neural-principles
description: Architectural and QA principles for text-to-speech (TTS) in language learning. Enforces dedicated monolingual voices over multilingual voices, strict SSML document locale integrity (avoiding hardcoded en-US), cross-platform alias QA, cognate diagnostic testing (the "intégrer" rule), and cache poisoning remediation.
---

# Neural TTS Principles for Language Learning

Generalizing principles and architectural rules for designing, configuring, and auditing Text-to-Speech (TTS) engines and voice pipelines in language-learning environments (Anki, Azure/Edge TTS, gTTS, espeak).

---

## 1. The Monolingual Voice Invariant (Never Use Multilingual Voices as Language Defaults)

- **The Problem**: Speech engines often offer "multilingual" neural voice models (e.g. `fr-FR-VivienneMultilingualNeural`, `fr-FR-RemyMultilingualNeural`, `it-IT-GiuseppeMultilingualNeural`). These models contain acoustic dictionaries and Language Identification (LID) heuristics for multiple languages (typically English + target language).
- **The Failure Mode**: When presented with cognates, loanwords, homographs, or unaccented words shared with English (e.g. *intégrer* / *integrer*, *table*, *restaurant*, *impossible*, *action*, *train*), multilingual models frequently misclassify the token and pronounce it with English phonemes and stress patterns.
- **The Invariant Rule**:
  - **Always default to dedicated, native monolingual neural voices** for target language decks:
    - **French (`fr_FR`)**: `fr-FR-DeniseNeural` (Female), `fr-FR-HenriNeural` (Male), or `fr-FR-EloiseNeural` (Female).
    - **Italian (`it_IT`)**: `it-IT-ElsaNeural` (Female) or `it-IT-DiegoNeural` (Male).
    - **Spanish (`es_ES`)**: `es-ES-ElviraNeural` (Female) or `es-ES-AlvaroNeural` (Male).
    - **German (`de_DE`)**: `de-DE-KatjaNeural` (Female) or `de-DE-ConradNeural` (Male).
    - **Russian (`ru_RU`)**: `ru-RU-SvetlanaNeural` (Female) or `ru-RU-DmitryNeural` (Male).
  - Dedicated monolingual models have **no foreign acoustic dictionary**. They are structurally and acoustically incapable of leaking English phonology or accents into target vocabulary.

---

## 2. SSML Document Locale Integrity (The `xml:lang` Invariant)

- **The Problem**: Many TTS wrapper libraries (including upstream `edge-tts`) hardcode the root document language to English:
  ```xml
  <!-- ANTI-PATTERN: Forces backend to treat document as English -->
  <speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='en-US'>
  ```
- **The Consequence**: Even if a target-language voice is requested, the `xml:lang='en-US'` attribute explicitly informs the synthesis engine that the document content is English. Any voice capable of multilingual speech will obey this instruction and synthesize the text as English.
- **The Invariant Rule**:
  - The root `<speak>` tag's `xml:lang` attribute **must match the exact locale of the target voice**:
    ```xml
    <!-- CORRECT: Document language strictly matches the voice locale -->
    <speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='fr-FR'>
    ```
  - Synthesizers must dynamically derive `xml:lang` from the voice's BCP-47 locale tag (e.g. `voice.split('-')[:2]`), defaulting to `en-US` only if the voice is an English voice.

---

## 3. Cross-Platform Voice Aliasing Discipline

- **The Problem**: Language deck card templates often contain hardcoded client-specific voice tags tailored to macOS or Windows (e.g. `Apple_Audrey_(Premium)`, `Microsoft_Vivienne_(Natural_HD)`).
- **The Invariant Rule**:
  - When writing Linux or cross-platform voice alias tables:
    - Never map standard client voices (`audrey`, `vivienne`) to a multilingual voice model if a dedicated monolingual native voice exists.
    - Map both `Apple_Audrey` and `Microsoft_Vivienne` directly to the dedicated native standard (e.g. `fr-FR-DeniseNeural`).
    - If a user explicitly specifies a multilingual voice by its full canonical name in config, allow it, but ensure Principle 2 (SSML locale integrity) is strictly enforced.

---

## 4. Cognate & Homograph Diagnostic QA (The "Integrer" Benchmark)

Whenever introducing, updating, or auditing a voice, engine, or alias mapping, **never test only with distinct, language-unique words** (like *bonjour* or *ciao*). Words that exist only in the target language mask multilingual leakage bugs because the engine has no English alternative.

- **Mandatory Diagnostic Test Suite**:
  Always test synthesis against true and false cognates, loanwords, and orthographic twins shared with English:
  - **French**: `intégrer`, `integrer`, `table`, `restaurant`, `impossible`, `action`, `route`, `orange`, `police`, `simple`.
  - **Italian**: `camera`, `studio`, `finale`, `originale`, `quota`, `confusione`.
  - **Spanish**: `hotel`, `regular`, `terrible`, `normal`, `general`, `color`.
  - **German**: `hand`, `finger`, `ring`, `name`, `system`, `winter`.
- **Pass Criteria**:
  - Vowel quality must match the target language (e.g. French [e] rather than English [eɪ]).
  - Syllable stress must match target language phonology (e.g. final-syllable stress for French *in-té-grer*, rather than initial English stress *IN-te-grate*).
  - Rhotic consonants must be native (e.g. French uvular [ʁ], Italian rolled [r], never English postalveolar approximant [ɹ]).

---

## 5. Cache Poisoning & Invalidation Discipline

- **The Problem**: TTS add-ons and playback pipelines cache generated audio to disk based on a hash of `(voice, speed, text)` to reduce latency and API calls.
- **The Trap**: If audio was generated under a buggy engine, wrong locale tag, multilingual model, **or a degraded fallback engine (gTTS/espeak) while Edge TTS was failing**, **the corrupted audio is permanently cached**. Fixing the source code or config will NOT fix playback for cards whose audio was already cached.
- **The Invariant Rule**:
  1. **Identify and purge poisoned cache files**: Delete the specific cache files or clear the cache directory when resolving a pronunciation bug.
  2. **Cache Key Versioning**: Ensure the cache key incorporates the exact voice identifier (`voice_id`), audio speed, text, **and synthesis engine** (`edge` / `gtts` / `espeak`), so a temporary fallback cannot overwrite a neural cache slot, and changing the voice mapping creates fresh audio.
  3. **Pre-Warm Critical Terms**: After fixing an engine or alias bug, pre-synthesize the affected words to verify the acoustic waveform and confirm correct playback before handing back to the user.

---

## 6. Edge TTS Client Version Pin (October 2026 Handshake Break)

- **The Problem**: In October 2026, Microsoft changed the Edge Read Aloud WebSocket handshake. Bundled `edge-tts` **7.2.8 and earlier** fail with `WSServerHandshakeError: 403 Invalid response status`. Add-ons that catch this and fall back to gTTS suddenly produce lower-quality (often male-sounding) audio while still logging the requested neural voice name.
- **The Symptom Pattern**: Some cards keep excellent neural audio (pre-outage cache hits); newly synthesized or re-cached cards sound worse until the client is upgraded and the poisoned cache is purged.
- **The Invariant Rule**:
  - Pin or vendor **`edge-tts>=7.3.0`** (7.3.1 verified) in Anki TTS add-ons.
  - After upgrading, **restart Anki** (Python keeps the old module loaded) and **clear TTS caches**.
  - Treat sudden gender/quality changes as an engine/fallback/cache problem before assuming a voice-alias misconfiguration.
  - Upstream tracker: https://github.com/rany2/edge-tts/issues/490
