---
name: start
description: "Guided onboarding for Gemini Code Game Studio. Diagnoses project state and guides the developer into the right game development workflow."
---

# Guided Onboarding (`/start`)

This skill is the primary entry point for new or existing game projects in **Gemini Code Game Studio (GCGS)**. It diagnoses the current project state, determines workflow rigor, and routes the developer to the next logical phase.

---

## Phase 1: Silent Project State Diagnosis

Before asking the user anything, inspect the workspace silently:

1. **Engine Configured?**
   - Check `project.yaml` for `engine.name`. If absent, engine is not yet configured.
2. **Game Concept / Brief Exists?**
   - Check if `design/gdd/game-concept.md` or `design/game-brief.md` exists.
3. **Source Code Exists?**
   - Check the code root (`Assets/Scripts` for Unity, `src/` for Godot, `Source/` for Unreal).
4. **Prototypes or Design Docs?**
   - Check `prototypes/` or markdown files in `design/gdd/`.
5. **Sprint / Production Artifacts?**
   - Check `production/sprints/` or `production/epics/`.

---

## Phase 2: User Onboarding Inquiry

Present the starting inquiry using `ask_question`:

- **Question**: "Welcome to Gemini Code Game Studio! Where are you currently at with your game idea?"
- **Options**:
  - `No idea yet` — I don't have a game concept. I want to brainstorm and discover what to build.
  - `Vague idea` — I have a theme, feeling, or genre in mind (e.g. 'cyberpunk deckbuilder' or 'cozy tavern sim') but no mechanics yet.
  - `Clear concept` — I know the core idea, mechanics, and pitch, but haven't formalized it into documents.
  - `Existing work` — I already have existing code, prototypes, or design docs that I want to continue or organize.

---

## Phase 3: Route Based on User Response

### Path A: No idea yet
- Acknowledge that starting from scratch is great for creative exploration.
- Route to `/brainstorm open`.

### Path B: Vague idea
- Ask the user to share their rough concept, theme, or inspirations.
- Validate and route to `/brainstorm [hint]`.

### Path C: Clear concept
- Ask for a 1–2 sentence summary of the genre and core loop.
- Offer two options:
  1. *Formalize first*: `/brainstorm` to structure the concept document.
  2. *Straight to engine setup*: `/setup-engine` followed by `/design-system`.

### Path D: Existing work
- Report discovered files from Phase 1.
- If engine is unconfigured, run `/setup-engine`.
- If game code exists without design docs, recommend creating a brief or retrofitting GDDs.

---

## Phase 4: Configure Rigor & Stage

### Set Rigor (`modes.rigor`)
If `modes.rigor` is not set in `project.yaml`, prompt the user:
- `minimal` (Recommended for jams/prototypes): 1-page game brief, no heavy docs, rapid iteration.
- `standard` (Balanced indie production): 5 core GDD sections, architecture ADRs, standard QA evidence.
- `full` (Commercial release): Complete 8 GDD sections, comprehensive director reviews, strict regression testing.

Update `project.yaml`:
```yaml
project:
  stage: Concept
modes:
  rigor: [chosen_rigor]
  automation: collaborative
```

Update checkpoint in `production/session-state/active.md`.

---

## Phase 5: Handoff & Next Immediate Action

Summarize the initialized project state and present the single immediate next command to run (e.g., `/brainstorm` or `/setup-engine`).
