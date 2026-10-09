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
- Update `production/session-state/active.md` checkpoint:
  - Mark active story path and current phase (`Implementation`).

---

## 2. Technical Context Gathering

Before writing any code:

1. **Read Engine & Paths**:
   - Check `project.yaml` for `engine.name`, `code_root` (e.g. `Assets/Scripts`), `rigor`, and `qa.level`.
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
   - Store gameplay parameters in `ScriptableObject` assets in `Assets/Scripts/Data/`.
   - Never hardcode gameplay numbers.
2. **Core Logic**:
   - Implement decoupled C# components using `Time.deltaTime` for frame-rate independence.
   - Keep presentation and UI strictly decoupled (views never own game state).
3. **Automated Unit Tests**:
   - **At `qa.level: minimal`**: Automated tests for pure logic are waived/optional to prioritize speed.
   - **At `qa.level: standard` or `full`**: Create a test class under `Assets/Tests/Editor/` or `Assets/Tests/Runtime/` (NUnit / Unity Test Framework). Write tests validating formulas and edge cases.

---

## 5. Run & Observe Verification

A story is not complete with code alone if it affects gameplay or visuals:

1. Instruct the user on how to attach components, configure prefabs, or test in the Unity Editor.
2. For UI or visual/feel stories, capture and save a retained verification screenshot to:
   `production/qa/evidence/story-[NNN]-verification.png` (or `production/qa/evidence/[story-slug]/`).
3. Record `Run result: OBSERVED production/qa/evidence/...` (Visual verification is required at ALL rigor levels, including `minimal`).

---

## 6. Implementation Summary & Handoff

1. Update the story markdown file:
   - Check off implemented Acceptance Criteria.
   - Set `Status: In Review` (or `Status: In Progress` if partially complete).
2. Update `production/session-state/active.md`:
   - Record completed implementation files.
   - Record `Run result:` and test evidence paths.
   - Set next recommended action: `/story-done [story-path]`.
3. Present Implementation Summary:
   - Files created / modified.
   - Test status & Run result.
   - **Next step**:
     - At `rigor: minimal`: Run `/story-done [story-path]` directly to verify and close.
     - At `rigor: standard` / `full`: Run `/code-review [files]` then `/story-done [story-path]`.
