---
name: setup-engine
description: "Configure the target game engine (Unity, Godot, Unreal), version, code root directory, and conventions in project.yaml."
---

# Engine Setup (`/setup-engine`)

This skill configures the target game engine for the studio, pins the engine version, sets up directory conventions, and maps specialist programmer roles.

---

## 1. Parse Arguments

- `/setup-engine unity [version]` — Set engine to Unity (e.g. `6000.0` for Unity 6 LTS).
- `/setup-engine godot [version]` — Set engine to Godot (e.g. `4.6`).
- `/setup-engine unreal [version]` — Set engine to Unreal Engine (e.g. `5.5`).
- `/setup-engine` (no arguments) — Interactive guided engine selection.

---

## 2. Interactive Selection (When no engine specified)

If no argument is passed:

1. **Prior Experience**:
   - Use `ask_question`: "Which game engine do you have experience with, or prefer for this project?"
   - Options:
     - `(Recommended) Unity` — Industry standard for 2D/3D, C#, rich asset ecosystem, excellent multiplatform support.
     - `Godot 4` — Lightweight, open source, GDScript / C#, outstanding 2D and stylized 3D.
     - `Unreal Engine 5` — High-fidelity 3D, C++ / Blueprints, Nanite & Lumen, built for large-scale games.

2. **Target Platform Validation**:
   - Mobile / PC / Console / Web.
   - Clarify language preferences (`C#`, `GDScript`, `C++`).

---

## 3. Configure Engine Settings in `project.yaml`

Once the engine is selected, write or update the `engine` block in `project.yaml`:

### For Unity:
```yaml
engine:
  name: Unity
  version: "6000.0" # or specified version
  language: "C#"
  code_root: "Assets/Scripts"
  test_root: "Assets/Tests"
  specialists:
    primary: unity-specialist
    sub:
      dots: unity-dots-specialist
      shaders: unity-shader-specialist
      ui: unity-ui-specialist
      addressables: unity-addressables-specialist
```

### For Godot:
```yaml
engine:
  name: Godot
  version: "4.6"
  language: "GDScript" # or C#
  code_root: "src"
  test_root: "tests"
  specialists:
    primary: godot-specialist
    sub:
      csharp: godot-csharp-specialist
      gdextension: godot-gdextension-specialist
      shaders: godot-shader-specialist
```

### For Unreal Engine 5:
```yaml
engine:
  name: Unreal
  version: "5.5"
  language: "C++ / Blueprints"
  code_root: "Source"
  test_root: "Source/Tests"
  specialists:
    primary: unreal-specialist
    sub:
      gas: ue-gas-specialist
      blueprints: ue-blueprint-specialist
      replication: ue-replication-specialist
      umg: ue-umg-specialist
```

---

## 4. Scaffold Code Root

Ensure the target code directory exists (e.g. `Assets/Scripts` or `src/`) and contains an initial directory structure or `.gitkeep`.

Update `production/session-state/active.md` checkpoint:
- Record configured engine and code root.

---

## 5. Next Steps

Advise the developer on the immediate next step:
- If no game concept exists: `/brainstorm`
- If game concept exists: `/design-system` or `/map-systems`
