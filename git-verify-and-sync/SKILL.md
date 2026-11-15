---
name: git-verify-and-sync
description: Workflow for synchronizing Git repositories and publishing GitHub releases immediately upon verifying that changes work. Covers verification checks, package builds, documentation sync, clean commits, git push, and GitHub release asset updates.
---

# Git Verify and Sync Protocol

Use this skill whenever code changes, bug fixes, or features are verified to be working (via automated tests, live execution, or explicit user confirmation) and need to be synchronized with the remote GitHub repository.

## Core Principles

1. **Verification Gate**: Never push or create releases on speculative or unverified code. A git sync or release must be gated on concrete verification:
   - Automated tests passing (`unittest`, `pytest`, linters, etc.).
   - Live runtime verification (e.g. AnkiConnect checks, process logs, runtime inspection).
   - Or user explicit confirmation ("it works!", "perfect!").

2. **Clean Working Tree**: Ensure no stray artifacts, temporary caches (`__pycache__`, debug logs, local runtime databases, temporary files) are tracked in git. Update `.gitignore` as needed before staging.

3. **Artifact Integrity**: If the project produces distributable packages (e.g., `.ankiaddon`, wheels, bundles, tarballs in `dist/`), rebuild them *after* code changes so that release assets precisely match the committed code.

4. **Documentation Sync**: Any configuration key changes, new features, or behavior updates must be reflected in `README.md`, configuration documentation, and user-facing descriptions before committing.

5. **Atomic Releases**: When publishing a new version:
   - Commit changes with descriptive, conventional commit messages.
   - Push to upstream remote (`git push origin <branch>`).
   - Create or update GitHub releases (`gh release create` or `gh release upload --clobber`) with changelog notes and attached release assets.

## Standard Execution Workflow

### Step 1: Pre-Sync Verification Check
- Confirm test suite passes:
  ```bash
  python3 test_*.py
  # or pytest / cargo test / npm test
  ```
- Verify status and untracked files:
  ```bash
  git status
  ```

### Step 2: Build & Package Artifacts
- Run project packager or build script:
  ```bash
  python3 package.py # for Anki addons
  # or npm run build / cargo build --release
  ```

### Step 3: Update Documentation & Versioning
- Check if `README.md`, docs, or manifests reflect the latest version and features.
- Update version in manifests (e.g., `manifest.json`, `pyproject.toml`, `package.json`).

### Step 4: Commit & Push
- Stage only intentional files:
  ```bash
  git add <files>
  git commit -m "<type>(<scope>): <clear description>"
  git push origin <branch>
  ```

### Step 5: Publish or Update GitHub Release
- If creating a new release:
  ```bash
  gh release create <tag> <asset_paths> --title "<title>" --notes "<changelog>"
  ```
- If updating assets for an existing release:
  ```bash
  gh release upload <tag> <asset_paths> --clobber
  ```

### Step 6: Post-Sync Verification
- Verify git status is clean:
  ```bash
  git status
  ```
- Verify remote release:
  ```bash
  gh release view <tag>
  ```
