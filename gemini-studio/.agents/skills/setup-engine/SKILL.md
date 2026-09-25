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

## 4. Unity Genesis Verification & Package Guidance

### A. Unity Hub Genesis Verification
If Unity is selected:
1. Verify that `ProjectSettings/ProjectVersion.txt` exists at the repo root.
2. If it does NOT exist:
   - **PAUSE**: Instruct the user:
     > *"Before we begin writing code, please create this Unity project using **Unity Hub** (selecting your desired Unity 6 version and template). Once created, open this workspace folder in your IDE."*
   - Do NOT proceed to code scaffolding until the Unity project has been initialized by Unity Hub.

### B. STRICT Package Management Protocol
- **NEVER attempt to edit or write to `Packages/manifest.json`.**
- When a system requires a package (e.g., `com.unity.inputsystem`, `com.unity.addressables`, `com.unity.ui`):
  1. **Guide the User**: Provide the user with the exact package name, ID, and steps in Unity Editor:
     - Open Unity Editor: `Window > Package Manager`
     - Select `Packages: Unity Registry` (or Add package by name)
     - Install `[Package Name / ID]`
  2. **Pause for Confirmation**: Explicitly wait for the user: *"Please let me know once you have installed the package in Unity."*
  3. **Read-Only Verification**: Once the user confirms, read `Packages/manifest.json` (read-only) to verify the package is listed before proceeding to write scripts that rely on it.

---

## 5. Scaffold Code Root

Ensure the target code directory exists (e.g. `Assets/Scripts` or `src/`) and contains an initial directory structure with `.asmdef` files.

Update `production/session-state/active.md` checkpoint:
- Record configured engine and code root.

---

## 6. Next Steps

Advise the developer on the immediate next step:
- If no game concept exists: `/brainstorm`
- If game concept exists: `/design-system` or `/map-systems`
