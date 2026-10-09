# Gemini Code Game Studio (GCGS)

> **Turn Gemini / Antigravity into a structured game development studio for Unity 6 LTS (C#).**
> 49 specialist roles · 74 workflow skills · 39 document templates · 3 PowerShell safety hooks · one portable folder.

---

## Table of Contents

1. [What is GCGS?](#1-what-is-gcgs)
2. [Install in 3 steps](#2-install-in-3-steps)
3. [What `init.ps1` does](#3-what-initps1-does)
4. [Your first session](#4-your-first-session)
5. [How the studio works](#5-how-the-studio-works)
6. [The 74 skills (slash commands)](#6-the-74-skills-slash-commands)
7. [The 49 roles](#7-the-49-roles)
8. [Development pipeline (7 phases)](#8-development-pipeline-7-phases)
9. [Using GCGS on an existing project (brownfield)](#9-using-gcgs-on-an-existing-project-brownfield)
10. [Mandatory Unity directives](#10-mandatory-unity-directives)
11. [Coding rules applied automatically](#11-coding-rules-applied-automatically)
12. [Hooks (automatic safety and context)](#12-hooks-automatic-safety-and-context)
13. [Configuration (`project.yaml`)](#13-configuration-projectyaml)
14. [Folder reference](#14-folder-reference)
15. [Templates and reference docs](#15-templates-and-reference-docs)
16. [Known limitations](#16-known-limitations)
17. [Credits and license](#17-credits-and-license)

---

## 1. What is GCGS?

When you build a game with an AI assistant on its own, it tends to hardcode numbers, skip design, mix UI with game logic and invent architecture as it goes.

GCGS fixes that by giving the assistant a **studio structure**: roles with defined responsibilities, step-by-step workflows (skills), document templates, coding rules and safety hooks. You stay in charge of every decision; the studio provides structure, expertise and quality gates.

**GCGS is portable.** The whole studio lives in a single folder, `gemini-studio/`. You copy that folder into a Unity project, run one script, and you are ready. Your game files are never overwritten.

---

## 2. Install in 3 steps

**Step 1 — Have a Unity project made with Unity Hub.**
New or existing. `ProjectSettings/ProjectVersion.txt` must exist (that file is created by Unity Hub).

**Step 2 — Copy the `gemini-studio/` folder into the project root.**
Copy **only this folder**. Nothing else is needed.

```
YourUnityProject/
├── Assets/                # untouched
├── Packages/              # untouched
├── ProjectSettings/       # untouched
└── gemini-studio/         # ← the only thing you copy
```

**Step 3 — Run the setup script from the project root.**

```powershell
powershell -ExecutionPolicy Bypass -File ./gemini-studio/init.ps1
```

(It also works from inside `gemini-studio/`: `powershell -ExecutionPolicy Bypass -File ./init.ps1`. The script detects the project root as the parent of `gemini-studio/`.)

After it runs, your project looks like this:

```
YourUnityProject/
├── Assets/ Packages/ ProjectSettings/   # untouched
├── GEMINI.md                            # created by init.ps1 (bridge file)
├── .agents/                             # created by init.ps1
│   ├── skills.json                      #   → points to gemini-studio/.agents/skills
│   ├── hooks.json                       #   → runs scripts in gemini-studio/.agents/hooks/
│   └── rules/                           #   → copy of gemini-studio/.agents/rules/
└── gemini-studio/                       # the studio itself
```

Then open the project in Antigravity (or your Gemini-based editor) and type `/start`.

> **Re-running is safe.** `init.ps1` rewrites `GEMINI.md`, `.agents/skills.json`, `.agents/hooks.json` and re-syncs `.agents/rules/`. It never touches your `Assets/` code.

---

## 3. What `init.ps1` does

| # | Action | Details |
|---|---|---|
| 1 | Finds the project root | Parent folder of `gemini-studio/`; otherwise the current directory. |
| 2 | Writes `GEMINI.md` in the root | A short "bridge" file: navigation links into `gemini-studio/` plus the mandatory Unity directives. |
| 3 | Writes `.agents/skills.json` | Points the assistant to `gemini-studio/.agents/skills`. |
| 4 | Writes `.agents/hooks.json` | Registers the 3 hooks (see [section 12](#12-hooks-automatic-safety-and-context)); each looks in `gemini-studio/.agents/hooks/` first. |
| 5 | Copies rules | `gemini-studio/.agents/rules/*` → `.agents/rules/` so path-scoped rules activate. |
| 6 | Scaffolds `Assets/Scripts` (conditional) | **Only if** `Assets/` exists **and** `Assets/Scripts/` does not. If `Assets/Scripts/` already exists, it is left alone. |

**What the scaffold creates** (only for new/blank projects):

```
Assets/
├── Scripts/
│   ├── Core/       Studio.Core.asmdef
│   ├── Gameplay/   Studio.Gameplay.asmdef   (references Studio.Core)
│   ├── UI/         Studio.UI.asmdef         (references Studio.Core)
│   └── Data/       .gitkeep                 (for ScriptableObject assets)
└── Tests/
    ├── Editor/     Studio.Tests.Editor.asmdef
    └── Runtime/    Studio.Tests.Runtime.asmdef
```

---

## 4. Your first session

Type `/start`. The studio first inspects your project silently (engine configured? concept document? source code? prototypes? sprints?) and then asks where you are:

| Your answer | What happens |
|---|---|
| **No idea yet** | Routes to `/brainstorm open` to explore themes and mechanics. |
| **Vague idea** | Asks for your theme/inspirations, then `/brainstorm [hint]`. |
| **Clear concept** | Either formalize it with `/brainstorm`, or go straight to `/setup-engine` + `/design-system`. |
| **Existing work** | Reports what it found; runs `/setup-engine` if needed; suggests briefs or retrofitting GDDs. |

It then asks you to choose a **rigor level** (`minimal`, `standard`, `full`), records it in `project.yaml`, updates the session checkpoint and tells you the single next command to run.

Lost at any point? Type `/help` — it tells you what to do next based on the project state.

---

## 5. How the studio works

### Collaboration protocol
Every significant task follows five steps, and nothing is written without your approval:

1. **Question** — the studio asks clarifying questions first.
2. **Options** — 2–3 options with pros/cons.
3. **Decision** — you choose.
4. **Draft** — it shows the work in progress before saving.
5. **Approval** — you confirm before files are written or stories closed.

(`project.yaml` → `modes.automation` controls how much it asks: `collaborative` always asks.)

### Roles delegate by tier
Directors set vision, leads own a department, specialists implement. Skills like `/team-combat` or `/team-qa` coordinate several roles on one goal.

### Session memory
`gemini-studio/production/session-state/active.md` is the project's memory checkpoint. A hook injects the current task from it into each invocation, so context survives restarts.

---

## 6. The 74 skills (slash commands)

Type the command in the chat. Descriptions below are summaries of each skill's purpose.

### Onboarding and navigation
| Skill | Purpose |
|---|---|
| `/start` | Guided onboarding; diagnoses project state and routes you. |
| `/help` | "What should I do next?" |
| `/onboard` | Onboarding doc for a new contributor or agent. |
| `/setup-engine` | Configure engine, version and code root in `project.yaml`. |
| `/settings` | View or change project config. |
| `/project-stage-detect` | Detect development stage, identify gaps, recommend next steps. |
| `/adopt` | Brownfield audit: do existing artifacts actually work? Numbered migration plan. |
| `/gate-check` | Ready to advance to the next phase? PASS / CONCERNS / FAIL. Advisory only. |

### Concept and design
| Skill | Purpose |
|---|---|
| `/brainstorm` | Guided concept ideation (MDA, player psychology, creative director input). |
| `/prototype` | Throwaway concept prototype → PROCEED / PIVOT / KILL. |
| `/art-bible` | Author the visual identity document. |
| `/map-systems` | Decompose the concept into systems, map dependencies, create the systems index. |
| `/design-system` | Section-by-section GDD for one system (mechanics, formulas, acceptance criteria). |
| `/quick-design` | Lightweight spec for small changes; skips a full GDD. |
| `/design-review` | Review one design document for completeness and implementability. |
| `/review-all-gdds` | Cross-GDD review: contradictions, dominant strategies, pillar drift. |
| `/consistency-check` | Scan GDDs for cross-document conflicts. |
| `/propagate-design-change` | A GDD changed — find ADRs that are now stale. |
| `/balance-check` | Find balance outliers and degenerate strategies in formulas/data. |
| `/content-audit` | Planned content (GDDs) vs. what is actually implemented. |

### Architecture
| Skill | Purpose |
|---|---|
| `/create-architecture` | Architecture blueprint before code is written. |
| `/architecture-decision` | Create an ADR (context, alternatives, consequences). |
| `/architecture-review` | Traceability matrix GDD requirements → ADRs; finds gaps and conflicts. |
| `/create-control-manifest` | Flat must-do / never-do rules per system, extracted from accepted ADRs. |

### UX and visual
| Skill | Purpose |
|---|---|
| `/ux-design` | UX spec for a screen, flow or HUD. |
| `/ux-review` | Validate UX spec / HUD design (accessibility, GDD alignment). |
| `/asset-spec` | Per-asset visual specs plus AI generation prompts. |
| `/asset-audit` | Audit assets against naming, size and format standards. |

### Production and planning
| Skill | Purpose |
|---|---|
| `/create-epics` | Turn GDDs + architecture into epics (one per module). |
| `/create-stories` | Break an epic/GDD into small implementable stories with acceptance criteria. |
| `/story-readiness` | Is a story implementation-ready? READY / NEEDS WORK / BLOCKED. |
| `/sprint-plan` | New or updated sprint plan. |
| `/sprint-status` | Quick sprint snapshot. |
| `/estimate` | Effort estimate with confidence levels. |
| `/scope-check` | Detect scope creep against the original plan. |
| `/milestone-review` | Milestone progress, risk, go/no-go. |
| `/retrospective` | Sprint or milestone retrospective. |
| `/vertical-slice` | End-to-end build to validate the full loop before Production. |

### Development and code quality
| Skill | Purpose |
|---|---|
| `/dev-story` | Implement a story: architecture proposal, decoupled code, unit tests, run-and-observe verification. |
| `/story-done` | End-of-story review: criteria, GDD/ADR deviations, code review, status update. |
| `/code-review` | Architectural review (standards, SOLID, testability, performance). |
| `/tech-debt` | Track and prioritize technical debt. |
| `/perf-profile` | Find bottlenecks, measure against budgets. |
| `/reverse-document` | Generate missing design/architecture docs from existing code. |

### QA and testing
| Skill | Purpose |
|---|---|
| `/qa-plan` | QA plan for a sprint (Logic / Integration / Visual / UI classification). |
| `/test-setup` | Scaffold the test framework and CI (once, before the first sprint). |
| `/test-helpers` | Generate engine-specific test helper libraries. |
| `/smoke-check` | Critical-path smoke gate before QA hand-off. |
| `/regression-suite` | Map test coverage to GDD critical paths; find untested fixed bugs. |
| `/test-evidence-review` | Quality review of tests and evidence. |
| `/test-flakiness` | Find flaky tests from CI logs. |
| `/soak-test` | Extended-play test protocol (leaks, fatigue, edge cases). |
| `/playtest-report` | Structured playtest report. |
| `/bug-report` | Structured bug report or code analysis for potential bugs. |
| `/bug-triage` | Re-prioritize open bugs, surface trends. |
| `/security-audit` | Save tampering, cheats, network exploits, data exposure. |

### Release and live operations
| Skill | Purpose |
|---|---|
| `/release-checklist` | Pre-release verification. |
| `/launch-checklist` | Launch readiness across all departments. |
| `/changelog` | Changelog from git commits and sprint data. |
| `/patch-notes` | Player-facing patch notes. |
| `/hotfix` | Emergency fix with audit trail. |
| `/day-one-patch` | Focused patch for known issues after gold master. |
| `/localize` | Localization pipeline (string extraction, review, VO, RTL). |

### Team orchestration (multi-role)
| Skill | Roles coordinated |
|---|---|
| `/team-combat` | game-designer, gameplay-programmer, ai-programmer, technical-artist, sound-designer, qa-tester |
| `/team-level` | level-designer, narrative-director, world-builder, art-director, systems-designer, qa-tester |
| `/team-narrative` | narrative-director, writer, world-builder, level-designer |
| `/team-audio` | audio-director, sound-designer, technical-artist, gameplay-programmer |
| `/team-ui` | UX pipeline: authoring, visual design, implementation, review, polish |
| `/team-polish` | performance-analyst, technical-artist, sound-designer, qa-tester |
| `/team-qa` | qa-lead, qa-tester: full testing cycle |
| `/team-release` | release-manager, qa-lead, devops-engineer, producer |
| `/team-live-ops` | live-ops-designer, economy-designer, analytics-engineer, community-manager, writer |

### Maintaining the studio itself
| Skill | Purpose |
|---|---|
| `/skill-test` | Validate skill files (static linter, spec, rubric, audit). |
| `/skill-improve` | Improve a skill via a test-fix-retest loop. |

---

## 7. The 49 roles

Role definitions live in `gemini-studio/.agents/agents/` (one `.md` per role).

**Tier 1 — Directors:** creative-director · technical-director · producer

**Tier 2 — Leads:** game-designer · lead-programmer · art-director · audio-director · narrative-director · qa-lead · release-manager · localization-lead

**Tier 3 — Specialists:** gameplay-programmer · engine-programmer · ai-programmer · network-programmer · tools-programmer · ui-programmer · systems-designer · level-designer · economy-designer · technical-artist · sound-designer · writer · world-builder · ux-designer · prototyper · performance-analyst · devops-engineer · analytics-engineer · security-engineer · qa-tester · accessibility-specialist · live-ops-designer · community-manager

**Engine specialists:**
- **Unity:** unity-specialist · unity-dots-specialist · unity-addressables-specialist · unity-ui-specialist · unity-shader-specialist
- **Godot:** godot-specialist · godot-gdscript-specialist · godot-csharp-specialist · godot-gdextension-specialist · godot-shader-specialist
- **Unreal:** unreal-specialist · ue-gas-specialist · ue-blueprint-specialist · ue-replication-specialist · ue-umg-specialist

> GCGS is configured and tested for **Unity**. Godot and Unreal roles are included from the original framework but this setup targets Unity.

---

## 8. Development pipeline (7 phases)

Defined in `docs/workflow-catalog.yaml`, which `/help` and `/gate-check` read to know where you are. Each phase has required and optional steps; gates are **advisory** — you always decide whether to advance.

```
Concept → Systems Design → Technical Setup → Pre-Production → Production → Polish → Release
```

Typical path through the first phases:

```
/brainstorm → /setup-engine → /art-bible → /map-systems
   → /design-system (per system) → /design-review → /review-all-gdds
   → /create-architecture → /architecture-decision → /create-epics → /create-stories
   → /sprint-plan → /dev-story → /story-done → /smoke-check → /gate-check
```

---

## 9. Using GCGS on an existing project (brownfield)

GCGS is non-intrusive: no code, scenes or packages are overwritten.

1. Copy `gemini-studio/` and run `init.ps1` (it leaves an existing `Assets/Scripts/` untouched).
2. `/start` → choose **Existing work**. The studio scans your code and estimates your stage.
3. `/adopt` — audits what you have against studio standards and produces a prioritized, non-blocking migration plan.
4. `/reverse-document design Assets/Scripts/Gameplay/Combat` — writes a GDD from your existing code.
5. `/reverse-document architecture Assets/Scripts/Core` — drafts ADRs from your existing architecture.
6. Continue with `/quick-design`, `/create-stories`, `/dev-story`. Before committing, `/code-review` and `/regression-suite` protect existing mechanics.

---

## 10. Mandatory Unity directives

These are enforced by `GEMINI.md`, the rules and the skills:

1. **Unity Hub genesis** — the project is created from Unity Hub. The studio verifies `ProjectSettings/ProjectVersion.txt` before writing code.
2. **No direct package manifest edits** — the AI never edits `Packages/manifest.json`. It tells you the exact package name, waits for you to install it in `Window > Package Manager`, then verifies read-only.
3. **Data-driven gameplay** — all gameplay values live in `ScriptableObject` assets (`Assets/Scripts/Data/`).
4. **Decoupled architecture** — UI views never own game state; communication is through C# events/observables.
5. **Run and observe** — visual/gameplay features are not done until tested at runtime; save a screenshot in `gemini-studio/production/qa/evidence/`.

---

## 11. Coding rules applied automatically

Rules in `.agents/rules/` are scoped by path, so they apply only where relevant.

| Rule file | Applies to | Highlights |
|---|---|---|
| `engine-standards.md` | `Assets/Scripts/**` | `[SerializeField] private` over public fields; `.asmdef` per subsystem; cache `GetComponent` in `Awake/OnEnable`; no `SendMessage`/`BroadcastMessage`; naming (`PascalCase`, `_camelCase`, `IInterface`). |
| `gameplay-code.md` | `Assets/Scripts/Gameplay/**` | No magic numbers; `Time.deltaTime` / `fixedDeltaTime`; gameplay never calls UI directly; zero allocations in `Update`/`FixedUpdate` (no LINQ, no string concat, `RaycastNonAlloc`); object pooling. |
| `ui-code.md` | `Assets/Scripts/UI/**` | Views are read-only observers of state; no hardcoded player-facing strings (use Localization); keyboard/gamepad/mouse navigation; separate dynamic/static Canvases; disable unneeded Raycast Targets. |

---

## 12. Hooks (automatic safety and context)

Registered in `.agents/hooks.json` by `init.ps1`. They run as PowerShell scripts from `gemini-studio/.agents/hooks/`.

| Hook | Event | Script | Behavior |
|---|---|---|---|
| `gcgs-safety-gate` | Before `run_command` | `validate-command.ps1` | Asks for confirmation on `git push --force`, `git reset --hard`, `git clean -f`, and deleting `.git`. Also asks when a `git commit` message is just `wip`, `fix`, `update` or `temp` (suggests referencing a story ID). Falls back to *allow* if it cannot parse input. |
| `gcgs-session-checkpoint` | Before every model invocation | `session-context.ps1` | Reads `**Current task:**` from `production/session-state/active.md` and injects `GCGS Active Task: …` into the context. |
| `gcgs-asset-validator` | After file writes/edits | `validate-file.ps1` | Currently a placeholder: returns `{}` (no validation performed yet). |

---

## 13. Configuration (`project.yaml`)

```yaml
engine:
  name: Unity
  version: "6000.0"        # Unity 6 LTS
  language: "C#"
  code_root: "Assets/Scripts"

modes:
  rigor: minimal            # minimal | standard | full
  automation: collaborative # collaborative | semi-autonomous | autonomous
  review_mode: solo         # solo | lean | full

testing:
  strict: false             # true = missing test/visual evidence blocks progression

directories:                # all relative to the Unity project root
  studio_root: "gemini-studio"
  code: "Assets/Scripts"
  design: "gemini-studio/design"
  docs: "gemini-studio/docs"
  production: "gemini-studio/production"
  tests: "Assets/Tests"
  evidence: "gemini-studio/production/qa/evidence"
```

**Rigor levels**

| Level | Intended for | Effect |
|---|---|---|
| `minimal` (default) | Game jams, prototypes | 1-page lean brief, solo lead review, fast iteration. |
| `standard` | Indie production | 5 required GDD sections, ADRs, standard QA evidence. |
| `full` | Commercial release | 8 required GDD sections, all director reviews, full regression suite. |

**Automation:** `collaborative` always asks before writing; `semi-autonomous` and `autonomous` ask less.
**Review mode:** `solo` (lead only) · `lean` (one director) · `full` (all directors).

---

## 14. Folder reference

```
gemini-studio/                         ← the portable studio
├── README.md                          this file
├── GEMINI.md                          master studio instructions
├── project.yaml                       configuration
├── init.ps1                           setup script
├── .agents/
│   ├── agents/                        49 role definitions
│   ├── skills/                        74 skills (one folder each, with SKILL.md)
│   ├── rules/                         3 path-scoped coding rules
│   ├── hooks/                         validate-command / session-context / validate-file
│   └── hooks.json                     hook definitions (the one used at runtime is the root .agents/hooks.json created by init.ps1)
├── design/gdd/                        Game Design Documents and briefs
├── docs/
│   ├── workflow-catalog.yaml          the 7-phase pipeline definition
│   ├── templates/                     39 document templates
│   ├── engine-reference/unity/        Unity 6 version notes, deprecated APIs
│   └── architecture/                  ADRs (empty until you create them)
├── production/
│   ├── session-state/active.md        session memory checkpoint
│   ├── sprints/                       sprint plans
│   └── qa/evidence/                   screenshots, logs, test evidence
└── prototypes/                        isolated experimental mechanics
```

Your game's work products (GDDs, ADRs, sprint plans, evidence, checkpoint) are created **inside the `gemini-studio/` copy in your project**, so each Unity project has its own independent state.

---

## 15. Templates and reference docs

**39 templates** in `docs/templates/` cover, among others: game concept, game brief, pitch, pillars, GDD, level design, narrative character sheet, faction design, economy model, difficulty curve, player journey, systems index, art bible, sound bible, UX spec, HUD design, interaction pattern library, accessibility requirements, architecture decision record, technical design document, architecture traceability, test plan, test evidence, sprint plan, milestone definition, risk register entry, prototype report, vertical slice report, release checklist, release notes, changelog, incident response, post-mortem, project stage report, session state, and a skill contract template.

**Unity engine reference** (`docs/engine-reference/unity/`): target Unity 6 LTS (6000.0+), C# 10/12, URP, new Input System, UI Toolkit/UGUI; deprecated APIs to avoid (`UnityEngine.Input`, `Resources.Load`, `FindObjectOfType`, UNet, `WWW`).

---

## 16. Known limitations

- `validate-file.ps1` does nothing yet (placeholder).
- `docs/architecture/` starts empty; ADRs appear as you create them.
- Engine reference docs exist only for Unity.
- `init.ps1` is PowerShell (Windows). Hooks call `powershell.exe`.
- Packages are never installed automatically; you install them in the Unity Package Manager.

---

## 17. Credits and license

GCGS is an adaptation of **[Claude Code Game Studios (CCGS)](https://github.com/Donchitos/Claude-Code-Game-Studios)** by **[Donchitos](https://github.com/Donchitos)**. The 49-agent hierarchy, 7-phase pipeline, collaboration protocol and foundational skills/templates come from the original project; this version adapts them to Gemini / Antigravity with native Windows hooks, `.agents/` customizations and Unity 6 LTS scaffolding.

If you find it valuable, please support the original creator: [Buy Me a Coffee](https://www.buymeacoffee.com/donchitos3) · [GitHub Sponsors](https://github.com/sponsors/Donchitos)

Licensed under the [MIT License](LICENSE).
