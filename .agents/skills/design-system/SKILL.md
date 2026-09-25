---
name: design-system
description: "Section-by-section Game Design Document (GDD) authoring for a gameplay system with mechanics, formulas, and acceptance criteria."
---

# Design System (`/design-system`)

This skill drives the systematic authoring of a **Game Design Document (GDD)** for an individual game system under the guidance of the **Lead Game Designer**.

---

## 1. Parse Arguments

- `/design-system <system-name>` — e.g. `/design-system combat` or `/design-system inventory`
- `/design-system retrofit <file-path>` — Audit and fill missing sections in an existing GDD.
- If no argument is provided:
  - Check `design/gdd/systems-index.md` for unapproved systems.
  - Or prompt the user for the system name via `ask_question`.

---

## 2. System GDD Authoring Sections

To keep context clean and avoid hallucinated walls of text, author each section **incrementally**, discussing and getting approval before persisting:

### Section 1: System Overview & Player Experience
- High-level summary of the system and how it serves the core game pillars.
- The player feeling it creates.

### Section 2: Core Rules & Mechanics
- Detailed mechanics, user inputs, state transitions, and behaviors.
- State machines must explicitly list states (e.g. `Idle`, `Windup`, `Active`, `Recovery`, `Stunned`).

### Section 3: Mathematical Formulas & Data Tables
- Every gameplay number must have an explicit formula.
- List all variables, default values, minimums, maximums, and curves:
  ```markdown
  Formula: FinalDamage = (BaseDamage + StatMultiplier * Power) * (1 - TargetArmor / (TargetArmor + 100))
  | Variable | Type | Default | Range | Description |
  | BaseDamage | float | 25.0 | [1.0, 999.0] | Weapon flat damage |
  | TargetArmor | float | 10.0 | [0.0, 500.0] | Damage reduction coefficient |
  ```

### Section 4: Edge Cases & Anti-Exploit Rules
- What happens when inputs interrupt animations?
- How does the system behave when resources are 0 or maxed?
- Counter-measures against cheesy or degenerate player tactics.

### Section 5: Data Architecture & System Dependencies
- Expected data storage (ScriptableObject in Unity, Resource in Godot, DataAsset in Unreal).
- Other systems this system listens to or sends events to (decoupled communication).

### Section 6: Acceptance Criteria (Given-When-Then)
- Explicit criteria required before any story based on this GDD can be considered Done:
  - *Given* player has 10 stamina, *When* heavy attack is pressed, *Then* attack fails and stamina flashes red.

---

## 3. Persistence & Session State

1. Present the completed GDD summary and confirm with user.
2. Save document to `design/gdd/[system-name].md`.
3. Update `production/session-state/active.md` checkpoint:
   - Record system GDD status as Approved.

---

## 4. Next Steps

- Recommend running `/create-architecture` or `/create-stories [system-name]`.
