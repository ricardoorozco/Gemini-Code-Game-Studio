---
name: dev-story
description: "Implement a developer story: architecture proposal, clean decoupled code, unit tests, and run-and-observe verification."
---

# Dev Story (`/dev-story`)

This skill bridges planning and source code. Under the supervision of the **Lead Programmer**, it reads a story file, plans the architecture, writes the implementation and tests, and verifies the feature.

---

## 1. Parse Arguments & Find Story

- `/dev-story <story-path>` — e.g. `/dev-story production/epics/combat/story-001-base-attack.md`
- If no argument is provided:
  - Check `production/session-state/active.md` for the current in-progress story.
  - If empty, inspect `production/epics/` and present stories with `Status: Ready`.

---

## 2. Technical Context Gathering

Before writing any code:

1. **Read Engine & Paths**:
   - Check `project.yaml` for `engine.name` and `code_root` (e.g. `Assets/Scripts`).
2. **Review Story Acceptance Criteria**:
   - Read every AC and identify required data classes, interfaces, and behaviors.
3. **Inspect Existing Code**:
   - Check existing scripts in the code root to maintain consistent naming conventions, namespaces, and patterns.

---

## 3. Architecture Proposal & Collaboration Gate

Before modifying or creating files, present the architecture plan to the user:

- **Target Files**: List of paths to be created or modified.
- **Class / Component Diagram**: Show responsibilities (SRP).
- **Data Model**: Show config assets (e.g. `AttackConfigSO.cs` as a ScriptableObject).
- **Communication Pattern**: How this system talks to others (C# actions/events, UnityEvents, signals).
- **Ask**: *"Does this architectural structure look good to you, or would you like to make any adjustments before I write the code?"*

Wait for user approval.

---

## 4. Implementation

Once approved:

1. **Data Model First**:
   - Create the configuration class/asset with serialized fields and validation ranges.
   - Never hardcode gameplay numbers.
2. **Core Logic**:
   - Implement the logic, using `deltaTime` for frame-rate independence.
   - Keep presentation and UI strictly decoupled.
3. **Automated Unit Tests**:
   - Create a test class under `tests/` (e.g. `Assets/Tests/Editor/CombatTests.cs`).
   - Write tests validating the primary formulas and edge cases (e.g. damage calculation, cooldown clamping).

---

## 5. Run & Observe Verification

A story is not complete with unit tests alone if it affects gameplay or visuals:

1. Instruct the user on how to attach components or verify in the engine editor.
2. If runtime behavior can be executed or simulated, run it.
3. Save visual confirmation / screenshot in `production/qa/evidence/story-[NNN]-verification.png`.

---

## 6. Story Completion

1. Update the story markdown file:
   - Check off all Acceptance Criteria.
   - Set `Status: Done`.
2. Update `production/session-state/active.md`:
   - Advance task, record completed story, set next story.
3. Recommend running `/code-review` or `/dev-story [next-story]`.
