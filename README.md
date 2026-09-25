# My Unity Game

> Developed with **Unity 6 LTS (C#)** and powered by **[Gemini Code Game Studio](gemini-studio/README.md)**.

---

## Overview

This repository contains a Unity game project integrated with the **Gemini Code Game Studio (GCGS)** multi-agent development framework.

- **Engine Version**: Unity 6 LTS (6000.0+)
- **Render Pipeline**: Universal Render Pipeline (URP)
- **Primary Language**: C# 10 / 12
- **Studio Infrastructure**: Encapsulated in [`gemini-studio/`](gemini-studio/README.md)

---

## Project Structure

```
00 Gemini Code Game Studio/
├── Assets/                        # Game source code, scenes, prefabs, assets
│   ├── Scripts/                   # Modular C# scripts (.asmdef)
│   │   ├── Core/                  # Base utilities, interfaces, singletons
│   │   ├── Gameplay/              # Game systems, entities, state machines
│   │   ├── UI/                    # UI views & presenters (UI Toolkit / UGUI)
│   │   └── Data/                  # ScriptableObject data assets
│   └── Tests/                     # NUnit test suites (Editor & Runtime)
├── Packages/                      # Unity Package Manager dependencies
├── ProjectSettings/               # Unity engine project settings
├── GEMINI.md                      # AI studio bridge file
├── .gitignore                     # Unity repository gitignore
└── gemini-studio/                 # Encapsulated Game Development Studio
    ├── README.md                  # Studio framework documentation & cheatsheet
    ├── project.yaml               # Studio configuration
    ├── .agents/                   # 49 Agents, 74 Skills, Rules & Hooks
    ├── design/                    # GDDs, narrative bibles & mechanics
    ├── docs/                      # Architecture, ADRs, templates
    └── production/                # Sprints, session checkpoint & QA evidence
```

---

## AI Studio Workflows

All game development workflows, specialist agent roles, and design bibles are managed by Gemini Code Game Studio inside `gemini-studio/`.

To interact with the studio, use slash commands in your AI pair-programming session:
- `/start` — Guided onboarding and repository state diagnosis.
- `/brainstorm` — Game concept ideation and brief authoring.
- `/design-system <name>` — System GDD authoring with formulas and edge cases.
- `/create-stories <epic>` — Break systems into single-session developer stories.
- `/dev-story <path>` — Implement code with architecture proposals, unit tests, and visual QA.

For complete studio documentation and guidelines, refer to **[`gemini-studio/README.md`](gemini-studio/README.md)**.
