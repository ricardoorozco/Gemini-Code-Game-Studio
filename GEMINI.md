# Gemini Code Game Studio (GCGS) — Studio Agent Architecture

Transforming Gemini / Antigravity into a full-scale professional game development studio.
Structured into 49 coordinated specialist roles across 3 tiers, with progressive skills, quality gates, and automated safety.

---

## 1. Studio Architecture & Hierarchy

All game development decisions flow through a 3-tier studio hierarchy:

```
Tier 1 — Directors (Strategic Vision & Governance)
  creative-director       technical-director      producer

Tier 2 — Department Leads (Domain Ownership & Quality)
  game-designer           lead-programmer         art-director
  audio-director          narrative-director      qa-lead
  release-manager         localization-lead

Tier 3 — Specialists (Hands-on Implementation)
  gameplay-programmer     engine-programmer       ai-programmer
  network-programmer      tools-programmer        ui-programmer
  systems-designer        level-designer          economy-designer
  technical-artist        sound-designer          writer
  world-builder           ux-designer             prototyper
  performance-analyst     devops-engineer         analytics-engineer
  security-engineer       qa-tester               accessibility-specialist
  live-ops-designer       community-manager

  Engine Specialists:
  ├── Unity:   unity-specialist, unity-dots, unity-addressables, unity-ui, unity-shaders
  ├── Godot:   godot-specialist, godot-gdscript, godot-csharp, godot-gdextension, godot-shaders
  └── Unreal:  unreal-specialist, ue-gas, ue-blueprints, ue-replication, ue-umg
```

Role guidelines and instructions are defined under `.agents/agents/`.

---

## 2. Core Collaboration Protocol

**User-Driven Partnership, Not Blind Autonomy.**
The AI provides structure, domain expertise, and rigorous quality checks. The user makes all strategic and final calls.

Every major task follows the 5-step collaboration cycle:
1. **Question**: Ask clarifying questions before proposing architectures or mechanics.
2. **Options**: Present 2–3 viable options with clear pros/cons and trade-offs.
3. **Decision**: The user selects the path forward.
4. **Draft**: Show work in progress (code snippets, document sections) before writing.
5. **Approval**: Always confirm with the user before committing destructive changes or closing stories.

---

## 3. Core Development Principles

- **Data-Driven Gameplay**: Never hardcode values (speeds, damage, costs). Store gameplay numbers in ScriptableObjects (Unity), Resource files (Godot), or JSON configs.
- **Decoupled Architecture**: UI must never own game state. Use events, signals, or observable patterns for inter-system communication.
- **Run and Observe**: A story modifying visuals or gameplay is not done until it has been tested and visually confirmed. Save screenshots/evidence in `production/qa/evidence/`.
- **Session Continuity**: `production/session-state/active.md` is the project memory checkpoint. Check it at the start of a session or after clearing context to maintain state.

---

## 4. Mandatory Unity Directives (Strict & Non-Negotiable)

1. **Unity Hub Project Initialization**:
   - The Unity project MUST be created by the user from **Unity Hub** (ensuring proper project settings, version pinning, and packages directory).
   - This studio architecture (`.agents/`, `design/`, `docs/`, `production/`, `project.yaml`) is implemented directly in the root directory created by Unity Hub.
   - The studio MUST verify that `ProjectSettings/ProjectVersion.txt` exists before writing game code. If absent, the AI will instruct the user to create the project in Unity Hub first.

2. **No Direct Package Manifest Modification**:
   - The AI MUST NEVER attempt to directly edit `Packages/manifest.json` to install or alter packages.
   - ALL packages (Input System, UI Toolkit, Addressables, URP, etc.) MUST be installed by the user through the **Unity Editor Package Manager** (`Window > Package Manager`).
   - **Package Protocol**:
     1. The AI identifies and guides the user with the exact package name/ID.
     2. The AI pauses and explicitly waits for the user to confirm installation in Unity Editor.
     3. Once confirmed, the AI inspects `Packages/manifest.json` (read-only) to verify presence before proceeding.

---

## 5. Configuration & Modes

- Master configuration resides in `project.yaml`.
- **Rigor Modes (`modes.rigor`)**:
  - `minimal`: Game Jam pace. Terse documentation, solo lead reviews, fast iteration.
  - `standard`: Balanced production. Standard GDD sections, lean reviews, standard QA evidence.
  - `full`: Commercial release. Comprehensive GDD, all director reviews, rigorous regression testing.
- Individual developer preferences can be placed in `project.local.yaml` (gitignored).

---

## 5. Directory Structure Reference

```
project.yaml                       # Master studio configuration
GEMINI.md                          # Master instructions (this file)
.agents/
  agents/                          # 49 Role definitions and guidelines
  skills/                          # Slash skills / workflows (SKILL.md)
  rules/                           # Path-scoped coding and architectural standards
  hooks.json                       # Lifecycle validation hooks
Assets/ (or src/)                  # Game source code, scripts, assets
design/                            # GDDs, narrative bibles, level layouts
docs/                              # Technical architecture, ADRs, engine references
production/                        # Sprint plans, milestones, session checkpoints
  session-state/active.md          # Current session context
  qa/evidence/                     # Visual test evidence (screenshots/logs)
tests/                             # Unit, integration, and playtest suites
prototypes/                        # Isolated experimental mechanics
```
