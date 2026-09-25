# Gemini Code Game Studio (GCGS)

> **Transform Gemini and Antigravity into a full-scale professional game development studio.**  
> 49 coordinated specialist roles. 74 progressive skills. Native Windows lifecycle hooks. Built with first-class support for **Unity 6 LTS (C#)**.

---

## Table of Contents

- [Why This Exists](#why-this-exists)
- [Studio Architecture & Hierarchy](#studio-architecture--hierarchy)
- [Core Collaboration Protocol](#core-collaboration-protocol)
- [Quick Start Guide](#quick-start-guide)
- [Workflow Skills Cheatsheet](#workflow-skills-cheatsheet)
- [Non-Negotiable Development Commandments](#non-negotiable-development-commandments)
- [Directory Structure](#directory-structure)
- [Configuration & Rigor Modes](#configuration--rigor-modes)
- [Automated Safety & Lifecycle Hooks](#automated-safety--lifecycle-hooks)
- [Credits & Acknowledgments](#credits--acknowledgments)

---

## Why This Exists

Building a game solo with AI often suffers from a lack of discipline: models write spaghetti code, hardcode magic numbers, bypass design reviews, and hallucinate architectures that don't scale.

**Gemini Code Game Studio** solves this by structuring your session into a professional game studio hierarchy. Instead of an unconstrained generic assistant, you collaborate with **49 specialized agents** (Directors, Department Leads, and Specialists) who enforce separation of concerns, engine best practices, and test verification before closing features.

**You remain in total control:** The AI provides architecture, domain expertise, and rigorous quality gates, while the user makes all strategic and final calls.

---

## Studio Architecture & Hierarchy

The studio is organized into three distinct tiers:

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
  ├── Unity 6: unity-specialist, unity-dots, unity-addressables, unity-ui, unity-shaders
  ├── Godot 4: godot-specialist, godot-gdscript, godot-csharp, godot-gdextension, godot-shaders
  └── Unreal 5: unreal-specialist, ue-gas, ue-blueprints, ue-replication, ue-umg
```

---

## Core Collaboration Protocol

Every major design and coding task adheres to the **5-step collaborative cycle**:

1. **Question**: Ask clarifying questions before proposing architectures or mechanics.
2. **Options**: Present 2–3 viable options with clear pros/cons and trade-offs.
3. **Decision**: The user selects the path forward.
4. **Draft**: Show work in progress (code snippets, document sections) before writing to disk.
5. **Approval**: Always confirm with the user before committing file changes.

---

## Quick Start Guide

### Step 1: Clone or Open Workspace
Open this folder in your Antigravity IDE or Gemini environment.

### Step 2: Run `/start`
Type `/start` in the chat. The studio will silently diagnose the repository and guide you:
- **No idea yet?** → Routes to `/brainstorm open` to explore themes and mechanics.
- **Vague idea?** → Routes to `/brainstorm [theme]` to structure the concept.
- **Clear concept?** → Formats the concept into a Lean Brief or full GDD.
- **Existing project?** → Audits existing scripts and design documents.

### Step 3: Implement Features with `/dev-story`
Once stories are generated via `/create-stories`, implement them step-by-step with architecture reviews, automated unit tests, and visual verification.

---

## Workflow Skills Cheatsheet

Type `/` to invoke any of the **74 available skills**:

| Category | Primary Skills | Description |
|---|---|---|
| **Onboarding** | `/start`, `/setup-engine`, `/help`, `/project-stage-detect` | Initialize project, configure engine, detect stage. |
| **Design** | `/brainstorm`, `/design-system`, `/map-systems`, `/quick-design` | Conceptualize game, write system GDDs, map dependencies. |
| **Architecture** | `/create-architecture`, `/architecture-decision` (ADRs), `/create-control-manifest` | Technical blueprints and decision records. |
| **Production** | `/create-epics`, `/create-stories`, `/sprint-plan`, `/scope-check` | Break systems into bite-sized developer stories. |
| **Development** | `/dev-story`, `/code-review`, `/tech-debt`, `/story-done` | Implement code, write unit tests, verify features. |
| **Visual & UI** | `/art-bible`, `/asset-spec`, `/ux-design`, `/ux-review` | Visual identity, HUD design, and UI Toolkit specs. |
| **QA & Testing** | `/qa-plan`, `/smoke-check`, `/regression-suite`, `/test-evidence-review` | Automated tests and visual verification checklists. |
| **Release** | `/launch-checklist`, `/changelog`, `/patch-notes`, `/hotfix` | Prepare builds, generate changelogs, manage updates. |

---

## Non-Negotiable Development Commandments

- **Data-Driven Gameplay**: Never hardcode values (speeds, damage, costs). Store gameplay numbers in `ScriptableObject` assets (Unity) or external JSON configs.
- **Decoupled Architecture**: UI must never own game state. Use events, observables, or message brokers for inter-system communication.
- **Run and Observe**: A story modifying visuals or gameplay is not complete until it has been tested and visually confirmed. Save screenshots/evidence in `production/qa/evidence/`.
- **Session Continuity**: `production/session-state/active.md` is the project memory checkpoint. It persists active context across session restarts.
- **Zero Allocations in Hot Paths**: `Update()` and `FixedUpdate()` loops must produce 0 bytes of heap garbage (`GC.Alloc = 0`).

---

## Directory Structure

```
00 Gemini Code Game Studio/
├── GEMINI.md                          # Master studio instructions
├── project.yaml                       # Master studio configuration
├── .gitignore                         # Unity & Studio git ignore patterns
├── .agents/
│   ├── hooks.json                     # Native PowerShell lifecycle hooks
│   ├── hooks/                         # Validation and context injection scripts
│   ├── agents/                        # 49 Role definitions & guidelines
│   ├── skills/                        # 74 Slash skills (SKILL.md)
│   └── rules/                         # Path-scoped coding standards
├── Assets/                            # Unity game code & assets
│   ├── Scripts/                       # C# source code (Core, Gameplay, UI, Data)
│   └── Tests/                         # NUnit automated tests (Editor & Runtime)
├── design/gdd/                        # Game Design Documents (GDDs) & briefs
├── docs/
│   ├── templates/                     # 39 Standardized document templates
│   ├── engine-reference/unity/        # Unity 6 LTS reference & best practices
│   └── architecture/                  # Architecture Decision Records (ADRs)
└── production/
    ├── session-state/active.md        # Session memory checkpoint
    └── qa/evidence/                   # Visual test evidence (screenshots & logs)
```

---

## Configuration & Rigor Modes

The file [`project.yaml`](file:///d:/Documents/UnityProjects/00%20Gemini%20Code%20Game%20Studio/project.yaml) controls studio behavior:

- **`modes.rigor`**:
  - `minimal` (Default): Game Jam speed. 1-page lean brief (`design/game-brief.md`), solo lead review, fast iteration.
  - `standard`: Balanced production. 5 required GDD sections, ADRs, standard QA evidence.
  - `full`: Commercial release. 8 required GDD sections, all director reviews, full regression suite.
- **`modes.automation`**: `collaborative` (always ask before write) | `semi-autonomous` | `autonomous`.

---

## Automated Safety & Lifecycle Hooks

Configured in [`.agents/hooks.json`](file:///d:/Documents/UnityProjects/00%20Gemini%20Code%20Game%20Studio/.agents/hooks.json) with native PowerShell scripts:

1. **`validate-command.ps1` (`PreToolUse`)**: Blocks destructive git operations (force push, reset hard) and validates commit messages.
2. **`session-context.ps1` (`PreInvocation`)**: Automatically injects current task context from `active.md` into the model prompt.
3. **`validate-file.ps1` (`PostToolUse`)**: Enforces file modification quality checks.

---

## Credits & Acknowledgments

**Gemini Code Game Studio (GCGS)** is an adaptation and evolution of the outstanding open-source project **[Claude Code Game Studios (CCGS)](https://github.com/Donchitos/Claude-Code-Game-Studios)**, created by **[Donchitos](https://github.com/Donchitos)**.

- **Original Architecture & Concept**: The 49-agent studio hierarchy, 7-phase game development pipeline, collaboration protocol (*Question → Options → Decision → Draft → Approval*), and foundational skills/templates were originally designed and engineered by Donchitos for Claude Code.
- **Gemini / Antigravity Evolution**: Adapted to Google DeepMind's Gemini and Antigravity ecosystem with native Windows PowerShell lifecycle hooks, `.agents/` customizations, progressive disclosure, and first-class Unity 6 LTS scaffolding.
- **Support the Original Creator**: If you find this studio architecture valuable, please consider supporting Donchitos:
  - ☕ [Buy Me a Coffee](https://www.buymeacoffee.com/donchitos3)
  - 💖 [GitHub Sponsors](https://github.com/sponsors/Donchitos)
  - ⭐ [Claude Code Game Studios on GitHub](https://github.com/Donchitos/Claude-Code-Game-Studios)

---

## License

This project is open-source under the [MIT License](LICENSE), honoring the original licensing of Claude Code Game Studios.

