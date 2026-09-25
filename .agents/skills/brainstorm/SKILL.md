---
name: brainstorm
description: "Guided game concept ideation and design framing using MDA frameworks, player psychology, and creative director guidance."
---

# Game Concept Ideation (`/brainstorm`)

This skill drives the creative conceptualization of the game under the guidance of the **Creative Director**. It turns vague ideas or open themes into a structured, executable game vision.

---

## 1. Parse Arguments & Check Rigor

- `/brainstorm [theme/genre hint]` — e.g. `/brainstorm sci-fi deckbuilder` or `/brainstorm cozy farming`
- `/brainstorm open` — Open exploration with no prior constraints.
- Read `modes.rigor` from `project.yaml`.
  - **`minimal`** → Executes the **Lean Brief flow** (outputs `design/game-brief.md`).
  - **`standard` / `full`** → Executes the **Full Game Concept flow** (outputs `design/gdd/game-concept.md`).

---

## 2. Flow A: Lean Brief Flow (`rigor: minimal`)

For game jams or rapid prototypes, keep documentation concise and fast:

1. **Ideation**:
   - Propose 2–3 punchy one-line concepts combining distinct mechanics or themes.
   - Use `ask_question` to select or refine.
2. **Fill Core Brief Fields**:
   - **One-sentence Pitch**: High-energy elevator pitch.
   - **Core Gameplay Loop**: 3-step loop (e.g. *Explore → Gather → Craft/Upgrade*).
   - **MVP Feature List**: 4–6 indispensable mechanics (becomes stories downstream).
   - **Out of Scope**: Explicit list of features NOT being built.
   - **Target Feel & Art Style**: 1–2 descriptive lines.
3. **Approval & Save**:
   - Present the draft in chat.
   - Upon confirmation, save to `design/game-brief.md`.
4. **Next Steps**:
   - Route directly to `/create-stories` or `/dev-story`.

---

## 3. Flow B: Full Game Concept (`rigor: standard` / `full`)

For structured commercial or long-term production:

1. **Step 1: Core Fantasy & Verb Exploration**:
   - Identify the primary verbs (e.g. *Dash, Parry, Hack, Trade, Build*).
   - Define the player fantasy: *What does the player feel while executing these verbs?*
2. **Step 2: Define the 3 Core Pillars**:
   - Author 3 non-negotiable design pillars that govern all future feature decisions.
3. **Step 3: MDA Breakdown (Mechanics, Dynamics, Aesthetics)**:
   - Mechanics: Rules, physics, cards, input definitions.
   - Dynamics: Run-time interactions (emergent strategies, risk/reward tension).
   - Aesthetics: Emotional response (discovery, challenge, expression).
4. **Step 4: Visual & Auditory Anchor**:
   - Define visual style, color palette, lighting mood.
   - *Optional*: Use `generate_image` to produce a concept art artifact illustrating the visual anchor.
5. **Step 5: Scope Tiers**:
   - Tier 1: MVP (Vertical slice).
   - Tier 2: Target Release (Complete feature set).
   - Tier 3: Post-Launch / Stretch goals.
6. **Approval & Document Generation**:
   - Confirm with user and write to `design/gdd/game-concept.md`.
   - Update `production/session-state/active.md`.

---

## 4. Next Steps

- Proceed to `/art-bible` or `/map-systems`.
