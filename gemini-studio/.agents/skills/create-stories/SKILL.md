---
name: create-stories
description: "Break an epic, GDD, or MVP list into bite-sized, implementable developer user stories with acceptance criteria."
---

# Create Stories (`/create-stories`)

This skill takes an Epic, System GDD, or Lean Brief MVP list and breaks it down into small, implementable, testable developer stories under the direction of the **Producer**.

---

## 1. Parse Arguments & Context

- `/create-stories <epic-or-system>` — e.g. `/create-stories combat` or `/create-stories movement`
- If no argument is provided:
  - At `rigor: minimal`, read `design/game-brief.md` and use the MVP feature list.
  - At `rigor: standard`/`full`, scan `production/epics/` or `design/gdd/` for approved systems without stories.

---

## 2. Story Sizing Principles

1. **Focused Scope**: Each story should be implementable in a single focused session.
2. **Clear Traceability**: Every story must link back to its design requirement (GDD section or Brief MVP item).
3. **Discrete Acceptance Criteria**: 2–4 unambiguous acceptance criteria in Given-When-Then format.
4. **Verified Definition of Done**:
   - Code written following project standards.
   - Unit tests covering edge cases.
   - Run-and-observe visual evidence captured in `production/qa/evidence/` if the story affects graphics or UI.

---

## 3. Story Document Template

Write stories to `production/epics/[epic-slug]/story-[NNN]-[slug].md`:

```markdown
# Story [NNN]: [Descriptive Title]

**Epic**: [Epic Name]
**Status**: Ready
**Assigned Specialist**: [e.g. gameplay-programmer, ui-programmer, unity-specialist]

## Goal
As a [player / developer],
I want to [perform action / use system],
So that [benefit / gameplay result].

## Technical Context
- Target Engine: [Unity / Godot / Unreal]
- Code Location: [e.g. Assets/Scripts/Combat/]
- Data Architecture: [e.g. ScriptableObject AttackConfig]

## Acceptance Criteria
- [ ] **AC 1**: Given [precondition], When [action], Then [expected outcome].
- [ ] **AC 2**: Edge Case: Given [boundary], When [action], Then [safe failure or clamped value].

## Definition of Done
- [ ] Code passes coding standards (no hardcoded magic numbers, decoupled).
- [ ] Logic covered by unit tests.
- [ ] Visual verification confirmed and screenshot saved in `production/qa/evidence/`.
```

---

## 4. Sequence & Dependency Ordering

Order the generated stories sequentially:
- Story 001: Data configuration & interfaces (e.g. `AttackData` ScriptableObject).
- Story 002: Core logic & state machine.
- Story 003: Integration with physics/hitboxes.
- Story 004: Player feedback, audio/VFX triggers, and UI hookup.

Update `production/session-state/active.md` with the new story queue.

---

## 5. Next Steps

- Select the first story and run `/dev-story [story-path]`.
